-- Card Class
card={
    x = 0,
    y = 100,
    spr = 0,
    spr_x = 2.5,
    spr_y = 3.2,
    value = 0,
    matchValue = 0,
    modules = {
        {0, 0, 0},
        {0, 2, 0},
        {1, 0, 1}
    },

    new=function(self,tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })
        return tbl
    end,

    draw = function(self, index)
        start = index * 18
        moduleStart = start + 3
        spr(self.spr, start, self.y, self.spr_x, self.spr_y)
        print(self.value, start + 1, self.y + 1, WHITE)
        for i = 0, 2 do
            for j = 0, 2 do
                rect(moduleStart + (4 * j), self.y + 9 + (3 * i), moduleStart + (4 * j) + 2, self.y + 10 + (3 * i), self.modules[i + 1][j + 1])
            end
        end
    end
}
