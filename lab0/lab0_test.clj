(ns lab0.solutions-test
  (:require [clojure.test :refer :all]
            [lab0.solutions :as lab0]))

(deftest cube-tests
  (is (= 1000 (lab0/cube 10)))
  (is (= 1 (lab0/cube 1)))
  (is (= -125 (lab0/cube -5))))

(deftest factorial-tests
  (is (= 1 (lab0/factorial 1)))
  (is (= 120 (lab0/factorial 5)))
  (is (thrown? AssertionError (lab0/factorial 0)))
  (is (thrown? AssertionError (lab0/factorial -1))))

(deftest count-pattern-tests
  (is (= 2 (lab0/count-pattern '(2 3) '(1 2 3 2 3 4 3 4 5))))
  (is (= 1 (lab0/count-pattern '(1 '(2 3)) '(1 '(2 3) 2 3 1 '(2 3 4)))))
  (is (= 2 (lab0/count-pattern '(:a :b) '(:a :b :c :e :b :a :b :f))))
  (is (= 3 (lab0/count-pattern '(:a :b :a) '(:g :a :b :a :b :a :b :a)))))

(deftest expression-depth-tests
  (is (= 0 (lab0/depth '(x))))
  (is (= 1 (lab0/depth '((lab0/expt x 2)))))
  (is (= 2 (lab0/depth '(+ (lab0/expt x 2) (lab0/expt y 2)))))
  (is (= 4 (lab0/depth '(/ (lab0/expt x 5) (lab0/expt (- (lab0/expt x 2) 1) (/ 5 2)))))))
