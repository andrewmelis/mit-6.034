;; First, some useful accessors for lists, which we'll use in building our
;; abstractions.
(define first car)
(define rest cdr)
(define second cadr)

;;; The bindings abstraction ;;;

;; We need to create data structures that will let us keep track of what
;; variables are bound to what values. A set of bindings will be represented
;; by a list whose first element is the symbol 'bindings, and whose remaining
;; elements are bindings.

;; A binding consists of a _key_, which is a variable name, and a _value_ that
;; that variable is bound to. We need to be able to extract these two parts.
(define (extract-key binding) (first binding))
(define (extract-value binding) (second binding))

;; At the beginning of a match, we need some bindings with nothing bound.
;; We'll call this *null-bindings*.
(define *null-bindings* '(bindings))

;; _Variable expressions_ are lists whose first element is ? and whose second
;; element is a variable name.

;; Test if something is a variable.
(define (variable? x)
  (and (pair? x) (eq? '? (first x))))

;; Get the name for a variable, given the variable expression (? var).
(define (variable-name x) (second x))

;; Test if something is the expression for the nameless variable.
(define (nameless-variable? x)
  (and (variable? x) (eq? (variable-name x) '_)))

;; Given a variable expression (of the form (? x), not just the name), 
;; this looks up the variable in a bindings expression.
(define (find-binding variable-expression bindings)
  (if (and bindings  ; This makes sure we're given bindings at all, not just #f.
	   (not (nameless-variable? variable-expression)))
    
    ;; If it's a nameless variable, don't look for the binding.  Otherwise, use
    ;; assoc to find the binding.  (assoc x y) looks for a list in y whose car
    ;; is x and returns that, which is just what we need.
    (assoc (variable-name variable-expression) 
	   ;; Skip the symbol at the beginning of the bindings list.
	   (rest bindings))
    #f))

;; We'll define an atom as anything that's not a pair (so it's not a list,
;; a tree, a variable, or whatever.) Atoms have no further structure to match,
;; so we just compare them for equality using equal?.
(define (atom? x) (not (pair? x)))

;; A helper function that takes an element and a list, and returns a new list
;; with the element added to the end.
(define (add-to-end elt lst)
  (append lst (list elt)))

;; add-binding adds a new binding for a variable to a bindings list.
(define (add-binding variable-expression datum bindings)
 (if (nameless-variable? variable-expression)
     ;; If it is a nameless variable, it matches anything but does not add bindings
     bindings
     ;; add a new binding, remembering that the car of the list is the symbol 'bindings
     (cons (first bindings)
	   (cons (list (variable-name variable-expression) datum)
		 (rest bindings)))))

;;; The Matcher ;;;

;; When we match a pattern against a datum, we'll do it by calling a
;; general-purpose helper function called "do-match", starting it out with
;; no bindings.
(define (match pattern datum) (do-match pattern datum *null-bindings*))

;; This is the main matching function. We're given a pattern, a datum that we'll
;; be matching against the pattern, and the bindings we've made so far.
;;
;; If there is no match, the function should return #f.
;; If there is a match, the function should return a bindings structure (see the
;; bindings abstraction above) that contains the bindings that make the match
;; work.

(define (do-match pattern datum bindings)
  ;; Dispatch to another function based on what we're matching.
  (cond
        ; If we get two empty lists, we've got a match without adding any
        ; bindings.
        ((and (null? pattern) (null? datum))
	 bindings)
        ; If they're both atoms, see if they match.
	((and (atom? pattern) (atom? datum))
         (match-atoms pattern datum bindings))
        ; If the pattern is a variable, match-variable will assign the
        ; variable to the appropriate value.
        ((variable? pattern)
         (match-variable pattern datum bindings))
        ; If they're both lists (tested with pair?), then we need to see whether
        ; the corresponding elements match.
        ((and (pair? pattern) (pair? datum))
         (match-lists pattern datum bindings))
	(else #f)))

;; Perhaps the easiest case for matching is when both the pattern and datum are
;; an atom. We only need to check if they're equal.
(define (match-atoms pattern datum bindings)
  ;;Are the pattern and datum the same?
  (if (equal? pattern datum)
      ;;If so, return the value of BINDINGS unchanged:
      bindings
      ;;Otherwise, return #f, indicating that we failed to match.
      #f))

;; match-variable
;; This is a function you need to write.
;;
;; The outline for what you need to do:
;; * If the variable is already bound in bindings, the result should be what
;;   you get when you use that bound value as the pattern instead of the
;;   variable. That way, a match that would try to assign incompatible values
;;   to the same variable will fail.
;; * Otherwise, return the bindings, with a new binding that binds this variable
;;   to the given value.
(define (match-variable variable-expression datum bindings)
  'fill-me-in)

;; match-lists
;; This is another function you need to write.
;;
;; Pattern and datum are both lists. You want to make sure that all the
;; corresponding pieces of the lists match. Remember that the cdr of a list
;; that's not empty is another list, so you should be able to use recursion
;; to make the job fairly simple.
;;
;; Also remember that functions like this one and do-match return a _new_ value
;; of bindings. After you match one piece, you should use the new value for
;; later matches, not the old one.
(define (match-lists pattern datum bindings)
  'fill-me-in)
