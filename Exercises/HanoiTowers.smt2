;1. Only one disk may be moved at a time.
;2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack or on an empty rod.
;3. No disk may be placed on top of a disk that is smaller than it.
;The minimum number of moves required to solve a Tower of Hanoi puzzle is 2^n − 1, where n is the number of disks.

;This variable represents the rod on which each disk sits during each move. 
;It takes a move number and a disk number and
;maps them to a rod number
(declare-fun diskAtRodOnStep (Int Int) Int)

(assert
;We set the initial starting position for each disk
    (and
        (= (diskAtRodOnStep 0 1) 1)
        (= (diskAtRodOnStep 0 2) 1)
        (= (diskAtRodOnStep 0 3) 1)
    )
)

(assert
    (forall ((move Int))
        ;Since we know that with 3 disks and 3 rods the most optimal solution takes 7 moves to complete(from 2^n-1)
        (=> (and (<= 1 move) (<= move 7))
        ;Each time only one disk can be moved
            (or
                (and  
                    (or
                        ;If we choose to move disk 1, we have three options:
                        ;move to rod1,2 or 3, but for each one the only thing we have to ensure
                        ;is that when we move the disk it doesn't end up in the same position it already is at.
                        (and (not (= (diskAtRodOnStep (- move 1) 1) 1)) (= (diskAtRodOnStep move 1) 1))
                        (and (not (= (diskAtRodOnStep (- move 1) 1) 2)) (= (diskAtRodOnStep move 1) 2))
                        (and (not (= (diskAtRodOnStep (- move 1) 1) 3)) (= (diskAtRodOnStep move 1) 3))
                    )
                    (and
                    ;We have to persist the positions of the rest of the disks.
                        (= (diskAtRodOnStep move 2) (diskAtRodOnStep (- move 1) 2))
                        (= (diskAtRodOnStep move 3) (diskAtRodOnStep (- move 1) 3))
                    )
                )
                (and 
                ;Equivalently we have 3 possible moves
                    (or
                        (and
                        ;But here we also need to check two additional things: if a smaller disk is currently on top of this one
                        ;and also if that is not the case, then we have to check if a smaller disk is already at the rod that we want to move
                        ;this disk to.
                            (not (= (diskAtRodOnStep (- move 1) 1) 1))
                            (not (= (diskAtRodOnStep (- move 1) 2) 1))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 2)))
                            (= (diskAtRodOnStep move 2) 1)
                        )
                        (and
                            ;We do the same check for each possible option
                            (not (= (diskAtRodOnStep (- move 1) 1) 2))
                            (not (= (diskAtRodOnStep (- move 1) 2) 2))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 2)))
                            (= (diskAtRodOnStep move 2) 2)
                        )
                        (and
                            (not (= (diskAtRodOnStep (- move 1) 1) 3))
                            (not (= (diskAtRodOnStep (- move 1) 2) 3))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 2)))
                            (= (diskAtRodOnStep move 2) 3)
                        )
                    )
                    (and
                        (= (diskAtRodOnStep move 1) (diskAtRodOnStep (- move 1) 1))
                        (= (diskAtRodOnStep move 3) (diskAtRodOnStep (- move 1) 3))
                    )
                )
                (and 
                    (or
                        (and
                        ;Same,but now we have to check for multiple smaller disks
                            (not (= (diskAtRodOnStep (- move 1) 1) 1))
                            (not (= (diskAtRodOnStep (- move 1) 2) 1))
                            (not (= (diskAtRodOnStep (- move 1) 3) 1))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 3)))
                            (not (= (diskAtRodOnStep (- move 1) 2) (diskAtRodOnStep (- move 1) 3)))
                            (= (diskAtRodOnStep move 3) 1)
                        )
                        (and
                            (not (= (diskAtRodOnStep (- move 1) 1) 2))
                            (not (= (diskAtRodOnStep (- move 1) 2) 2))
                            (not (= (diskAtRodOnStep (- move 1) 3) 2))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 3)))
                            (not (= (diskAtRodOnStep (- move 1) 2) (diskAtRodOnStep (- move 1) 3)))
                            (= (diskAtRodOnStep move 3) 2)
                        )
                        (and
                            (not (= (diskAtRodOnStep (- move 1) 1) 3))
                            (not (= (diskAtRodOnStep (- move 1) 2) 3))
                            (not (= (diskAtRodOnStep (- move 1) 3) 3))
                            (not (= (diskAtRodOnStep (- move 1) 1) (diskAtRodOnStep (- move 1) 3)))
                            (not (= (diskAtRodOnStep (- move 1) 2) (diskAtRodOnStep (- move 1) 3)))
                            (= (diskAtRodOnStep move 3) 3)
                        )
                    )
                    (and
                        (= (diskAtRodOnStep move 1) (diskAtRodOnStep (- move 1) 1))
                        (= (diskAtRodOnStep move 2) (diskAtRodOnStep (- move 1) 2))
                    )
                )
            )
        )
    )
)

(assert
;To know that we have succesfully move the tower we need to check two things: 
;firstly all disks are on the same rod after the last move is performed
;and secondly that the rod they are at after the last move is complete is 
;different than the initial rod they were on.
    (and 
        (and 
            (= (diskAtRodOnStep 7 1) (diskAtRodOnStep 7 2))
            (= (diskAtRodOnStep 7 2) (diskAtRodOnStep 7 3))
        )
        (and
            (not (= (diskAtRodOnStep 7 1) (diskAtRodOnStep 0 1)))
            (not (= (diskAtRodOnStep 7 2) (diskAtRodOnStep 0 2)))
            (not (= (diskAtRodOnStep 7 3) (diskAtRodOnStep 0 3)))
        )
    )
)

(check-sat)
(get-value (
  ; Step 0 - Initial state
  (diskAtRodOnStep 0 1) (diskAtRodOnStep 0 2) (diskAtRodOnStep 0 3)

  ; Step 1
  (diskAtRodOnStep 1 1) (diskAtRodOnStep 1 2) (diskAtRodOnStep 1 3)

  ; Step 2
  (diskAtRodOnStep 2 1) (diskAtRodOnStep 2 2) (diskAtRodOnStep 2 3)

  ; Step 3
  (diskAtRodOnStep 3 1) (diskAtRodOnStep 3 2) (diskAtRodOnStep 3 3)

  ; Step 4
  (diskAtRodOnStep 4 1) (diskAtRodOnStep 4 2) (diskAtRodOnStep 4 3)

  ; Step 5
  (diskAtRodOnStep 5 1) (diskAtRodOnStep 5 2) (diskAtRodOnStep 5 3)

  ; Step 6
  (diskAtRodOnStep 6 1) (diskAtRodOnStep 6 2) (diskAtRodOnStep 6 3)

  ; Step 7 - Final state
  (diskAtRodOnStep 7 1) (diskAtRodOnStep 7 2) (diskAtRodOnStep 7 3)
))