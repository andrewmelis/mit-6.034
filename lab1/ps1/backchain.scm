(require (lib "list.ss"))
(require (lib "pretty.ss"))
(load "match.scm")
(load "production.scm")
(load "zookeeper.scm")
(load "goaltree.scm")

;; A helper function that tells you if an expression has any unknown variables
;; in it.
(define (has-variables? exp)
  (cond [(variable? exp) #t]
        [(not (pair? exp)) #f]
        [else (or (has-variables? (car exp)) (has-variables? (cdr exp)))]))

;; This function, which you need to write, takes in a hypothesis that can be determined
;; using a set of rules, and outputs a goal tree of which statements it would need to
;; test to prove that hypothesis. Refer to the problem set (section 2.1) for more
;; detailed specifications and examples.
(define (backchain-to-goal-tree rules hypothesis)
  'fill-me-in)

;; Here's an example of running the backward chainer - uncomment it to see it work:
; (pretty-print (backchain-to-goal-tree zoo-rules '(opus is a penguin)))
