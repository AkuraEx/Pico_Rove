-- Board Class
board={
    boardState = {},
    typelist = {GRIPPER, COIL, MOTOR, BRAIN, SENSOR, LASER},
    sprlist = {64, 67, 70, 96, 99, 102},

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
        for i = 1, ROWS do
            self.boardState[i] = {}
            for j = 1, COLS do
            self.boardState[i][j] = boardtile:new({
                x = 1 + (19 * (j - 1)),
                y = 25 + (12 * (i - 1)),
                type = EMPTY,
                spr = 73,
                used = 0,
            })
            end
        end

        self:randomize_modules()
    end,

    -- Randomize module locations
    randomize_modules = function(self)
        count = 1
        while count ~= 7 do
            local i = flr(rnd(4)) + 2
            local j = flr(rnd(4)) + 2
            if self.boardState[i][j].type == EMPTY then
                self.boardState[i][j].type = self.typelist[count]
                self.boardState[i][j].spr = self.sprlist[count]
                self.boardState[i][j].used = 1
                count += 1
            end
        end
    end,

    -- Draw
    draw = function(self)
        for i = 1, ROWS do
            for j = 1, COLS do
                self.boardState[i][j]:draw()
            end
        end

        -- draw valid square separately
        for i = 1, ROWS do
            for j = 1, COLS do
                if self.boardState[i][j].valid then
                    self:board_rect(i, j, WHITE, false)
                end
            end
        end
    end,

    -- Move Tile
    move_tile = function(self)
            -- Check motor push
        if self.boardState[b_row_s][b_col_s].type == MOTOR and self.boardState[b_row_h][b_col_h].type ~= EMPTY and self:push() then
            return true
        elseif self.boardState[b_row_h][b_col_h].valid then
            -- Very Long Swap Statement
            self.boardState[b_row_s][b_col_s].type, self.boardState[b_row_h][b_col_h].type = self.boardState[b_row_h][b_col_h].type, self.boardState[b_row_s][b_col_s].type
            self.boardState[b_row_s][b_col_s].spr, self.boardState[b_row_h][b_col_h].spr = self.boardState[b_row_h][b_col_h].spr, self.boardState[b_row_s][b_col_s].spr
            self.boardState[b_row_s][b_col_s].used, self.boardState[b_row_h][b_col_h].used = self.boardState[b_row_h][b_col_h].used, self.boardState[b_row_s][b_col_s].used
            return true
        end

        return false
    end,

    -- Push Tile
    push = function(self)
        dx = b_row_h - b_row_s
        dy = b_col_h - b_col_s
        edge_x = b_row_s
        edge_y = b_col_s

        while edge_x > 1 and edge_x < 6 and edge_y > 1 and edge_y < 6 do
            edge_x += dx
            edge_y += dy

            if self.boardState[edge_x][edge_y].type == EMPTY then 
                distance = abs((edge_x - b_row_s) + (edge_y - b_col_s))
                for i = 1, distance do
                    self.boardState[edge_x][edge_y].type, self.boardState[edge_x - dx][edge_y - dy].type = self.boardState[edge_x - dx][edge_y - dy].type, self.boardState[edge_x][edge_y].type
                    self.boardState[edge_x][edge_y].spr, self.boardState[edge_x - dx][edge_y - dy].spr = self.boardState[edge_x - dx][edge_y - dy].spr, self.boardState[edge_x][edge_y].spr
                    self.boardState[edge_x][edge_y].used, self.boardState[edge_x - dx][edge_y - dy].used = self.boardState[edge_x - dx][edge_y - dy].used, self.boardState[edge_x][edge_y].used

                    edge_x = edge_x - dx
                    edge_y = edge_y - dy
                    end
                return true
            end
        end



        return false
    end,

    -- Recursive Valid Path Function
    valid_path = function(self, module)

        for i = 1, ROWS do
            for j = 1, COLS do
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

        if new_row < 1 or new_row > ROWS or new_col < 1 or new_col > COLS then
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
          x = 1 + (19 * (col - 1))
          y = 25 + (12 * (row - 1))
          if fill then
            rectfill(x, y, x + 17, y + 10, color)
          else
            rect(x, y, x + 17, y + 10, color)
          end
    end,

    -- Valid Reset function
    valid_reset = function(self)
        for i = 1, ROWS do
            for j = 1, COLS do
                self.boardState[i][j].valid = false
            end
        end
    end,

    match = function(self, r, c)
        -- FIX THIS
        -- match check
        for i = 1, 4 do
            for j = 1, 3 do
                if(current_mission.modules[i][j] == FILLED and self.boardState[i + r][j + c].type == 0) then
                    return false
                elseif(current_mission.modules[i][j] ~= FILLED and current_mission.modules[i][j] > EMPTY and self.boardState[i + r][j + c].type ~= current_mission.modules[i][j]) then
                    return false
                end
            end
        end

        return true
    end


    -- todo
    -- shuffle = function(self)
    -- shuffle board starting pos
    -- end

    -- swap = function(self)
    -- swap tiles
    -- end
}