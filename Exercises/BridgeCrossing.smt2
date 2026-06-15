;4 people in total
;The torch is needed when crossing
;At most two people at the same time
;The slower of the two people determine the pace
;Fastest way for all four to cross

;Each person is represented by the his number 1,2,3,4 (for A,B,C,D) and the time it takes him to cross the bridge
(declare-fun people (Int) Int)
;Status per person to keep track of who is on which side of the bridge
(declare-fun personCrossed (Int Int) Bool)
;First person chosen to cross
(declare-fun crosser1 (Int) Int)
;Second person chosen to cross
(declare-fun crosser2 (Int) Int)
;The time it took to cross at corresponding crossing
(declare-fun timeStepSum(Int) Int)
;Total time it took for all of them to cross
(declare-const sum Int)

;Initialize the four people
(assert (= (people 1) 10))
(assert (= (people 2) 5))
(assert (= (people 3) 2))
(assert (= (people 4) 1))

;Takes the step/crossing and the person number and checks if that person
;at that step is on the other side.
(define-fun isOnOppositeSide ((crossing Int) (person Int)) Bool
    (= (personCrossed crossing person) true)
)

;Determines the cost of the travel, checks which person from the crossing pair
;moves slower(has a higher crossing time) and saves that as the cost of the whole step.
(define-fun crossingCost ((crossing Int)) Bool
    (ite (> (people (crosser1 crossing)) (people (crosser2 crossing)))
        (= (timeStepSum crossing) (people (crosser1 crossing)))
        (= (timeStepSum crossing) (people (crosser2 crossing)))
    )
)

;Updates the state of all people after a return is complete. It sets the crossed state of the person who returned to false
;and persists the states of the rest of the people.
(define-fun updateStateAfterReturn ((crossing Int) (person Int)) Bool
    (= (personCrossed (+ crossing 1) person) (ite (= (crosser1 crossing) person) false (personCrossed crossing person)))
)

;Updates the state of all people after a cross is complete. It sets the crossed state of the people who from the pair that
;crossed to true and persists the states of the rest of the people.
(define-fun updateStateAfterCross ((crossing Int) (person Int)) Bool
    (= (personCrossed (+ crossing 1) person) (ite (or (= (crosser1 crossing) person) (= (crosser2 crossing) person)) true (personCrossed crossing person)))
)

(assert
  (forall ((crossing Int))
    ;In the best possible scenario all of them should have crossed in a total of 5 crossings,
    ;because if we imagine that they don't have a different speed and we have 4 people, 1st crossing
    ;2nd cross, 2 crossing 1 returns, 3rd crossing 2 cross, 4th crossing 1 returns and final 5th crossing two cross.
    (=> (and (<= 1 crossing) (<= crossing 5))
      ;We check if the number of the current crossing is even or odd. If it is odd that mean that the 'torch' is on the initial side of the bridge
      ;so two people should cross and if it is even then a person should be sent back with the torch so another pair can cross.
      (ite (= (mod crossing 2) 0)
        (and
        ;Selects the person who will return the torch, for each possible person 
        ;to be chosen it first checks if that person is already on the opposite site of the bridge.
            (or 
                (and (isOnOppositeSide crossing 1) (= (crosser1 crossing) 1))
                (and (isOnOppositeSide crossing 2) (= (crosser1 crossing) 2))
                (and (isOnOppositeSide crossing 3) (= (crosser1 crossing) 3))
                (and (isOnOppositeSide crossing 4) (= (crosser1 crossing) 4))
            )
            ;The time it took for each crossing is saved in a declare-fun timeStepSum,
            ;which maps the crossing to the time it took to complete it 
            ;For each person we either set the personCrossed to false if that was the chosen person
            ;to return, or we persist their current personCrossed state for the next crossing.
            (= (timeStepSum crossing) (people (crosser1 crossing)))
            (updateStateAfterReturn crossing 1)
            (updateStateAfterReturn crossing 2)
            (updateStateAfterReturn crossing 3)
            (updateStateAfterReturn crossing 4)
        )
        (and
            (or 
            ;It starts selecting the first person for the pair which will cross. First checks if the person is currently on the initial 
            ;side of the bridge, then if chosen, sets the personCrossed state for the next crossing to true.
                (and (not(isOnOppositeSide crossing 1)) (= (crosser1 crossing) 1)) 
                (and (not(isOnOppositeSide crossing 2)) (= (crosser1 crossing) 2)) 
                (and (not(isOnOppositeSide crossing 3)) (= (crosser1 crossing) 3)) 
                (and (not(isOnOppositeSide crossing 4)) (= (crosser1 crossing) 4))
            )
            (or 
            ;Equivalet for the second person of the pair. 
                (and (not(isOnOppositeSide crossing 1)) (= (crosser2 crossing) 1))
                (and (not(isOnOppositeSide crossing 2)) (= (crosser2 crossing) 2)) 
                (and (not(isOnOppositeSide crossing 3)) (= (crosser2 crossing) 3)) 
                (and (not(isOnOppositeSide crossing 4)) (= (crosser2 crossing) 4))
            )
            ;Ensures that the two chosen people are not the same person
            (not (= (crosser1 crossing) (crosser2 crossing)))
            ;Checks which person has a slower pace and that is set as the cost of the crossing. 
            (crossingCost crossing)
            ;Switches the personCrossed state of the two chosen people to
            ;true for the next crossing and persists the states of the rest.
            (updateStateAfterCross crossing 1)
            (updateStateAfterCross crossing 2)
            (updateStateAfterCross crossing 3)
            (updateStateAfterCross crossing 4)
        )
      )
    )
  )
)

;Add up the costs of all recorded crossings together to get their sum.
(assert (= sum (+ (timeStepSum 1) (timeStepSum 2) (timeStepSum 3) (timeStepSum 4) (timeStepSum 5))))
;Set the solver to find a solution which minimizes the total sum.
(minimize sum)

(check-sat)
(get-value (sum))