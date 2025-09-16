-- Deck Class
deck={
    cardAmount = 12,
    missionCardAmount = 8,
    y = 100,
    x = 106,
    cards = {},
    missionCards = {},
    completed = {},
    spr = 004,
    spr_x = 3,
    spr_y = 4,


    -- New Deck Object
    new=function(self,tbl)
            tbl = tbl or {}
            setmetatable(tbl, {
                __index = self
            })
            return tbl
    end,

    -- draw cards left to screen
    draw = function(self)
        if self.cardAmount ~= 0 then
            spr(self.spr, self.x, self.y, self.spr_x, self.spr_y)
        end
        print(self.cardAmount, self.x, self.y, WHITE)


        for i = 1, #self.completed do
            -- draw guy
            if counter % 20 == 0 then
            frame = 1
            elseif counter % 10 == 0 then
            frame = 2
            end

            spr(self.completed[i].spr[frame], i * 8 + 36, 8)
        end



    end,

    -- pop function
    pop = function(self)
        card = self.cards[self.cardAmount]
        deli(self.cards, self.cardAmount)
        self.cardAmount -= 1
        return card
    end,

    -- pop mission
    pop_mission = function(self)
        mission = self.missionCards[self.missionCardAmount]
        deli(self.missionCards, self.missionCardAmount)
        self.missionCardAmount -= 1
        return mission
    end,

    -- shuffle function
    shuffle = function(self)
        for i = self.cardAmount, 2, -1 do
            j = flr(rnd(i)) + 1
            self.cards[i], self.cards[j] = self.cards[j], self.cards[i]
        end
    end,

    -- shuffle missions function
    shuffle_missions = function(self)
        for i = self.missionCardAmount, 2, -1 do
            j = flr(rnd(i)) + 1
            self.missionCards[i], self.missionCards[j] = self.missionCards[j], self.missionCards[i]
        end
    end,


    -- All 12 Movement Cards Hardcoded
    init = function(self)
        -- Card 1
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {0, 0, FILLED},
            {0, LASER, 0},
            {FILLED, 0, 0}
            }
        }))

        -- Card 2
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, FILLED, FILLED},
            {0, MOTOR, 0},
            {0, 0, 0}
            }
        }))
        
        -- Card 3
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {0, 0, 0},
            {FILLED, BRAIN, FILLED},
            {0, 0, 0}
            }
        }))

        -- Card 4
        add(self.cards, card:new({
        value = 1,
        matchValue = 3,
        modules = {
            {0, 0, 0},
            {FILLED, COIL, 0},
            {FILLED, 0, 0}
            }
        }))

        -- Card 5
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, 0, 0},
            {FILLED, SENSOR, 0},
            {0, FILLED, 0}
            }
        }))

        -- Card 6
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, FILLED, 0},
            {0, COIL, FILLED},
            {0, 0, 0}
            }
        }))
        -- Card 7
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {FILLED, 0, FILLED},
            {0, GRIPPER, 0},
            {0, 0, 0}
            }
        }))

        -- Card 8
        add(self.cards, card:new({
        value = 1,
        matchValue = 3,
        modules = {
            {0, 0, FILLED},
            {0, COIL, FILLED},
            {0, 0, 0}
            }
        }))

        -- Card 9
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {0, FILLED, 0},
            {0, BRAIN, 0},
            {0, FILLED, 0}
            }
        }))

        -- Card 10
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, 0, 0},
            {0, GRIPPER, 0},
            {FILLED, 0, FILLED}
            }
        }))

        -- Card 11
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, 0, 0},
            {0, MOTOR, 0},
            {FILLED, FILLED, 0}
            }
        }))

        -- Card 12
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {FILLED, 0, 0},
            {0, LASER, 0},
            {0, 0, FILLED}
        }
        }))
    end,

    -- Initialize Mission Cards
    init_missions = function(self)

        -- Boost Mission : 1
        add(self.missionCards, missioncard:new({
            missionName = "bOOST",
            modules = {
                {0, 0, 0},
                {FILLED, FILLED, 0},
                {0, FILLED, LASER},
                {FILLED, FILLED, 0}
            },
            spr = {7, 8}
        }))
        
        -- Bridge Mission : 2
        add(self.missionCards, missioncard:new({
            missionName = "bRIDGE",
            modules = {
                {0, 0, FILLED},
                {0, FILLED, FILLED},
                {FILLED, GRIPPER, 0},
                {FILLED, 0, 0}
            },
            spr = {7, 8}
        }))

        -- Drill Mission  : 3
        add(self.missionCards, missioncard:new({
            missionName = "dRILL",
            modules = {
                {0, 0, 0},
                {FILLED, FILLED, FILLED},
                {FILLED, 0, FILLED},
                {0, MOTOR, 0}
            },
            spr = {7, 8}
        }))
        
        -- Jump Mission  : 4
        add(self.missionCards, missioncard:new({
            missionName = "jUMP",
            modules = {
                {FILLED, COIL, FILLED},
                {0, FILLED, 0},
                {0, FILLED, 0},
                {0, FILLED, 0}
            },
            spr = {7, 8}
        }))

        -- Learn Mission  : 5
        add(self.missionCards, missioncard:new({
            missionName = "lEARN",
            modules = {
                {0, 0, 0},
                {0, 0, FILLED},
                {0, FILLED, FILLED},
                {BRAIN, FILLED, FILLED}
            },
            spr = {7, 8}
        }))

        -- Navigate Mission  : 6
        add(self.missionCards, missioncard:new({
            missionName = "nAVIGATE",
            modules = {
                {FILLED, 0, 0},
                {0, SENSOR, 0},
                {FILLED, 0, FILLED},
                {FILLED, 0, FILLED}
            },
            spr = {7, 8}
        }))

        -- Roll Mission : 7
        add(self.missionCards, missioncard:new({
            missionName = "rOLL",
            modules = {
                {0, FILLED, 0},
                {FILLED, 0, FILLED},
                {0, BRAIN, 0},
                {FILLED, 0, FILLED}
            },
            spr = {9, 10}
        }))

        -- Scan Mission : 8
        add(self.missionCards, missioncard:new({
            missionName = "sCAN",
            modules = {
                {0, FILLED, FILLED},
                {FILLED, 0, 0},
                {SENSOR, 0, 0},
                {0, FILLED, FILLED}
            },
            spr = {7, 8}
        }))
        
    end
}