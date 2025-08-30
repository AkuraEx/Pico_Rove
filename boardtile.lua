-- BoardTile Class
boardtile={
    x = 40,
    y = 30,
    spr = 64,
    spr_x = 2.5,
    spr_y = 2,
    type = 0,
    used = 0,

    new=function(self,tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })
        return tbl
    end,

    draw = function(self)
        if self.type ~= 0 then
            spr(self.spr, self.x, self.y - 1, self.spr_x, self.spr_y)
        else rect(self.x, self.y, self.x + 19, self.y + 14, self.type) 
        end
    end
}