(declare-const coin1 Int)
(declare-const coin2 Int)
(declare-const coin3 Int)



(assert (and 
(or (= 20 (+ coin1 coin2 coin3)) (= 20 (+ coin1 coin1 coin2)) (= 20 (+ coin1 coin1 coin3)) (= 20 (+ coin2 coin2 coin1)) (= 20 (+ coin2 coin2 coin3)) (= 20 (+ coin3 coin3 coin1)) (= 20 (+ coin3 coin3 coin2))) 
(or (= 23 (+ coin1 coin2 coin3)) (= 23 (+ coin1 coin1 coin2)) (= 23 (+ coin1 coin1 coin3)) (= 23 (+ coin2 coin2 coin1)) (= 23 (+ coin2 coin2 coin3)) (= 23 (+ coin3 coin3 coin1)) (= 23 (+ coin3 coin3 coin2)))
(or (= 29 (+ coin1 coin2 coin3)) (= 29 (+ coin1 coin1 coin2)) (= 29 (+ coin1 coin1 coin3)) (= 29 (+ coin2 coin2 coin1)) (= 29 (+ coin2 coin2 coin3)) (= 29 (+ coin3 coin3 coin1)) (= 29 (+ coin3 coin3 coin2)))
))

(check-sat)
(get-model)