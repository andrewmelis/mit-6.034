(load "match.scm")

;; An extended pattern matcher, to be used in a production rule system.
;; This can match boolean combinations (using AND, OR, and NOT) of patterns.
;; You do *not* need to modify or even understand this code to do the 6.034
;; problem set! It should just be there in the background, making things work.

;; If, however, you're a 6.034 TA, this description may be useful.
;; This is all written in continuation passing style, in order to use
;; generator-like procedures in Scheme. If you're unfamiliar with CPS and
;; trying to twiddle with this code, the basic idea is that these procedures
;; "return" results by passing them on to the next procedure, which is named 
;; "cont".
;; -- Rob

;; In this system, you backtrack by purposefully not calling a continuation.
;; It doesn't matter what you do instead. So I'll make a do-nothing function 
;; called (no-results).
(define no-results void)

;; This is a function you can use externally to match a pattern against data.
;; It takes in a pattern, data, and bindings, and returns all the data that
;; can match. Failure is indicated by the empty list.
(define (match-all pattern data bindings)
  (let ((results ()))
    (multi-match pattern data bindings
                 (lambda (matched-bindings)
                   (set! results (cons (substitute pattern matched-bindings) results))))
    (reverse results)))

(define (multi-match pattern data bindings cont)
  ;; multi-match: matches a boolean pattern against a list of data. If the
  ;; pattern is an AND of two patterns, for example, it requires that there 
  ;; exist two pieces of data (not necessarily distinct), each one matching one
  ;; of the patterns.
  ;;
  ;; Arguments:
  ;;   pattern: the pattern or combination of patterns to look for.
  ;;   data: the data to look in.
  ;;   bindings: the variables that have been bound so far.
  ;;   cont: the continuation, a function which will be called with the 
  ;;         bindings of every successful result.
  ;; Returns nothing. That's why you need to give a continuation.
  (if (not (list? pattern))
      (raise (list "Antecedents in production rules have to be lists. This isn't one:" pattern))
      
      (case (car pattern)
        
        ; If we have an AND expression, use chain-match to find a set of
        ; bindings that consistently matches all of them.
        ((AND) (chain-match (cdr pattern) data bindings cont))
        
        ; If we have an OR expression, find all the sets of bindings that match
        ; any of them.
        ((OR) (disjunctive-match (cdr pattern) data bindings cont))
        
        ; To make NOT work, we use let/cc (syntactic sugar for call/cc) to
        ; escape without yielding a result if we find a result when matching
        ; the inner expression.
        ((NOT) (let/cc escape
                 (multi-match (cadr pattern) data bindings
                              (lambda (result) (escape (no-results))))
                 ; If we got to this point, then we never escaped, so the
                 ; multi-match never succeeded. This means the NOT succeeds.
                 (cont bindings)))
        
        ((MATCH) (let ((match-bindings (do-match (cadr pattern) (caddr pattern) bindings)))
                   (if match-bindings (cont match-bindings))))
        ; It's not a special pattern, so match it normally.
        (else (single-match pattern data bindings cont)))))

(define (single-match pattern data bindings cont)
  ;; Match a single pattern (with no booleans) against a body of data.
  ;; Takes the same arguments as multi-match, and returns nothing.
  (let loop ((remaining-data data))
    (if (null? remaining-data) (no-results)
        (let ((bindings (do-match pattern (car remaining-data) bindings)))
          (if bindings (cont bindings))
          (loop (cdr remaining-data))))))

(define (chain-match patterns data bindings cont)
  ;; Match a sequence of patterns, with each one using the bindings of the
  ;; previous match. As there may be multiple matches, this searches a tree
  ;; of possibilities.
  ;; Takes the same arguments as multi-match, and returns nothing.
  (if (null? patterns)
      (cont bindings)
      (multi-match (car patterns) data bindings
                   (lambda (matched-bindings)
                     (chain-match (cdr patterns) data matched-bindings cont)))))

(define (disjunctive-match patterns data bindings cont)
  ;; Match any of a list of patterns, all using independent bindings. This will
  ;; yield a result for every pattern in the list that matches.
  ;; Takes the same arguments as multi-match, and returns nothing.
  (if (null? patterns)
      (no-results)
      (begin
        (multi-match (car patterns) data bindings
                     (lambda (matched-bindings)
                       (cont matched-bindings)))
        (disjunctive-match (cdr patterns) data bindings cont))))
