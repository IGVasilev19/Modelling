;A declare-fun which maps a step and a position to a tile.
;Used to check where each tile is at each step in time.
(declare-fun tileAtStepOnPosition(Int Int) Int)

;Minimal number of steps for the puzzle to be solved, initially unknown.
(declare-const N Int)

;Takes a step and a position and checks if the empty tile resides there.
(define-fun checkIsEmptyTile ((step Int) (position Int)) Bool
    (= (tileAtStepOnPosition step position) 0)
)

;Since the solver needs to know the position of all tiles, to determine which
;action to take, we set the state, based on the current one, of all of the tiles,
;which are not being moved during the current step.
(define-fun persistTileAtPosition ((step Int) (position Int)) Bool
    (= (tileAtStepOnPosition step position) (tileAtStepOnPosition (- step 1) position))
)

;This function takes the step and the positions of both the empty tile and the tile which will be
;moved and switches their positions.
(define-fun switchTiles ((step Int) (positionEmpty Int) (positionToSwitch Int)) Bool
    (and
        (=(tileAtStepOnPosition step positionEmpty) (tileAtStepOnPosition (- step 1) positionToSwitch))
        (=(tileAtStepOnPosition step positionToSwitch) 0)
    )
)

(assert(= N 30))

;Setting the initial positions of all tiles.
(assert(= (tileAtStepOnPosition 0 9) 0))
(assert(= (tileAtStepOnPosition 0 8) 1))
(assert(= (tileAtStepOnPosition 0 7) 2))
(assert(= (tileAtStepOnPosition 0 6) 3))
(assert(= (tileAtStepOnPosition 0 5) 4))
(assert(= (tileAtStepOnPosition 0 4) 5))
(assert(= (tileAtStepOnPosition 0 3) 6))
(assert(= (tileAtStepOnPosition 0 2) 7))
(assert(= (tileAtStepOnPosition 0 1) 8))


(assert
  (forall ((step Int))
    (implies (and(<= 1 step) (<= step N))
    ;In each step the empty space could be at any of the
    ;9 possible positions. So there are 9 posibilities, because
    ;each of those posibilities has different available actions.
        (or
            ;When the solved decides to select a possibility it, also checks
            ;if that possibility is the actual empty tile.
            ;If it is, in this case it has to options, to switch the empty tile with the
            ;tile to the left or with the tile below. And it also has to save the state of
            ;the rest of the tiles. This is equivalent for all 9 possibilities, with the only difference
            ;being the available options from each possibility.
            (and
                (checkIsEmptyTile (- step 1) 1)
                (or
                    (and
                        (switchTiles step 1 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 1 4)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 2)
                (or
                    (and
                        (switchTiles step 2 1)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 2 5)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 2 3)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 3)
                (or
                    (and
                        (switchTiles step 3 2)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 3 6)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 4)
                (or
                    (and
                        (switchTiles step 4 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 4 5)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 4 7)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 5)
                (or
                    (and
                        (switchTiles step 5 2)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 5 4)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 5 6)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 5 8)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 6)
                (or
                    (and
                        (switchTiles step 6 3)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 6 9)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                    )
                    (and
                        (switchTiles step 6 5)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 7)
                (or
                    (and
                        (switchTiles step 7 4)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 8)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 7 8)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 9)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 8)
                (or
                    (and
                        (switchTiles step 8 7)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 8 5)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 9)
                    )
                    (and
                        (switchTiles step 8 9)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                    )
                )
            )
            (and
                (checkIsEmptyTile (- step 1) 9)
                (or
                    (and
                        (switchTiles step 9 6)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 7)
                        (persistTileAtPosition step 8)
                    )
                    (and
                        (switchTiles step 9 8)
                        (persistTileAtPosition step 1)
                        (persistTileAtPosition step 2)
                        (persistTileAtPosition step 3)
                        (persistTileAtPosition step 4)
                        (persistTileAtPosition step 5)
                        (persistTileAtPosition step 6)
                        (persistTileAtPosition step 7)
                    )
                )
            )
        )
    )
  )
)

;Set the desired end state of all tiles, after the last step is complete.
(assert
    (and
        (= (tileAtStepOnPosition N 9) 0)
        (= (tileAtStepOnPosition N 8) 8)
        (= (tileAtStepOnPosition N 7) 7)
        (= (tileAtStepOnPosition N 6) 6)
        (= (tileAtStepOnPosition N 5) 5)
        (= (tileAtStepOnPosition N 4) 4)
        (= (tileAtStepOnPosition N 3) 3)
        (= (tileAtStepOnPosition N 2) 2)
        (= (tileAtStepOnPosition N 1) 1)
    )
)

(check-sat)
(get-value(N))