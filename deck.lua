-- Deck Class
deck={
    cardAmount = 18,
    y = 110,
    x = 110,
    cards = {},
    spr = 0,
    spr_x = 2,
    spr_y = 3,


    new=function(self,tbl)
            tbl = tbl or {}
            setmetatable(tbl, {
                __index = self
            })
            return tbl
    end,

    init = function(self)
        for i = 1, 18 do
            add(self.cards, card:new({
            value = flr(rnd(13))
            }))
        end
    end,

    draw = function(self)
        spr(self.spr, self.x, self.y, self.spr_x, self.spr_y)
        print(self.cardAmount, self.x, self.y, WHITE)
    end,

    pop = function(self)
        card = self.cards[self.cardAmount]
        deli(self.cards, self.cardAmount)
        self.cardAmount -= 1
        return card
    end

}