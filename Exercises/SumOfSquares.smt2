(declare-const X Int)
(declare-const Y Int)
(declare-const N Int)
(declare-const M Int)

(assert (and (> X 0) (> Y 0) (> N 0) (> M 0) (= (+ (* N N)(* M M)) (* (+ (* X X)(* Y Y))2))))

(check-sat)
(get-model)