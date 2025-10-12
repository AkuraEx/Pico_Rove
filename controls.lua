function play_card()

  -- check mouse
  for i = 1, #hand do
    if stat(32) >= hand[i].x and stat(32) <= hand[i].x + 18 and stat(33) >= 100 and stat(33) <= 120 then
        c_h = i
        break
    end
  end

  -- left
  if btnp(0) and c_h > 1 then
    c_h -= 1
  end
  -- right
  if btnp(1) and c_h < #hand then
    c_h += 1
  end
  -- x
  if btnp(5) or left_click() and stat(32) >= hand[c_h].x and stat(32) <= hand[c_h].x + 18 and stat(33) >= 100 and stat(33) <= 120 then
    value = hand[c_h].value
    for i = 0, ROWS - 3 do
        for j = 0, COLS - 3 do
            if hand[c_h]:match(i, j) then
                value = hand[c_h].matchValue
            break
            end
        end
    end
    move += value
    deli(hand, c_h)
    c_h = 0
    card_phase = false
    board_phase = true
    info = "mOVE tILES"
  end
end

function play_board()

    -- check mouse 
    for i = 1, ROWS do
        for j = 1, COLS do
            if stat(32) > board.boardState[i][j].x and stat(32) < board.boardState[i][j].x + 19 and stat(33) > board.boardState[i][j].y and stat(33) < board.boardState[i][j].y + 12 then
                b_row_h = i
                b_col_h = j
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
        b_col_h -= 1
    end
    -- right
    if btnp(1) and b_col_h < COLS then
        b_col_h += 1
    end
    -- up
    if btnp(2) and b_row_h > 1 then
        b_row_h -= 1
    end
    -- down
    if btnp(3) and b_row_h < ROWS then
        b_row_h += 1
    end
    -- Press x without module selected
    if (btnp(5) or (click and stat(32) > board.boardState[b_row_h][b_col_h].x and stat(32) < board.boardState[b_row_h][b_col_h].x + 19 and stat(33) > board.boardState[b_row_h][b_col_h].y and stat(33) < board.boardState[b_row_h][b_col_h].y + 12)) and b_row_s == 0 and board.boardState[b_row_h][b_col_h].type ~= 0 then
        b_col_s = b_col_h
        b_row_s = b_row_h
        module = board.boardState[b_row_s][b_col_s].type
        -- concatenation
        info = "❎ mOVE ❎❎ aBILITY:" .. tostr(board.boardState[b_row_s][b_col_s].used)

        -- Draw Valid Path
        if module == COIL then        
            board:coil_valid_path(b_row_s, b_col_s, 1, 0, false)
            board:coil_valid_path(b_row_s, b_col_s, 1, 1, false)
            board:coil_valid_path(b_row_s, b_col_s, 0, 1, false)
            board:coil_valid_path(b_row_s, b_col_s, -1, 0, false)
            board:coil_valid_path(b_row_s, b_col_s, -1, -1, false)
            board:coil_valid_path(b_row_s, b_col_s, 0, -1, false)
            board:coil_valid_path(b_row_s, b_col_s, 1, -1, false)
            board:coil_valid_path(b_row_s, b_col_s, -1, 1, false)
        else 
            board:valid_path(module)
        end
    -- Press x with module selected
    elseif (btnp(5) or (click and stat(32) > board.boardState[b_row_h][b_col_h].x and stat(32) < board.boardState[b_row_h][b_col_h].x + 19 and stat(33) > board.boardState[b_row_h][b_col_h].y and stat(33) < board.boardState[b_row_h][b_col_h].y + 12)) and b_row_s ~= 0 and board.boardState[b_row_s][b_col_s] ~= board.boardState[b_row_h][b_col_h] then

        -- Valid Move Check
        if board:move_tile() then
            b_row_s = 0
            b_col_s = 0
            board:valid_reset()
            move -= 1
        end

        for i = 0, 2 do
            for j = 0, 3 do
                if board:match(i, j) then
                    move = 0
                    if #hand > 0 do
                        add(hand, deck:pop())
                    end
                    card_phase = true
                    board_phase = false
                    add(deck.completed, current_mission)
                    current_mission = mission_deck:pop_mission()
                    break
                end
            end
        end

        if(move == 0) then
            card_phase = true
            board_phase = false
            module = EMPTY
            info = "pLAY cARD"
            c_h = 1
        end

    -- If Ability Selected
    elseif btnp(5) and board.boardState[b_row_h][b_col_h] == board.boardState[b_row_s][b_col_s] then
        ability_selected = true
        board_phase = false
        board:valid_reset()
        a_row_h = b_row_s
        a_col_h = b_col_s
    end


    -- back out of tile
    if btnp(4) and b_row_s ~= 0 then
        b_row_s = 0
        b_col_s = 0
        board:valid_reset()
        info = "mOVE tILES"
        module = EMPTY
    end
end


--
--   if(deck.cardAmount > 0) then
--      hand[c_h] = deck:pop()
--    else
--      deli(hand, c_h)
--      c_h = 1
--    end

--
--   if(deck.cardAmount > 0) then
--      hand[c_h] = deck:pop()
--    else
--      deli(hand, c_h)
--      c_h = 1
--    end