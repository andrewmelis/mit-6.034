(ns lab0)

(def insane 2)

(defn cube [n]
  (* n n n))

(defn factorial [n]
  {:pre [(> n 0)]}
  (apply * (range 1 (inc n))))

(defn count-pattern [pattern coll]
  (let [candidates (partition (count pattern) 1 coll)]
    (count (filter #(= pattern %) candidates))))
