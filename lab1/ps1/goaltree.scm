(require (lib "list.ss"))

;; Abstractions for working with nodes.

;; make-node: you can create an AND node of several statements with
;;   (make-node 'AND statements). It's really just cons, but it's an abstraction.
(define make-node cons)

;; node-type gives you back AND if it's an AND node, and OR if it's an OR node.
(define node-type car)

;; node-parts gives you a list of the subgoals (branches) of a node.
(define node-parts cdr)

;; Test if an expression is an AND node.
(define (AND-node? node)
  (and (pair? node) (eq? (car node) 'AND)))

;; Test if an expression is an OR node.
(define (OR-node? node)
  (and (pair? node) (eq? (car node) 'OR)))

;; Define some basic nodes. The empty AND represents unconditional success.
;; The empty OR represents unconditional failure.
(define empty-AND '(AND))
(define empty-OR '(OR))
(define *succeed* empty-AND)
(define *fail* empty-OR)

;; You need to write this function.
;; It takes in a goal tree and simplifies it, according to rules described
;; in the problem set.
;;
;; Example: (simplify '(AND (AND 3 4) (OR 5 6 (OR))))  => (AND 3 4 (OR 5 6))
(define (simplify node)
  'fill-me-in)
