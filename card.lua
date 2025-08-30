-- Card Class
card={
    x = 0,
    y = 97,
    spr = 0,
    spr_x = 2.5,
    spr_y = 3.2,
    value = 0,
    matchValue = 0,
    cardType = "",
    cardTitle = "",
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
    end
}

-- Mission Card Class - Display only, shows current goal
missioncard={
    x = 90,  -- Moved to right side (was 5)
    y = 0,   -- Keep at top
    spr = 0,
    cardType = "mission",
    missionName = "",
    modules = {
        {0, 0, 0},
        {0, 0, 0},
        {0, 0, 0},
        {0, 0, 0}
    },

    new=function(self,tbl)
        tbl = tbl or {}
        setmetatable(tbl, {
            __index = self
        })
        return tbl
    end,

    draw = function(self)
        -- Draw mission name
        print(self.missionName, self.x, self.y, WHITE)
        
        -- Draw 3x4 pattern - moved right 3 pixels and down 2 pixels
        for i = 0, 3 do  -- 4 rows
            for j = 0, 2 do  -- 3 columns
                rect(self.x + 25 + (4 * j), self.y + 10 + (3 * i), 
                     self.x + 25 + (4 * j) + 2, self.y + 11 + (3 * i), 
                     self.modules[i + 1][j + 1])
            end
        end
    end
}
