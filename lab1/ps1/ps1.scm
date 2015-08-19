;;; ps1.scm
;;; You should start here when providing the answers to Problem Set 1.
;;; Follow along in the problem set, which is at:
;;; http://ai6034.mit.edu/fall06/index.php?title=Problem+set+1

(load "production.scm")
(require (lib "list.ss"))
(require (lib "pretty.ss"))

;;;; Section 1: Forward chaining ;;;;

;;; Problem 1.2: Multiple choice

;; Which part of a rule may change the data?
;;    1. the antecedent
;;    2. the consequent
;;    3. both

(define answer-1.2.0 '2)

;; A rule-based system about Monty Python's "Dead Parrot" sketch uses the following rules:
;;
(define rule1
  '(IF (AND ((? x) is a Norwegian Blue parrot)
            ((? x) is motionless))
       THEN ((? x) is not dead)))
;;
;; (define rule2
;;   '(IF (NOT ((? x) is dead))
;;        THEN ((? x) is pining for the fjords)))
;;
;; and the following initial data:
;;
;; '( (Polly is a Norwegian Blue parrot)
;;    (Polly is motionless))
;;

;; Will this system produce the datum (Polly is pining for the fjords)?
;; Answer 'yes or 'no.
(define answer-1.2.1a 'no)

;; Which rule contains a programming error? Answer 1 or 2.
(define answer-1.2.1b '2)

;; If you're uncertain of these answers, look in tester.scm for an explanation.


;; In a completely different scenario, suppose we have the following rules list:
;;
'((IF (AND ((? x) has feathers)  ;; rule 1
           ((? x) has a beak))
      THEN ((? x) is a bird))
  (IF (AND ((? y) is a bird)     ;; rule 2
           ((? y) cannot fly)
           ((? y) can swim))
      THEN ((? y) is a penguin)))
;;
;; and the following list of initial data:
;;
;; '((Pendergast is a penguin)
;;   (Pendergast has feathers)
;;   (Pendergast has a beak)
;;   (Pendergast cannot fly)
;;   (Pendergast can swim))
;;
;; In the following questions, answer 0 if neither rule does what is asked.
;; After we start the system running, which rule fires first?

(define answer-1.2.2 1)

;; Which rule triggers next after the first time a rule fires?

(define answer-1.2.3 1)

;; Which rule fires second?

(define answer-1.2.4 0) ; because (Pendergast is a penguin) consequent is already in data set


;;; Problem 1.3.1: Poker hands

;; You're given this data about poker hands:
(define poker-data
  '((two-pair beats pair)
    (three-of-a-kind beats two-pair)
    (straight beats three-of-a-kind)
    (flush beats straight)
    (full-house beats flush)
    (straight-flush beats full-house)))

;; Fill in this rule so that it finds all other combinations of which poker
;; hands beat which, transitively. For example, it should be able to deduce that
;; a three-of-a-kind beats a pair, because a three-of-a-kind beats two-pair, which
;; beats a pair.
(define transitive-rule
  '(IF (AND ((? z) beats (? y))
            ((? y) beats (? x))
       THEN ((? z) beats (? x)))))

; You can test your rule like this:
; (pretty-print (run-production-rules (list transitive-rule) poker-data))


;;; Problem 1.3.2: Family relations

;; First, define all your rules here individually. That is, give them names using
;; (define) statements. This way, you'll be able to refer to the rules by name
;; and easily rearrange them if you need to.


;; Then, put them together into a list in order, and call it family-rules.
(define family-rules (list))

;; Some examples to try it on:
(define simpsons-data
  '((male bart)
    (female lisa)
    (female maggie)
    (female marge)
    (male homer)
    (male abe)
    (parent marge bart)
    (parent marge lisa)
    (parent marge maggie)
    (parent homer bart)
    (parent homer lisa)
    (parent homer maggie)
    (parent abe homer)))

;; You can test your results by uncommenting this line:
; (pretty-print (run-production-rules family-rules simpsons-data))

(define black-data
  '((male sirius) (male regulus)
    (female walburga) (male alphard) (male cygnus)
    (male pollux)
    (female bellatrix) (female andromeda) (female narcissa)
    (female nymphadora) (male draco)
    
    (parent walburga sirius)
    (parent walburga regulus)
    (parent pollux walburga)
    (parent pollux alphard)
    (parent pollux cygnus)
    (parent cygnus bellatrix)
    (parent cygnus andromeda)
    (parent cygnus narcissa)
    (parent andromeda nymphadora)
    (parent narcissa draco)))

;; This should generate 14 cousin relationships, representing
;; 7 pairs of people who are cousins:
(define black-family-cousins
  (filter (lambda (x) (eq? (car x) 'cousin))
          (run-production-rules family-rules black-data)))

;; To see if you found them all, uncomment this line:
;(pretty-print black-family-cousins)

;;;; Section 2: Goal trees and backward chaining ;;;;

;;; Problem 2.1 is found in goaltree.scm.
;;; Problem 2.2 is found in backchain.scm.


;;;; Section 3: Survey ;;;;
;; Please answer this question inside the double quotes.

(define how-many-hours-this-pset-took "")
(define what-i-found-interesting "")
(define what-i-found-boring "")
