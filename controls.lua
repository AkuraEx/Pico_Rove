function play_card()
  -- left
  if btnp(0) and card_highlight > 1 then
    card_highlight -= 1
  end
  -- right
  if btnp(1) and card_highlight < #hand then
    card_highlight += 1
  end
  -- x
  if btnp(5) then
    move += hand[card_highlight].value
    deli(hand, card_highlight)
    card_highlight = 1
    card_phase = false
    board_phase = true
    info = "mOVE tILES"
  end
end

function play_board()
    -- left
    if btnp(0) and board_col_highlight > 1 then
        board_col_highlight -= 1
    end
    -- right
    if btnp(1) and board_col_highlight < 5 then
        board_col_highlight += 1
    end
    -- up
    if btnp(2) and board_row_highlight > 1 then
        board_row_highlight -= 1
    end
    -- down
    if btnp(3) and board_row_highlight < 4 then
        board_row_highlight += 1
    end
    -- Press x without module selected
    if btnp(5) and board_row_selected == 0 then
        info = "mOVE tILE OR aCTIVATE"
        board_col_selected = board_col_highlight
        board_row_selected = board_row_highlight
    -- Press x with module selected
    elseif btnp(5) and board_row_selected ~= 0 then
        -- Very Long Swap Statement
        board.boardState[board_row_selected][board_col_selected].type, board.boardState[board_row_highlight][board_col_highlight].type = board.boardState[board_row_highlight][board_col_highlight].type, board.boardState[board_row_selected][board_col_selected].type
        board.boardState[board_row_selected][board_col_selected].spr, board.boardState[board_row_highlight][board_col_highlight].spr = board.boardState[board_row_highlight][board_col_highlight].spr, board.boardState[board_row_selected][board_col_selected].spr
        board.boardState[board_row_selected][board_col_selected].used, board.boardState[board_row_highlight][board_col_highlight].used = board.boardState[board_row_highlight][board_col_highlight].used, board.boardState[board_row_selected][board_col_selected].used
        board_row_selected = 0
        board_col_selected = 0
        move -= 1

        if(move == 0) then
            card_phase = true
            board_pahase = false
            info = "pLAY cARD"
        end
    end
end


--
--   if(deck.cardAmount > 0) then
--      hand[card_highlight] = deck:pop()
--    else
--      deli(hand, card_highlight)
--      card_highlight = 1
--    end