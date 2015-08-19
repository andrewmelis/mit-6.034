(ns ps1.solutions)

(defn key-collision? [coll]
  (->> (map keys coll)
      flatten
      (apply (complement distinct?))))

(declare match)

(defn match-list [pattern datum]
  (let [results
        (->> (interleave pattern datum)
             (partition 2)
             (map #(match (first %) (last %)))
             flatten
             distinct)]
    (cond (some false? results) false
          (key-collision? results) false
          :else (apply merge results))))

(defn match [pattern datum]
  (cond (= pattern datum) {}
        (= :_ pattern) {}
        (keyword? pattern) {pattern datum}
        (every? sequential? [pattern datum])(match-list pattern datum)
        :else false))

(def poker-data
  '((two-pair beats pair)
    (three-of-a-kind beats two-pair)
    (straight beats three-of-a-kind)
    (flush beats straight)
    (full-house beats flush)
    (straight-flush beats full-house)))

(def small-poker-data
  '((two-pair beats pair)
    (three-of-a-kind beats two-pair)
    (straight beats three-of-a-kind)))

(def transitive-rule
  '(IF (AND (:z beats :y)
            (:y beats :x))
       (THEN (:z beats :x))))

(defn rule->antecedent [rule]
  (
  ;; (take-while #(not (THEN? %)) rule))

(defn rule->consequent [rule]
  (drop-while #(not (THEN? %)) rule))

;; (defn antecedent->pattern [antecedent]
;;   (drop-while #(not (IF? %)) rule))

(defn production-rule-system [rules data]
  "runs rules on data, outputs final state of data"
  (identity false))
