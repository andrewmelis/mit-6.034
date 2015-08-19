
;; Which part of a rule may change the data?
;;    1. the antecedent
;;    2. the consequent
;;    3. both

(define answer-1.2.0 'your-answer-here)

;; A rule-based system has the following rules:
;;
;; '(IF (AND ((? x) is a Norwegian Blue)
;;           ((? x) is pining for the fjords))
;;      THEN ((? x) is not deceased))
;; '(IF (NOT ((? x) is deceased)
;;      THEN ((? x) is not a stiff)
;; '(IF (NOT ((? x) is a stiff)
;;      THEN ((? x) is not bereft of life))
;;
;; and the following initial data:
;;
;; '( (Polly is a Norwegian Blue)
;;    (Polly is pining for the fjords))
;;
;; when the system reaches a steady state (no rules fire for one complete
;; cycle) what are the data?
;;
;;   1. '()
;;   2. '((Polly is not bereft of life))
;;   3. '((Polly is a Norwegian Blue)
;;        (Polly is pining for the fjords)
;;        (Polly is not deceased))
;;   4. '((Polly is a Norwegian Blue)
;;        (Polly is pining for the fjords)
;;        (Polly is not deceased)
;;        (Polly is not a stiff)
;;        (Polly is not bereft of life))

(define answer-1.2.1 'your-answer-here)

;; in a completely different scenario, suppose we have the following rules list:
;;
;; '((IF (AND((? x) has feathers)  ;; rule 1
;;           ((? x) has a beak))
;;       THEN ((? x) is a bird))
;;   (IF (AND((? y) is a bird)     ;; rule 2
;;           ((? y) cannot fly)
;;           ((? y) can swim))
;;       THEN ((? y) is a penguin)))
;;
;; and the following list of initial data:
;;
;; '((Pendergast is a penguin)
;;   (Pendergast has feathers)
;;   (Pendergast has a beak)
;;   (Pendergast cannot fly)
;;   (Pendergast can swim))
;;
;; in the following questions, answer 0 if neither rule does what is asked.
;; after we start the system running, which rule fires first?

(define answer-1.2.2 'your-answer-here)

;; which rule triggers second?

(define answer-1.2.3 'your-answer-here)

;; which rule fires second?

(define answer-1.2.4 'your-answer-here)

;; which rule triggers third?

(define answer-1.2.5 'your-answer-here)
