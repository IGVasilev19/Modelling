(declare-const X Int)
(declare-const Y Int)
(declare-const Z Int)
(declare-const N Int)
(declare-const B Int)
(declare-const P Int)

(assert (and (> X 0) (> Y 0) (> Z 0) (> B 0) (> P 0) (> N 0) (not(= X Y)) (not(= X Z)) (not(= Y Z)) (= (* N N) (+ X Y)) (= (* B B) (+ X Z)) (= (* P P) (+ Z Y))))

(check-sat)
(get-model)