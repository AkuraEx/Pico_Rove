-- Deck Class
deck={
    cardAmount = 12,
    y = 90,
    x = 106,
    cards = {},
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
    end,

    -- pop function
    pop = function(self)
        card = self.cards[self.cardAmount]
        deli(self.cards, self.cardAmount)
        self.cardAmount -= 1
        return card
    end,

    -- todo
    -- shuffle = function(self)
    -- end

    -- All 12 Movement Cards Hardcoded
    init = function(self)
        -- Card 1
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {0, 0, FILLED},
            {0, STAR, 0},
            {FILLED, 0, 0}
            }
        }))

        -- Card 2
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, FILLED, FILLED},
            {0, GEAR, 0},
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
            {FILLED, SIGNAL, 0},
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
            {0, CRANE, 0},
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
            {0, CRANE, 0},
            {FILLED, 0, FILLED}
            }
        }))

        -- Card 11
        add(self.cards, card:new({
        value = 2,
        matchValue = 4,
        modules = {
            {0, 0, 0},
            {0, GEAR, 0},
            {FILLED, FILLED, 0}
            }
        }))

        -- Card 12
        add(self.cards, card:new({
        value = 3,
        matchValue = 5,
        modules = {
            {FILLED, 0, 0},
            {0, STAR, 0},
            {0, 0, FILLED}
        }
        }))
    end
}