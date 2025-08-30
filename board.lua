-- Board Class
board={
    boardState = {},

    -- New Board Object
    new=function(self,tbl)
            tbl = tbl or {}
            setmetatable(tbl, {
                __index = self
            })
            return tbl
    end,

    -- Board Init
    init = function(self)
        for i = 1, 4 do
            self.boardState[i] = {}
            for j = 1, 5 do
            self.boardState[i][j] = boardtile:new({
                x = 12 + (19 * (j - 1)),
                y = 30 + (14 * (i - 1)),
            })
            end
        end

        -- Hardcoded starting values
        self.boardState[2][2].type = CRANE
        self.boardState[2][2].spr = 64
        self.boardState[2][2].used = 1
        self.boardState[2][3].type = COIL
        self.boardState[2][3].spr = 67
        self.boardState[2][3].used = 1
        self.boardState[2][4].type = GEAR
        self.boardState[2][4].spr = 70
        self.boardState[2][4].used = 1
        self.boardState[3][2].type = BRAIN
        self.boardState[3][2].spr = 96
        self.boardState[3][2].used = 1
        self.boardState[3][3].type = SIGNAL
        self.boardState[3][3].spr = 99
        self.boardState[3][3].used = 1
        self.boardState[3][4].type = STAR
        self.boardState[3][4].spr = 102
        self.boardState[3][4].used = 1
    end,

    -- Draw
    draw = function(self)
        for i = 1, 4 do
            for j = 1, 5 do
                self.boardState[i][j]:draw()
            end
        end
    end

    -- todo
    -- shuffle = function(self)
    -- shuffle board starting pos
    -- end

    -- swap = function(self)
    -- swap tiles
    -- end
}