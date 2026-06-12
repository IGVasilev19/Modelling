;4 people in total
;The torch is needed when crossing
;At most two people at the same time
;The slower of the two people determine the pace
;Fastest way for all four to cross
(declare-fun people (Int) Int);each person is represented by the his number 1,2,3,4 (for A,B,C,D) and the time it takes him to cross the bridge
(declare-fun personCrossed (Int Int) Bool);status per person to keep track of who is on which side of the bridge
(declare-fun crosser1 (Int) Int);first person chosen to cross
(declare-fun crosser2 (Int) Int);second person chosen to cross
(declare-fun timeStepSum(Int) Int);the time it took to cross at corresponding crossing
(declare-const sum Int);total time it took for all of them to cross

(assert (= (people 1) 10))
(assert (= (people 2) 5))
(assert (= (people 3) 2))
(assert (= (people 4) 1))

(assert
  (forall ((crossing Int))
    (=> (and (<= 1 crossing) (<= crossing 5));In the best possible scenario all of them should have crossed in a total of 5 crossings
      ;We check if the number of the current crossing is even or odd. If it is odd that mean that the 'torch' is on the initial side of the bridge
      ;so two people should cross and if it is even then a person should be sent back with the torch so another pair can cross.
      (ite (= (mod crossing 2) 0)
        (and
        ;Selects the person who will return the torch, for each possible person 
        ;to be chosen it first checks if that person is already on the opposite site of the bridge.
            (or 
                (and (= (personCrossed crossing 1) true) (= (crosser1 crossing) 1))
                (and (= (personCrossed crossing 2) true) (= (crosser1 crossing) 2))
                (and (= (personCrossed crossing 3) true) (= (crosser1 crossing) 3))
                (and (= (personCrossed crossing 4) true) (= (crosser1 crossing) 4))
            )
            ;The time it took for each crossing is saved in a declare-fun timeStepSum,
            ;which maps the crossing to the time it took to complete it 
            ;For each person we either set the personCrossed to false is that was the chosen person
            ;to return, or we persist their current personCrossed state for the next crossing.
            (= (timeStepSum crossing) (people (crosser1 crossing)))
            (= (personCrossed (+ crossing 1) 1) (ite (= (crosser1 crossing) 1) false (personCrossed crossing 1)))
            (= (personCrossed (+ crossing 1) 2) (ite (= (crosser1 crossing) 2) false (personCrossed crossing 2)))
            (= (personCrossed (+ crossing 1) 3) (ite (= (crosser1 crossing) 3) false (personCrossed crossing 3)))
            (= (personCrossed (+ crossing 1) 4) (ite (= (crosser1 crossing) 4) false (personCrossed crossing 4)))
        )
        (and
            (or 
                ;It starts selecting the first person for the pair which will cross. First checks if the person is currently on the initial side of the bridge,
                ;then if chosen, sets the personCrossed state for the next crossing to true.
                (and (= (personCrossed crossing 1) false) (= (crosser1 crossing) 1) (= (personCrossed (+ crossing 1) 1) true)) 
                (and (= (personCrossed crossing 2) false) (= (crosser1 crossing) 2) (= (personCrossed (+ crossing 1) 2) true)) 
                (and (= (personCrossed crossing 3) false) (= (crosser1 crossing) 3) (= (personCrossed (+ crossing 1) 3) true)) 
                (and (= (personCrossed crossing 4) false) (= (crosser1 crossing) 4) (= (personCrossed (+ crossing 1) 4) true))
            )
            (or 
            ;Equivalet for the second person of the pair. 
                (and (= (personCrossed crossing 1) false) (= (crosser2 crossing) 1) (= (personCrossed (+ crossing 1) 1) true))
                (and (= (personCrossed crossing 2) false) (= (crosser2 crossing) 2) (= (personCrossed (+ crossing 1) 2) true)) 
                (and (= (personCrossed crossing 3) false) (= (crosser2 crossing) 3) (= (personCrossed (+ crossing 1) 3) true)) 
                (and (= (personCrossed crossing 4) false) (= (crosser2 crossing) 4) (= (personCrossed (+ crossing 1) 4) true))
            )
            ;Ensures that the two chosen people are not the same person
            ;Checks which person has a slower pace and that is set as the cost of the crossing. 
            (not (= (crosser1 crossing) (crosser2 crossing)))
            (ite (> (people (crosser1 crossing)) (people (crosser2 crossing)))
                    (= (timeStepSum crossing) (people (crosser1 crossing))) 
                    (= (timeStepSum crossing) (people (crosser2 crossing)))
            )
            ;Switches the personCrossed state of the two chosen people to
            ;true for the next crossing and persists the states of the rest.
            (= (personCrossed (+ crossing 1) 1) (ite (or (= (crosser1 crossing) 1) (= (crosser2 crossing) 1)) true (personCrossed crossing 1)))
            (= (personCrossed (+ crossing 1) 2) (ite (or (= (crosser1 crossing) 2) (= (crosser2 crossing) 2)) true (personCrossed crossing 2)))
            (= (personCrossed (+ crossing 1) 3) (ite (or (= (crosser1 crossing) 3) (= (crosser2 crossing) 3)) true (personCrossed crossing 3)))
            (= (personCrossed (+ crossing 1) 4) (ite (or (= (crosser1 crossing) 4) (= (crosser2 crossing) 4)) true (personCrossed crossing 4)))
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


