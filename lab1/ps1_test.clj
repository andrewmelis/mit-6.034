(ns ps1.solutions-test
  (require [clojure.test :refer :all]
           [ps1.solutions :refer :all]))

(deftest t-pattern-matching
  (testing "make sure the pattern matching works all along"
    (is (= {} (match '() '())))
    (is (= {} (match 'a 'a)))
    (is (false? (match 'a 'b)))
    (is (false? (match '(1 2) '(1 3))))
    (is (= {:x 'b} (match :x 'b)))
    (is (= {:x 'b} (match '(a :x c) '(a b c))))
    (is (= {:x 'b} (match '(a (:x c) d) '(a (b c) d))))
    (is (= {:x 'b :y 'c} (match '(a (:x c) :y) '(a (b c) c))))
    (is (= {} (match '(a (b c) d) '(a (b c) d))))
    (is (= {:x '()} (match '(a :x d) '(a () d))))
    (is (false? (match '(a :x d) '(a b c e))))
    (is (= {:x 'b} (match '(a :x c :x e) '(a b c b e))))
    (is (false? (match '(a :x c :x e) '(a b c d e))))
    (is (= {} (match '(a :_ c :_ e) '(a b c b e))))
    (is (= {} (match '(a :_ c :_ e) '(a b c d e))))
    (is (= {:x 'f} (match '(a :_ c :_ e :x) '(a b c d e f))))))

(def full-poker-output
  '((two-pair beats pair)
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
    (straight-flush beats pair)))

(def small-poker-output
  '((two-pair beats pair)
    (three-of-a-kind beats two-pair)
    (three-of-a-kind beats pair)))

(deftest t-rule->antecedent
  "tests extraction of antecedent from an input rule"
  (is (= '(IF (AND (:z beats :y) (:y beats :x)))
         (rule->antecedent transitive-rule))))

(deftest t-rule->consequent
  "tests extraction of consequent from an input rule"
  (is (= '(THEN (:z beats :x))
         (rule->consequent transitive-rule))))

;; (deftest t-antecedent->pattern
;;   "tests transformation of antecedent into pattern for match function"   ;; need another test for NOT
;;   (is (= '((:z beats :y) (:y beats :x))
;;          (antecedent->pattern '(IF (AND (:z beats :y) (:y beats :x)))))))

(deftest t-poker
  "tests output of poker rules"
  (is (= {:z 'two-pair :y 'pair} (match '(:z beats :y) '(two-pair beats pair))))
  (is (not= small-poker-output (production-rule-system transitive-rule small-poker-data))))
         
