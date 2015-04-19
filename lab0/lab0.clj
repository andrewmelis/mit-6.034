(ns lab0.solutions
  (require [clojure.zip :as zip]))

(defn cube [n]
  (* n n n))

(defn factorial [n]
  {:pre [(> n 0)]}
  (apply * (range 1 (inc n))))

(defn count-pattern [pattern coll]
  (let [candidates (partition (count pattern) 1 coll)]
    (count (filter #(= pattern %) candidates))))

(defn expt [x n]
  (reduce * (repeat n x)))

(defn depth [exp]
  (cond (or (not (seq exp))
            (not (seq? exp))) 0
        (not (seq? (first exp))) (depth (rest exp))
        :else (inc (max (depth (first exp)) (depth (rest exp))))))

(defn tree-ref [tree coll]
  (reduce #(nth %1 %2) tree coll))
