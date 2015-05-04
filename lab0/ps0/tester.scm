;; Public test cases for problem set 0
(load "tester-utils.scm")
(load "ps0.scm")

(begin-test-suite)

(begin
  ;; problem 1.2
  (test 1 'answer-1.2 2)
  
  ;; problem 2.1
  (test 1 '(cube 3) 27)
  (test 1 '(cube 17) 4913)
  (test 1 '(cube 32) 32768)
  (test 1 '(cube -1) -1)
  (test 1 '(factorial 0) 1)
  (test 1 '(factorial 3) 6)
  (test 1 '(factorial 4) 24)
  (test 1 '(factorial 6) 720)
  (test 1 '(count-pattern '(a b) '(a b c e b a b f)) 2)
  (test 1 '(count-pattern '(a b a) '(g a b a b a b a)) 3)
  (test 1 '(count-pattern '(a) '(a b a c e)) 2)
  (test 1 '(count-pattern '(b c) '(b a c v e b c)) 1)
  (test 1 '(count-pattern '(f f f) '(f f f f f f f)) 5)
  (test 1 '(count-pattern '(a a) '(a a a a a a a)) 6)
  
  ;; problem 2.2
  (test 1 '(depth 'x) 0)
  (test 1 '(depth '(expt x 2)) 1)
  (test 1 '(depth '(+ (expt x 2) (expt y 2))) 2)
  (test 1 '(depth '(/ (expt x 5) (expt (- (expt x 2) 1) (/ 5 2)))) 4)
  (test 1 '(depth '(/ (+ (- (/ (+ x 1) 2) 1) 6) 
                      (expt (- (expt x 2) 1) (/ 5 2)))) 5)
  
  ;; problem 2.3
  (define the-tree '(((1 2) 3) (4 (5 6)) 7 (8 9 10)))
  (test 1 '(tree-ref the-tree '(3 1)) 9)
  (test 1 '(tree-ref the-tree '(1 1 1)) 6)
  (test 1 '(tree-ref the-tree '(0)) '((1 2) 3))
  
  ;; problem 3
  (test 1 '(match '(1 2) '(1 3)) #f)
  (test 1 '(match '(a (? x) c) '(a b c)) '(bindings (x b)))
  (test 1 '(match '(a ((? x) c) d) '(a (b c) d)) '(bindings (x b)))
  (multianswer-test 1 '(match '(a ((? x) c) (? y)) '(a (b c) c)) '((bindings (y c) (x b)) (bindings (x b) (y c))))
  (test 1 '(match '(a (b c) d) '(a (b c) d)) '(bindings))
  (test 1 '(match '(a (? x) d) '(a () d)) '(bindings (x ())))
  (test 1 '(match '(a (? x) d) '(a b c e)) #f)
  (test 1 '(match '(a (? x) c (? x) e) '(a b c b e)) '(bindings (x b)))
  (test 1 '(match '(a (? x) c (? x) e) '(a b c d e)) #f)
  (test 1 '(match '(a (? _) c (? _) e) '(a b c b e)) '(bindings))

  ;; survey
  (test-short-answer 0 'when-i-took-6.001)
  (test-short-answer 0 'hours-per-6.001-project)
  (test-short-answer 0 'how-well-I-learned-6.001)
  (test-short-answer 0 'how-many-hours-this-pset-took)
  
  (end-test-suite))
