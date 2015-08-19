;; Public test cases for problem set 1
(load "tester-utils.scm")
(load "ps1.scm")
(load "goaltree.scm")
(load "backchain.scm")

(begin-test-suite)

(begin
  ;; problem 1.2
  (test 1 'answer-1.2.0 2)  ; Only the consequent can change the data.
  
  ;; In problem 1.2.1, the given rules are buggy because of this clause:
  ;; '(IF (NOT ((? x) is dead)) ...
  ;;
  ;; It's intended to sound like it will match the clause (Polly is not dead),
  ;; but that's a trick of English. It knows nothing about matching the symbol
  ;; 'not before 'dead.
  ;;
  ;; In fact, the rule will trigger because there is, indeed, NOT any
  ;; datum matching ((? x) is dead). But it has no way to deduce from this
  ;; _lack of a datum_ that (? x) should be bound to 'Polly. It will instead
  ;; add nonsensical data containing an unbound variable.
  ;;
  ;; This illustrates both that you should not let the English interpretations of
  ;; match expressions deceive you, and that NOT clauses should not introduce
  ;; new variables.
  (test 1 'answer-1.2.1a 'no)
  (test 1 'answer-1.2.1b 2)
  (test 1 'answer-1.2.2 1)   ; Rule 1 fires first.  
  (test 1 'answer-1.2.3 1)   ; Rule 1 triggers again, though it can no longer fire.
  (test 1 'answer-1.2.4 0)   ; Neither rule can fire, because both consequents are already
                             ; in the data.
  
  ;; problem 1.3.1
  (test 1 '(sort-any (run-production-rules (list transitive-rule) poker-data))
        (sort-any '((two-pair beats pair)
                    (three-of-a-kind beats two-pair)
                    (straight beats three-of-a-kind)
                    (flush beats straight)
                    (full-house beats flush)
                    (straight-flush beats full-house)
                    (three-of-a-kind beats pair)
                    (straight beats two-pair)
                    (straight beats pair)
                    (flush beats three-of-a-kind)
                    (flush beats two-pair)
                    (flush beats pair)
                    (full-house beats straight)
                    (full-house beats three-of-a-kind)
                    (full-house beats two-pair)
                    (full-house beats pair)
                    (straight-flush beats flush)
                    (straight-flush beats straight)
                    (straight-flush beats three-of-a-kind)
                    (straight-flush beats two-pair)
                    (straight-flush beats pair))))
  
  ;; problem 1.3.2
  (test 2 '(sort-any (filter (lambda (datum)
                     (member (car datum) 
                             '(male female parent mother father son daughter brother sister cousin)))
                   (run-production-rules family-rules simpsons-data)))
        (sort-any
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
           (parent abe homer)
           (sister lisa bart)
           (brother bart lisa)
           (sister lisa maggie)
           (sister maggie lisa)
           (brother bart maggie)
           (sister maggie bart)
           (father homer bart)
           (mother marge bart)
           (father homer lisa)
           (mother marge lisa)
           (father homer maggie)
           (mother marge maggie)
           (son bart homer)
           (son bart marge)
           (daughter lisa homer)
           (daughter lisa marge)
           (daughter maggie homer)
           (daughter maggie marge)
           (father abe homer)
           (son homer abe))))
  
  (test 2 '(sort-any black-family-cousins)
        (sort-any
         '((cousin sirius bellatrix)
           (cousin sirius andromeda)
           (cousin sirius narcissa)
           (cousin regulus bellatrix)
           (cousin regulus andromeda)
           (cousin regulus narcissa)
           (cousin bellatrix sirius)
           (cousin bellatrix regulus)
           (cousin andromeda sirius)
           (cousin andromeda regulus)
           (cousin narcissa sirius)
           (cousin narcissa regulus)
           (cousin nymphadora draco)
           (cousin draco nymphadora))))

  ;; problem 2.1
  (test 1 '(simplify '(OR 1 2 (AND)))     '(AND))
  (test 1 '(simplify '(OR 1 2 (AND 3 (AND 4)) (AND 5)))  '(OR 1 2 (AND 3 4) 5))
  (test 1 '(simplify '(AND g1 (AND g2 (AND g3 (AND g4 (AND))))))  '(AND g1 g2 g3 g4))
  (test 1 '(simplify '(AND g))   'g)
  
  ;; problem 2.2
  (test 2 '(backchain-to-goal-tree zoo-rules '(opus is a penguin))
        '(AND
          (OR (opus has feathers) (AND (opus flies) (opus lays eggs)))
          (opus does not fly)
          (opus swims)
          (opus has black and white color)))

  (test 2 '(backchain-to-goal-tree zoo-rules '(tony is a tiger))
        '(AND
          (OR
           (AND (OR (tony has hair) (tony gives milk)) (tony eats meat))
           (AND
            (OR (tony has hair) (tony gives milk))
            (tony has pointed teeth)
            (tony has claws)
            (tony has forward-pointing eyes)))
          (tony has tawny color)
          (tony has black stripes)))
  
  (test 1 '(backchain-to-goal-tree zoo-rules '(bill eats meat))
        '(bill eats meat))
  
  (test-short-answer 0 'how-many-hours-this-pset-took)
  (test-short-answer 0 'what-i-found-interesting)
  (test-short-answer 0 'what-i-found-boring)
  
  (end-test-suite))
