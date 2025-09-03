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
                x = 16 + (19 * (j - 1)),
                y = 34 + (14 * (i - 1)),
            })
            end
        end

        -- Hardcoded starting values
        self.boardState[2][2].type = GRIPPER
        self.boardState[2][2].spr = 64
        self.boardState[2][2].used = 1
        self.boardState[2][3].type = COIL
        self.boardState[2][3].spr = 67
        self.boardState[2][3].used = 1
        self.boardState[2][4].type = MOTOR
        self.boardState[2][4].spr = 70
        self.boardState[2][4].used = 1
        self.boardState[3][2].type = BRAIN
        self.boardState[3][2].spr = 96
        self.boardState[3][2].used = 1
        self.boardState[3][3].type = SENSOR
        self.boardState[3][3].spr = 99
        self.boardState[3][3].used = 1
        self.boardState[3][4].type = LASER
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

        -- draw valid square separately
        for i = 1, 4 do
            for j = 1, 5 do
                if self.boardState[i][j].valid then
                    self:board_rect(i, j, WHITE, false)
                end
            end
        end
    end,

    -- Move Tile
    move_tile = function(self)
        if self.boardState[b_row_h][b_col_h].valid then
            -- Very Long Swap Statement
            self.boardState[b_row_s][b_col_s].type, self.boardState[b_row_h][b_col_h].type = self.boardState[b_row_h][b_col_h].type, self.boardState[b_row_s][b_col_s].type
            self.boardState[b_row_s][b_col_s].spr, self.boardState[b_row_h][b_col_h].spr = self.boardState[b_row_h][b_col_h].spr, self.boardState[b_row_s][b_col_s].spr
            self.boardState[b_row_s][b_col_s].used, self.boardState[b_row_h][b_col_h].used = self.boardState[b_row_h][b_col_h].used, self.boardState[b_row_s][b_col_s].used
            return true
        end

        return false
    end,

    -- Recursive Valid Path Function
    valid_path = function(self, module)

        for i = 1, 4 do
            for j = 1, 5 do
                if module == BRAIN and self.boardState[i][j].type == EMPTY and (i == b_row_s or j == b_col_s) then
                    self.boardState[i][j].valid = true

                elseif module == GRIPPER and self.boardState[i][j].type == EMPTY and (i >= b_row_s - 1 and i <= b_row_s + 1 and j >= b_col_s - 1 and j <= b_col_s + 1) then
                    self.boardState[i][j].valid = true

                elseif module == LASER and self.boardState[i][j].type == EMPTY and ((i == b_row_s or j == b_col_s) or (abs(i - b_row_s) == abs(j - b_col_s))) then
                    self.boardState[i][j].valid = true

                elseif module == MOTOR and (i == b_row_s or j == b_col_s) and (i >= b_row_s - 1 and i <= b_row_s + 1 and j >= b_col_s - 1 and j <= b_col_s + 1) then
                    self.boardState[i][j].valid = true

                elseif module == SENSOR and self.boardState[i][j].type == EMPTY and (abs(i - b_row_s) == abs(j - b_col_s)) then
                    self.boardState[i][j].valid = true
                end
            end
        end

    end,

    coil_valid_path = function(self, row, col, dx, dy, pass)
        new_row = row + dx
        new_col = col + dy

        if new_row < 1 or new_row > 4 or new_col < 1 or new_col > 5 then
            return
        end

        if self.boardState[new_row][new_col].type ~= EMPTY then
            pass = true
        elseif self.boardState[new_row][new_col].type == EMPTY and pass then
            self.boardState[new_row][new_col].valid = true
        end

        self:coil_valid_path(new_row, new_col, dx, dy, pass)
    end,


        -- Board rect function
        board_rect = function(self, row, col, color, fill)
          x = 16 + (19 * (col - 1))
          y = 34 + (14 * (row - 1))
          if fill then
            rectfill(x, y, x + 19, y + 14, color)
          else
            rect(x, y, x + 19, y + 14, color)
          end
    end,

    -- Valid Reset function
    valid_reset = function(self)
        for i = 1, 4 do
            for j = 1, 5 do
                self.boardState[i][j].valid = false
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