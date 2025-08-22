-- Card Class
card={
    x = 0,
    y = 90,
    spr = 0,
    spr_x = 2,
    spr_y = 3,
    suit = "diamonds",
    value = 0,

    new=function(self,tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })
        return tbl
    end,

    draw = function(self)
        spr(self.spr, self.x, self.y, self.spr_x, self.spr_y)
        print(self.value, self.x, self.y, WHITE)
    end
}
