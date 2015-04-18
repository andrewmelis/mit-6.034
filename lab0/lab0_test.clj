(ns lab0-test
  (:require [clojure.test :refer :all]
            [lab0 :as lab0]))

(deftest cube-tests
  (is (= 1000 (lab0/cube 10)))
  (is (= 1 (lab0/cube 1)))
  (is (= -125 (lab0/cube -5))))
