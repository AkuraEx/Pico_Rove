function play_ability() 
    -- check mouse 
    for i = 1, ROWS do
        for j = 1, COLS do
            if stat(32) > board.boardState[i][j].x and stat(32) < board.boardState[i][j].x + 19 and stat(33) > board.boardState[i][j].y and stat(33) < board.boardState[i][j].y + 12 then
                a_row_h = i
                a_col_h = j
            end
        end
    end

    -- click refresh
    click = false
    if left_click() then
        click = true
    end

    -- left
    if btnp(0) and b_col_h > 1 then
        a_col_h -= 1
    end
    -- right
    if btnp(1) and b_col_h < COLS then
        a_col_h += 1
    end
    -- up
    if btnp(2) and b_row_h > 1 then
        a_row_h -= 1
    end
    -- down
    if btnp(3) and b_row_h < ROWS then
        a_row_h += 1
    end

    if module == LASER then
        laser()
    end
end

-- swap two tiles
function laser()

    if btnp(5) and a_row_s == 0 and board.boardState[a_row_h][a_col_h].type ~= EMPTY then
        a_row_s = a_row_h
        a_col_s = a_col_h
    end

    if btnp(5) and board.boardState[a_row_h][a_col_h].type ~= EMPTY and board.boardState[a_row_h][a_col_h] ~= board.boardState[a_row_s][a_col_s] then

        board.boardState[a_row_s][a_col_s].type, board.boardState[a_row_h][a_col_h].type = board.boardState[a_row_h][a_col_h].type, board.boardState[a_row_s][a_col_s].type
        board.boardState[a_row_s][a_col_s].spr, board.boardState[a_row_h][a_col_h].spr = board.boardState[a_row_h][a_col_h].spr, board.boardState[a_row_s][a_col_s].spr
        board.boardState[a_row_s][a_col_s].used, board.boardState[a_row_h][a_col_h].used = board.boardState[a_row_h][a_col_h].used, board.boardState[a_row_s][a_col_s].used

        b_row_h = a_row_h
        b_col_h = a_col_h
        a_row_h = 0
        a_col_h = 0
        a_row_s = 0
        a_col_s = 0
        b_row_s = 0
        b_col_s = 0
        module = EMPTY
        board:valid_reset()
        ability_selected = false
        board_phase = true
    end
end