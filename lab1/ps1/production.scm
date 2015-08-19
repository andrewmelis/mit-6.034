(load "multimatch.scm")
(require (lib "list.ss"))

;; You can make the system display every rule that triggers or fires
;; by changing DEBUG to #t.
(define DEBUG #f)

;; A helper function for finding a part of a rule.
;; It's used in rule-antecedent, rule-consequent, and rule-delete, below.
(define (find-rule-part keyword default)
  (lambda (rule)
    (let ((chunk (memq keyword rule)))
      (if chunk
          (cadr chunk)
          default))))

;; The following functions let you extract parts of rules.

; The default antecedent is (AND), which always matches.
(define rule-antecedent (find-rule-part 'IF '(AND)))
; The default consequent is #f, which means to do nothing.
(define rule-consequent (find-rule-part 'THEN #f))
(define rule-delete (find-rule-part 'DELETE #f))

;;; PRODUCTION RULE SYSTEM
;; You don't need to understand this code.
(define (run-production-rules rules data) 
  (let ((newdata         ; Begin a block that we can jump out of at any time.
         (let/ec return  ; The block will return #f or the new value of data.
           (let loop ((remaining-rules rules))
             (if (empty? remaining-rules)
                 (return #f)
                 (let* ((rule (car remaining-rules))
                        (bindings '(bindings)))
                   (multi-match (rule-antecedent rule) data bindings
                                (lambda (bindings)
                                  (let ((newdata
                                         (transform-data rule data bindings)))
                                    (if newdata (return newdata)))))
                   (loop (cdr remaining-rules))))))))

    ; after the let/ec block returns data or #f, handle the result.
    ; If true, we matched a rule.
    (if newdata
        (if (not (member '(STOP) newdata))
            (run-production-rules rules newdata)
            (begin
              (if DEBUG
                  (begin
                    (display "Stopped.")
                    (newline)))
              newdata
              ))
   
        ; If false, we didn't match any rules, so we should stop.
        (begin
          (if DEBUG
              (begin
                (display "Stopping because no rules fired.")
                (newline)))
          data))))

; Take in a rule to fire, the data we have so far, and the bindings that made
; the rule match. If the data is changed, return the new version of the data;
; otherwise, return #f because the rule did not successfully fire.
;
; This function does *not* mutate the data. 
(define (transform-data rule data bindings)

  (let ((success #f)
        (newdata data)
        (consequent (substitute (rule-consequent rule) bindings))
        (to-delete (rule-delete rule)))
    (letrec ((delete-helper
           (lambda (data-left)
             (if (null? data-left) ()
                 (if (do-match to-delete (car data-left) bindings)
                     (begin
                       (set! success #t)
                       (cdr data-left)) ; skip the matching statement
                     
                     ; otherwise, cdr down the list
                     (cons (car data-left) (delete-helper (cdr data-left))))))))

      (if consequent
          (if (not (member consequent data))
              (begin
                (set! newdata (append data (list consequent)))
                (set! success #t))))
      (if to-delete
          (set! newdata (delete-helper newdata)))
      
      (if (and DEBUG success)
          (begin
            (display "Rule fired: ")
            (display rule)
            (newline)
            (display "  ") (display bindings) (newline)))
      
      ; Finally, return the new data if we succeeded
      (and success newdata))))
