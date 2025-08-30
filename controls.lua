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
    -- Check if card pattern matches board and use appropriate value
    local selected_card = hand[card_highlight]
    if check_pattern_match(selected_card, board.boardState) then
      move += selected_card.matchValue
    else
      move += selected_card.value
    end
    
    deli(hand, card_highlight)
    card_highlight = 1
    card_phase = false
    board_phase = true
    info = "mOVE tILES"
    
    -- Clear breadcrumbs for new turn
    for i = 1, 4 do
      for j = 1, 5 do
        breadcrumbs[i][j] = 0
      end
    end
  end
end

function play_board()
    -- No module selected - cursor movement mode
    if moving_module_row == 0 then
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
        -- Press x to select module at cursor position
        if btnp(5) and board.boardState[board_row_highlight][board_col_highlight].type ~= EMPTY then
            moving_module_row = board_row_highlight
            moving_module_col = board_col_highlight
            movement_step = 1
            info = "mOVE sPRITE"
        end
    
    -- Module selected - direct movement mode
    else
        local new_row = moving_module_row
        local new_col = moving_module_col
        local can_move = false
        
        -- left
        if btnp(0) and moving_module_col > 1 then
            new_col = moving_module_col - 1
            can_move = true
        end
        -- right
        if btnp(1) and moving_module_col < 5 then
            new_col = moving_module_col + 1
            can_move = true
        end
        -- up
        if btnp(2) and moving_module_row > 1 then
            new_row = moving_module_row - 1
            can_move = true
        end
        -- down
        if btnp(3) and moving_module_row < 4 then
            new_row = moving_module_row + 1
            can_move = true
        end
        
        -- Execute movement if valid
        if can_move and move > 0 then
            -- Leave breadcrumb at current position
            breadcrumbs[moving_module_row][moving_module_col] = movement_step
            movement_step += 1
            
            -- Move the module
            board.boardState[new_row][new_col].type = board.boardState[moving_module_row][moving_module_col].type
            board.boardState[new_row][new_col].spr = board.boardState[moving_module_row][moving_module_col].spr
            board.boardState[new_row][new_col].used = board.boardState[moving_module_row][moving_module_col].used
            
            -- Clear old position
            board.boardState[moving_module_row][moving_module_col].type = EMPTY
            board.boardState[moving_module_row][moving_module_col].spr = 0
            board.boardState[moving_module_row][moving_module_col].used = 0
            
            -- Update position
            moving_module_row = new_row
            moving_module_col = new_col
            
            -- Deduct movement point
            move -= 1
            
            -- Check if movement finished
            if move == 0 then
                moving_module_row = 0
                moving_module_col = 0
                movement_step = 0
                card_phase = true
                board_phase = false
                info = "pLAY cARD"
            end
        end
        
        -- Press x to finish movement early
        if btnp(5) then
            moving_module_row = 0
            moving_module_col = 0
            movement_step = 0
            info = "mOVE tILES"
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