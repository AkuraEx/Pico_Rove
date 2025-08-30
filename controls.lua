function play_card()
  -- left
  if btnp(0) and c_h > 1 then
    c_h -= 1
  end
  -- right
  if btnp(1) and c_h < #hand then
    c_h += 1
  end
  -- x
  if btnp(5) then
    if hand[c_h]:match(0, 0) or hand[c_h]:match(1, 0) or hand[c_h]:match(0, 1) or hand[c_h]:match(1, 1) or hand[c_h]:match(0, 2) or hand[c_h]:match(1, 2) then
        move += hand[c_h].matchValue
    else 
        move += hand[c_h].value
    end
    deli(hand, c_h)
    c_h = 1
    card_phase = false
    board_phase = true
    info = "mOVE tILES"
  end
end

function play_board()
    -- left
    if btnp(0) and b_col_h > 1 then
        b_col_h -= 1
    end
    -- right
    if btnp(1) and b_col_h < 5 then
        b_col_h += 1
    end
    -- up
    if btnp(2) and b_row_h > 1 then
        b_row_h -= 1
    end
    -- down
    if btnp(3) and b_row_h < 4 then
        b_row_h += 1
    end
    -- Press x without module selected
    if btnp(5) and b_row_s == 0 and board.boardState[b_row_h][b_col_h].type ~= 0 then
        info = "mOVE tILE OR aCTIVATE"
        b_col_s = b_col_h
        b_row_s = b_row_h
    -- Press x with module selected
    elseif btnp(5) and b_row_s ~= 0 then
        -- Very Long Swap Statement
        board.boardState[b_row_s][b_col_s].type, board.boardState[b_row_h][b_col_h].type = board.boardState[b_row_h][b_col_h].type, board.boardState[b_row_s][b_col_s].type
        board.boardState[b_row_s][b_col_s].spr, board.boardState[b_row_h][b_col_h].spr = board.boardState[b_row_h][b_col_h].spr, board.boardState[b_row_s][b_col_s].spr
        board.boardState[b_row_s][b_col_s].used, board.boardState[b_row_h][b_col_h].used = board.boardState[b_row_h][b_col_h].used, board.boardState[b_row_s][b_col_s].used
        b_row_s = 0
        b_col_s = 0
        move -= 1

        if(move == 0) then
            card_phase = true
            board_phase = false
            info = "pLAY cARD"
        end
    end

    -- back out of tile
    if btnp(4) and b_row_s ~= 0 then
        b_row_s = 0
        b_col_s = 0
        info = "mOVE tILES"
    end
end


--
--   if(deck.cardAmount > 0) then
--      hand[c_h] = deck:pop()
--    else
--      deli(hand, c_h)
--      c_h = 1
--    end