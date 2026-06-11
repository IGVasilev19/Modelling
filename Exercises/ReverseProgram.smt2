(declare-fun f (Int) Int)
(declare-fun g (Int) Int)

(assert (forall ((i Int))
    (implies (and (<= 1 i) (<= i 10))
        (and
            (= (f (+ i 1)) (ite (> (f i) (g i)) (- (f i) 3)  (* 2 (f i))))
            (= (g (+ i 1)) (ite (> (f i) (g i)) (* 2 (g i)) (- (g i) 5)))
        )
    )
))

(assert (= (f 11) 1000))
(assert (= (g 11) 999))

(check-sat)
(get-value ((f 1) (g 1)))