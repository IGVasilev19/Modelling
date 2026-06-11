(declare-fun f (Int) Int)

(assert
  (forall ((row Int))
    (implies (and (<= 1 row) (<= row 8))
        (and (<= 1 (f row))
             (<= (f row) 8)))))

(assert
  (forall ((r1 Int) (r2 Int))
    (implies (and (<= 1 r1) (<= r1 8)
             (<= 1 r2) (<= r2 8)
             (< r1 r2))
        (and
          (not (= (f r1) (f r2)))
          (not (= (- (f r1) r1) (- (f r2) r2)))
          (not (= (+ (f r1) r1) (+ (f r2) r2))))
        )))

(check-sat)
(get-value ((f 1) (f 2) (f 3) (f 4) (f 5) (f 6) (f 7) (f 8)))