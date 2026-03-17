; Part 1

;a)
; (declare-const p Int)
; (declare-const q Int)

; (assert (and (= 37 (+ p q)) (= 286 (* p q))))

; (check-sat)
; (get-model)

;b)
; (declare-const x Int)

; (assert (= 0 (+ (* x x) (* 115 x) 3066)))

; (check-sat)
; (get-model)

; c)
; (declare-const x Int)
; (declare-const y Int)

; (assert (= x 20))
; (assert (= y (- x (- y (/ x 2)))))

; (check-sat)
; (get-model)

;d)
; (declare-const n Int)
; (declare-const x Int)

; (assert (= n 29))
; (assert (and (> x 1) (and (= 0 (mod n x)) (not(= n x)))))

; (check-sat)

; e)
; (declare-const A Bool)
; (declare-const B Bool)

; (assert ( = true (and (not B) A (or (not A) B))))

; (check-sat)

; f)
; (declare-const A Bool)
; (declare-const B Bool)
; (declare-const C Bool)

; (assert (and (or A B) (or (not A) C) (not (or B C))))

; (check-sat)

; g)
; (declare-const A Bool)
; (declare-const B Bool)
; (declare-const C Bool)

; (assert (and (not B) (implies (not A) B) (implies A B)))

; (check-sat)

; h)
; (declare-const A Bool)
; (declare-const B Bool)
; (declare-const C Bool)

; (assert (and (not(implies B A)) (implies A B)))

; (check-sat)

; Part 2

; a)
; (declare-const A Bool)
; (declare-const B Bool)
; (declare-const C Bool)
; (declare-const D Bool)
; (declare-const N Int)

; (assert (= A true))
; (assert (= B true))
; (assert (= N (+ (ite A 1 0) (ite B 1 0) (ite C 1 0) (ite D 1 0))))

; (check-sat)
; (get-model)

; b)
; (declare-const X1 Int)
; (declare-const X2 Int)
; (declare-const X3 Int)
; (declare-const X4 Int)
; (declare-const X5 Int)

; (assert (and (not (and (= X1 X2) (= X1 X3) (= X1 X4) (= X1 X5))) (not (and (= X2 X3) (= X2 X4) (= X2 X5))) (not (and (= X3 X4) (= X3 X5))) (not (and (= X4 X5)))))

; (check-sat)
; (get-model)

; c)
; (declare-const A Bool)
; (declare-const B Bool)
; (declare-const C Bool)
; (declare-const D Bool)

; (assert (or (= A true) (= B true) (= C true) (= D true)))

; (check-sat)
; (get-model)