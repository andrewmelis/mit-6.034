(ns lab0-test
  (:require [clojure.test :refer :all]
            [lab0 :as lab0]))

(deftest cube-tests
  (is (= 1000 (lab0/cube 10)))
  (is (= 1 (lab0/cube 1)))
  (is (= -125 (lab0/cube -5))))

(deftest factorial-tests
  (is (= 1 (lab0/factorial 1)))
  (is (= 120 (lab0/factorial 5)))
  (is (thrown? AssertionError (lab0/factorial 0)))
  (is (thrown? AssertionError (lab0/factorial -1))))
