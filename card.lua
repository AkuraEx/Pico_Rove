-- Card Class
card={
    x = 0,
    y = 100,
    spr = 0,
    spr_x = 2,
    spr_y = 3,
    value = 0,

    new=function(self,tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })
        return tbl
    end,

    draw = function(self, index)
        spr(self.spr, index * 18, self.y, self.spr_x, self.spr_y)
        print(self.value, index * 18 + 1, self.y + 1, WHITE)
    end
}
