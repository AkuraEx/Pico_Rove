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

    -- Module Abilities
    if module == LASER then
        info = "sWAP aBILITY"
        laser(click)
    end

    if module == BRAIN then
        info = "rEPOSITION tO bRAIN"
        brain(click)
    end

    if module == COIL then
        info = "rEPOSITION cOIL"
        coil(click)
    end

    if module == MOTOR then
        info = "sHIFT oNE sPACE"
        motor(click)
    end

    if module == SENSOR then
        info = "cLICK tO dRAW"
        sensor(click)
    end

    if module == GRIPPER then
        info = "aCTIVATE aDJACENT"
        gripper(click)
    end

    -- Back out of ability
    if (btnp(4) or right_click()) then
        b_row_h = a_row_h
        b_col_h = a_col_h
        a_row_h = 0
        a_col_h = 0
        a_row_s = 0
        a_col_s = 0
        b_row_s = 0
        b_col_s = 0
        s_row = 0
        s_col = 0
        info = "mOVE tILES"
        module = EMPTY
        board:valid_reset()
        ability_selected = false
        board_phase = true
    end

end

-- swap two tiles
function laser(click)

    if (btnp(5) or click)and a_row_s == 0 and board.boardState[a_row_h][a_col_h].type ~= EMPTY then
        a_row_s = a_row_h
        a_col_s = a_col_h
    end

    if (btnp(5) or click) and board.boardState[a_row_h][a_col_h].type ~= EMPTY and board.boardState[a_row_h][a_col_h] ~= board.boardState[a_row_s][a_col_s] then
        ability_result(a_row_s, a_col_s, a_row_h, a_col_h) 
    end
end


-- Reposition Tile adjacent to Brain
function brain(click)
    if (btnp(5) or click) and a_row_s == 0 and board.boardState[a_row_h][a_col_h].type ~= EMPTY and board.boardState[a_row_h][a_col_h].valid == true then
        a_row_s = a_row_h
        a_col_s = a_col_h
        board:valid_reset()
        board:a_valid_path()
    end

    if (btnp(5) or click) and board.boardState[a_row_h][a_col_h].valid == true and board.boardState[a_row_h][a_col_h] ~= board.boardState[a_row_s][a_col_s] then
       ability_result(a_row_s, a_col_s, a_row_h, a_col_h) 
    end
end


-- Repostion Coil to any valid location
function coil(click)
    if (btnp(5) or click) and board.boardState[a_row_h][a_col_h].valid == true then
        ability_result(b_row_s, b_col_s, a_row_h, a_col_h)
    end
end


-- Draw card if less than five
function sensor(click)
    if (btnp(5) or click) and deck.cardAmount > 0 and #hand < 5 then

        board.boardState[s_row][s_col].used = 0

        add(hand, deck:pop())
        
        b_row_h = a_row_h
        b_col_h = a_col_h
        a_row_h = 0
        a_col_h = 0
        a_row_s = 0
        a_col_s = 0
        b_row_s = 0
        s_row = 0
        s_col = 0

        info = "mOVE tILES"
        module = EMPTY
        board:valid_reset()
        ability_selected = false
        board_phase = true
    end
end


-- Shift Any Module One Space
function motor(click)
    if (btnp(5) or click) and a_row_s == 0 and board.boardState[a_row_h][a_col_h].type ~= EMPTY and board.boardState[a_row_h][a_col_h].valid == true then
        a_row_s = a_row_h
        a_col_s = a_col_h
        board:valid_reset()
        board:a_valid_path()
    end

    if (btnp(5) or click) and board.boardState[a_row_h][a_col_h].valid == true and board.boardState[a_row_h][a_col_h] ~= board.boardState[a_row_s][a_col_s] then
       ability_result(a_row_s, a_col_s, a_row_h, a_col_h) 
    end
end

-- Activate the ability of the adjacent tile
function gripper(click)
    if (btnp(5) or click) and board.boardState[a_row_h][a_col_h].valid == true then
        b_row_s = a_row_h
        b_col_s = a_col_h
        module = board.boardState[a_row_h][a_col_h].type
        board:valid_reset()
        board:a_valid_path()
    end
end


function ability_result(r1, c1, r2, c2)
        -- ability used
        board.boardState[s_row][s_col].used = 0
        -- Swap Statement
        board:swap(r1, c1, r2, c2)

        b_row_h = a_row_h
        b_col_h = a_col_h
        a_row_h = 0
        a_col_h = 0
        a_row_s = 0
        a_col_s = 0
        b_row_s = 0
        b_col_s = 0
        s_row = 0
        s_col = 0

        -- If Match is found
        for i = 0, 2 do
            for j = 0, 3 do
                if board:match(i, j) then
                    move = 0
                    if #hand > 0 do
                        add(hand, deck:pop())
                    end
                    card_phase = true
                    ability_selected = false
                    add(deck.completed, current_mission)
                    current_mission = mission_deck:pop_mission()
                    info = "pLay cArd"
                    module = EMPTY
                    c_h = 1
                    return
                end
            end
        end
        
        -- else
        info = "mOVE tILES"
        module = EMPTY
        board:valid_reset()
        ability_selected = false
        board_phase = true
end