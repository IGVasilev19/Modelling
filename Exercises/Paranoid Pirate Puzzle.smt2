(declare-fun treasureAtIslandOnDay(Int) Int)
(declare-fun searcherAtIslandOnDay(Int) Int)



(assert (and (<= 1 (treasureAtIslandOnDay 0)) (<= (treasureAtIslandOnDay 0) 5)))

;For each day we have two options for the tresure:
;either the tresure moves to the +island or to the minus island.
;For each day we have five options for the searcher:
;he can go to any of the five islands
(and
    (or
        (= (treasureAtIslandOnDay (+ day 1)) (+ (treasureAtIslandOnDay day) 1))
        (= (treasureAtIslandOnDay (+ day 1)) (- (treasureAtIslandOnDay day) 1))
    )
    (or
        (and (<= 1 (searcherAtIslandOnDay day)) (<= (searcherAtIslandOnDay day) 5))
    )
)


