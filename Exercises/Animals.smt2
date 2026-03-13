(declare-const D Int)
(declare-const C Int)
(declare-const M Int)

(assert (and (= 400 (+ (* D 60) (* C 4) (* M 1))) (= 100 (+ D C M)) (> D 0) (> C 0) (> M 0)))

(check-sat)
(get-model)