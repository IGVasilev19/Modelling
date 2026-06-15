(declare-fun jugCapacity(Int) Int)
(declare-fun contentsOfJugAtStep (Int Int) Int)
(declare-const N Int)

;This checks if a jug is empty and will be used to check the transfer jug
;since the solver has to chekc if the jug it chosen to pour water from actually has water in it
(define-fun checkJugNotEmpty ((jug Int) (time Int)) Bool
    (not (= (contentsOfJugAtStep jug (- time 1)) 0))
)

;This checks if a jug is not full and we use it to check the reveiver jug
;since when the solver chooses a jug to pour to it has to know if that jug can
;actually take any water
(define-fun jugNotFull ((jug Int) (time Int)) Bool
    (not (= (contentsOfJugAtStep jug (- time 1)) (jugCapacity jug)))
)

;This function is used to persist the state of the jugs, since the solver
;doesn't keep any memory, but rather makes choices for the current step
(define-fun persistJugContents ((jug Int) (time Int)) Bool
    (= (contentsOfJugAtStep jug time) (contentsOfJugAtStep jug (- time 1)))
)

;We use this function to transfer water from one jug to another. It checks if the result from the substraction
;of the capacity and the current contents of the receiver jug is bigger than the contents of the transfer jar.
;If it is then the contents of the receiver become the current + the whole content of the transfer jug, which is then left at 0.
;Otherwise if the result from the substraction is smaller than the transfer contents, then we add the result of the substraction to the receiver
;and substract it from the transfer jug.
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

(assert (= N 7))


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
            ;at each step we have three options for a transfer jug:
            ;either we choose the 1,2 or the 3 jug to be the transferer
                (and
                ;For each transfer jug it has to be non-empty
                ;and it has to pour water into either one of the other jugs.
                    (checkJugNotEmpty 1 time)
                    (or
                    ;For each possible receiver jug, it has to verify that it is not full, and then it
                    ;transfers the water and persists the state of the other jug.
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
;The combination of action is correct, when after the last step
;jug 1 and jug 2 both have 4 liters of water.
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