(ns lab0)

(def insane 2)

(defn cube [n]
  (* n n n))

(defn factorial [n]
  {:pre [(> n 0)]}
  (apply * (range 1 (inc n))))
