(declare-fun jugCapacity(Int) Int)
(declare-fun contentsOfJugAtStep (Int Int) Int)
(declare-const N Int)


(define-fun checkJugNotEmpty ((jug Int) (time Int)) Bool
    (not (= (contentsOfJugAtStep jug (- time 1)) 0))
)

(define-fun jugNotFull ((jug Int) (time Int)) Bool
    (not (= (contentsOfJugAtStep jug (- time 1)) (jugCapacity jug)))
)

(define-fun persistJugContents ((jug Int) (time Int)) Bool
    (= (contentsOfJugAtStep jug time) (contentsOfJugAtStep jug (- time 1)))
)

(define-fun transferWater ((jugTransfer Int) (jugReceive Int) (time Int)) Bool
    (ite (< (- (jugCapacity jugReceive) (contentsOfJugAtStep jugReceive (- time 1))) (contentsOfJugAtStep jugTransfer (- time 1)))
        (and
            (=(contentsOfJugAtStep jugTransfer time) (- (contentsOfJugAtStep jugTransfer (- time 1)) (-(jugCapacity jugReceive) (contentsOfJugAtStep jugReceive (- time 1)))))
            (=(contentsOfJugAtStep jugReceive time) (+ (contentsOfJugAtStep jugReceive (- time 1)) (-(jugCapacity jugReceive) (contentsOfJugAtStep jugReceive (- time 1)))))
        )
        (and
            (=(contentsOfJugAtStep jugTransfer time) 0)
            (=(contentsOfJugAtStep jugReceive time) (+ (contentsOfJugAtStep jugReceive (- time 1)) (contentsOfJugAtStep jugTransfer (- time 1))))
        )
    )
)

(assert (>= N 0))
(assert (<= N 9))


(assert(= (jugCapacity 1) 8))
(assert(= (jugCapacity 2) 5))
(assert(= (jugCapacity 3) 3))


(assert (= (contentsOfJugAtStep 1 0) 8))
(assert (= (contentsOfJugAtStep 2 0) 0))
(assert (= (contentsOfJugAtStep 3 0) 0))

(assert
    (forall ((time Int))
        (=> (and (<= 1 time) (<= time N))
            (or
                (and
                    (checkJugNotEmpty 1 time)
                    (or
                        (and (jugNotFull 2 time) (transferWater 1 2 time) (persistJugContents 3 time))
                        (and (jugNotFull 3 time) (transferWater 1 3 time) (persistJugContents 2 time))
                    )
                )
                (and
                    (checkJugNotEmpty 2 time)
                    (or
                        (and (jugNotFull 1 time) (transferWater 2 1 time) (persistJugContents 3 time))
                        (and (jugNotFull 3 time) (transferWater 2 3 time) (persistJugContents 1 time))
                    )
                )
                (and
                    (checkJugNotEmpty 3 time)
                    (or
                        (and (jugNotFull 1 time) (transferWater 3 1 time) (persistJugContents 2 time))
                        (and (jugNotFull 2 time) (transferWater 3 2 time) (persistJugContents 1 time))
                    )
                )
            )
        )
    )
)


(assert
    (and
        (= (contentsOfJugAtStep 1 N) 4)
        (= (contentsOfJugAtStep 2 N) 4)
    )
)

(minimize N)

(check-sat)
(get-value (
  ; Step 0 - Initial state
  (contentsOfJugAtStep 1 0) (contentsOfJugAtStep 2 0) (contentsOfJugAtStep 3 0)

  ; Step 1
  (contentsOfJugAtStep 1 1) (contentsOfJugAtStep 2 1) (contentsOfJugAtStep 3 1)

  ; Step 2
  (contentsOfJugAtStep 1 2) (contentsOfJugAtStep 2 2) (contentsOfJugAtStep 3 2)

  ; Step 3
  (contentsOfJugAtStep 1 3) (contentsOfJugAtStep 2 3) (contentsOfJugAtStep 3 3)

  ; Step 4
  (contentsOfJugAtStep 1 4) (contentsOfJugAtStep 2 4) (contentsOfJugAtStep 3 4)

  ; Step 5
  (contentsOfJugAtStep 1 5) (contentsOfJugAtStep 2 5) (contentsOfJugAtStep 3 5)

  ; Step 6
  (contentsOfJugAtStep 1 6) (contentsOfJugAtStep 2 6) (contentsOfJugAtStep 3 6)

  ; Step 7 - Final state
  (contentsOfJugAtStep 1 7) (contentsOfJugAtStep 2 7) (contentsOfJugAtStep 3 7)
))