-- Card Class
card={
    x = 0,
    y = 97,
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
        start = ((index - 1) * 18) + 5 
        moduleStart = start + 3
        spr(self.spr, start, self.y, self.spr_x, self.spr_y)
        print(self.value, start, self.y, WHITE)
        for i = 0, 2 do
            for j = 0, 2 do
                rect(moduleStart + (4 * j), self.y + 9 + (3 * i), moduleStart + (4 * j) + 2, self.y + 10 + (3 * i), self.modules[i + 1][j + 1])
            end
        end
        print(self.matchValue, start + 12, self.y + 18, WHITE)
    end,

    match = function(self, r, c)

        -- match check
        for i = 1, 3 do
            for j = 1, 3 do
                if(self.modules[i][j] == FILLED and board.boardState[i + r][j + c].type == 0) then
                    return false
                elseif(self.modules[i][j] ~= FILLED and self.modules[i][j] > EMPTY and board.boardState[i + r][j + c].type ~= self.modules[i][j]) then
                    return false
                end
            end
        end

        return true
    end
}
