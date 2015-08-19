(require (lib "list.ss"))
(require (lib "string.ss"))

(define (pp x)
  (display x)
  (newline))

(define (test-file root . tests)
  (load root)
  (map load (reverse tests))
  'done)

(define ps:test-score #f)
(define ps:max-score #f)
(define ps:test-id #f)

(define (begin-test-suite)
  (set! ps:test-id 0)
  (set! ps:max-score 0)
  (set! ps:test-score 0))

(define (end-test-suite)
  (pp `(testing complete: score ,ps:test-score of ,ps:max-score)))

;; this is the normal test: it just checks whether two answers
;; are identical
(define (test points question answer)
  (meta-test points question answer equal?))

(define (test-short-answer points question)
  (meta-test points question "any non-empty string in double quotes"
             (lambda (x y)
               (and (string? x) (> (string-length x) 0)))))

;; when there are two or more valid answers to a question, this
;; test-function checks whether any of them are equal to the result
(define (multianswer-test points question answers)
  (meta-test points question answers member))

;; checks to see if two sets contain the same elements
(define (set-test points question answers)
  (meta-test points question answers equal-set?))

(define (any<? a b)
  (string<? (expr->string a) (expr->string b)))

(define (sort-any lst)
  (sort lst any<?))

;; tests if two lists contain the same elements
(define (equal-set? a b)
  (define (helper a b) ;; assumes lists
    (if a
	(let* ((del-b (delete (car a) b))
	       (del-a (delete (car a) a)))
	  (if (= (length del-b) (length del-a))
	      (helper del-a del-b)
	      #f))
	#t))
  (and (list? a) (list? b) (= (length a) (length b)) (helper a b)))

;; the test function does a safe evaluation of the student's
;; function, then checks to see if it's the right answer
;; by applying the answer-function to the result and a prototype
;; correct answer. This function should not be called directly,
;; but rather should be called by one of the four models above
(define (meta-test points question answer answer-function)
  (set! ps:test-id (+ ps:test-id 1))
  (set! ps:max-score (+ ps:max-score points))
  (newline)
  (display "Test case ") (display ps:test-id) (display " ") (display (list points (if (= points 1) 'point 'points))) (display ": ") (newline)
  (display question) (display " => ")
  (let* ((result (safe-eval question))
	 (succeed (answer-function result answer)))
    (if (exn:fail? result)
        (begin
          (display 'error) (display ": ")
          (display (exn-message result)) (newline)
          (display "*** Error. The result should have been:")
          (newline) (display answer) (newline)
          #f)
        (begin
          (display result) (newline)
          (if succeed
              (begin
                (set! ps:test-score (+ ps:test-score points))
                (display "Passed.") (newline))
              (begin
                (display "*** Failed. The result should have been:")
                (newline) (display answer) (newline)))
          succeed))))

;(define (test-subset points question answer)
;  (set! ps:test-id (+ ps:test-id 1))
;  (set! ps:max-score (+ ps:max-score points))
;  (newline)
;  (display "Test case ") (display ps:test-id) (display " ") (display (list points (if (= points 1) 'point 'points))) (display ": ") (newline)
;  (display question) (display " => ")
;  (let* ([result (safe-eval question)])
;    (let loop ([answers-left answer])
;      (if (nat (member (car answers-left) result))
;          (begin
;            (display "*** Failed. The result should have contained:"
  

;; for more complex checks for correctness, complex-test takes an
;; arbitrary lambda. This can be used, for example, in checking that
;; a function is no more than a certain length
(define complex-test meta-test)

;; safe-eval is like eval, but when an error occurs
;; in the function being evaluated, it returns "error" rather
;; than allowing the error to halt execution
;; NOTE: if people prefer, this could return the precise error instead
(define (safe-eval expression)
  (with-handlers ((exn:fail? (lambda (e) e)))
    (eval expression)))
