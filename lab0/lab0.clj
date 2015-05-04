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
        (every? sequential? [pattern datum]) (match-list pattern datum)
        :else false))
