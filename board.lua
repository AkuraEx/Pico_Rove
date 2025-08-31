-- Board Class
board={
    boardState = {},
    isVisited = {},

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
            self.isVisited[i] = {}
            for j = 1, 5 do
            self.boardState[i][j] = boardtile:new({
                x = 16 + (19 * (j - 1)),
                y = 34 + (14 * (i - 1)),
            })
            self.isVisited[i][j] = false
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
    valid_path = function(self, row, col, pass)
        if row < 1 or row > 4 or col < 1 or col > 5 or self.isVisited[row][col] == true then
            return
        end

        local new_pass = pass

        if self.boardState[b_row_s][b_col_s].type == BRAIN and self.boardState[row][col].type == EMPTY and (row == b_row_s or col == b_col_s) then
            self.boardState[row][col].valid = true
        elseif self.boardState[b_row_s][b_col_s].type == GRIPPER and self.boardState[row][col].type == EMPTY and (row >= b_row_s - 1 and row <= b_row_s + 1 and col >= b_col_s - 1 and col <= b_col_s + 1) then
            self.boardState[row][col].valid = true
        elseif self.boardState[b_row_s][b_col_s].type == LASER and self.boardState[row][col].type == EMPTY and ((row == b_row_s or col == b_col_s) or (row - b_row_s == col - b_col_s)) then
            self.boardState[row][col].valid = true
        elseif self.boardState[b_row_s][b_col_s].type == MOTOR and (row == b_row_s or col == b_col_s) and (row >= b_row_s - 1 and row <= b_row_s + 1 and col >= b_col_s - 1 and col <= b_col_s + 1) then
            self.boardState[row][col].valid = true
        elseif self.boardState[b_row_s][b_col_s].type == SENSOR and self.boardState[row][col].type == EMPTY and (row - b_row_s == col - b_col_s) then
            self.boardState[row][col].valid = true


        -- Gotta fix this
        -- Lua giving me trouble with pass by value for some reason
        elseif self.boardState[b_row_s][b_col_s].type == COIL
            and self.boardState[row][col].type ~= EMPTY
            and ((row == b_row_s or col == b_col_s) or (row - b_row_s == col - b_col_s)) then
            new_pass = true
        elseif new_pass == true
            and self.boardState[row][col].type == EMPTY
            and ((row == b_row_s or col == b_col_s) or (row - b_row_s == col - b_col_s)) then
            self.boardState[row][col].valid = true
        end


        self.isVisited[row][col] = true

        self:valid_path(row + 1, col, new_pass)
        self:valid_path(row + 1, col + 1, new_pass)
        self:valid_path(row + 1, col - 1, new_pass)
        self:valid_path(row - 1, col, new_pass)
        self:valid_path(row - 1, col + 1, new_pass)
        self:valid_path(row - 1, col - 1, new_pass)
        self:valid_path(row, col - 1, new_pass)
        self:valid_path(row, col + 1, new_pass)
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

    -- Visit Reset function
    visit_reset = function(self)
        for i = 1, 4 do
            for j = 1, 5 do
                self.isVisited[i][j] = false
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