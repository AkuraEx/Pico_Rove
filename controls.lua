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
            -- Update tracking variables for double-selection detection
            last_select_row = board_row_highlight
            last_select_col = board_col_highlight
            last_select_time = time()
            
            -- Select the module and remove it from board state during movement
            moving_module_row = board_row_highlight
            moving_module_col = board_col_highlight
            movement_step = 1
            
            -- Store the moving module data separately
            moving_module_type = board.boardState[board_row_highlight][board_col_highlight].type
            moving_module_spr = board.boardState[board_row_highlight][board_col_highlight].spr
            moving_module_used = board.boardState[board_row_highlight][board_col_highlight].used
            
            -- Clear the module from board state during movement
            board.boardState[board_row_highlight][board_col_highlight].type = EMPTY
            board.boardState[board_row_highlight][board_col_highlight].spr = 0
            board.boardState[board_row_highlight][board_col_highlight].used = 0
            
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
        
        -- Press x to place module at current position
        if btnp(5) then
            -- Place module back on board at current position
            local final_destination_occupied = board.boardState[moving_module_row][moving_module_col].type ~= EMPTY
            local placement_allowed = false
            
            if not final_destination_occupied then
                -- Empty destination - place module
                placement_allowed = true
            elseif moving_module_type ~= CRANE then
                -- Non-CRANE modules cannot land on occupied spaces
                placement_allowed = false
            else
                -- CRANE should have cleared the path already
                placement_allowed = false
            end
            
            if placement_allowed then
                -- Place module at current position
                board.boardState[moving_module_row][moving_module_col].type = moving_module_type
                board.boardState[moving_module_row][moving_module_col].spr = moving_module_spr
                board.boardState[moving_module_row][moving_module_col].used = moving_module_used
            else
                -- Return module to starting position (first breadcrumb)
                for i = 1, 4 do
                    for j = 1, 5 do
                        if breadcrumbs[i][j] == 1 then
                            board.boardState[i][j].type = moving_module_type
                            board.boardState[i][j].spr = moving_module_spr
                            board.boardState[i][j].used = moving_module_used
                            break
                        end
                    end
                end
            end
            
            -- Reset movement state
            moving_module_row = 0
            moving_module_col = 0
            movement_step = 0
            moving_module_type = 0
            moving_module_spr = 0
            moving_module_used = 0
            
            -- Check if we still have movement points
            if move > 0 then
                -- Return to cursor selection mode with remaining movement
                info = "mOVE tILES"
            else
                -- No movement left, end turn
                card_phase = true
                board_phase = false
                info = "pLAY cARD"
            end
        end
        
        -- Execute movement with proper CRANE chain-pushing logic
        if can_move and move > 0 then
            local destination_occupied = board.boardState[new_row][new_col].type ~= EMPTY
            local movement_allowed = false
            
            if not destination_occupied then
                -- Destination is empty - always allow movement
                movement_allowed = true
            elseif moving_module_type == CRANE then
                -- CRANE never passes over modules - must push entire chain every step
                local push_direction_row = new_row - moving_module_row
                local push_direction_col = new_col - moving_module_col
                
                -- Find all modules in the push chain
                local modules_to_push = {}
                local check_row = new_row
                local check_col = new_col
                
                -- Collect all consecutive modules in the push direction
                while check_row >= 1 and check_row <= 4 and check_col >= 1 and check_col <= 5 do
                    if board.boardState[check_row][check_col].type ~= EMPTY then
                        add(modules_to_push, {
                            row = check_row,
                            col = check_col,
                            type = board.boardState[check_row][check_col].type,
                            spr = board.boardState[check_row][check_col].spr,
                            used = board.boardState[check_row][check_col].used
                        })
                        -- Move to next position in chain
                        check_row += push_direction_row
                        check_col += push_direction_col
                    else
                        break -- Found empty space, can push here
                    end
                end
                
                -- Check if the final push position is valid and empty
                if check_row >= 1 and check_row <= 4 and check_col >= 1 and check_col <= 5 and 
                   board.boardState[check_row][check_col].type == EMPTY then
                    -- Execute the chain push - push all modules one position forward
                    for i = #modules_to_push, 1, -1 do -- Push from back to front
                        local module = modules_to_push[i]
                        local new_push_row = module.row + push_direction_row
                        local new_push_col = module.col + push_direction_col
                        
                        -- Move this module forward
                        board.boardState[new_push_row][new_push_col].type = module.type
                        board.boardState[new_push_row][new_push_col].spr = module.spr
                        board.boardState[new_push_row][new_push_col].used = module.used
                        
                        -- Clear old position
                        board.boardState[module.row][module.col].type = EMPTY
                        board.boardState[module.row][module.col].spr = 0
                        board.boardState[module.row][module.col].used = 0
                    end
                    movement_allowed = true
                end
            else
                -- Other modules can pass through occupied spaces during movement
                movement_allowed = true
            end
            
            -- Execute movement if allowed
            if movement_allowed then
                -- Leave breadcrumb at current position (visual only)
                breadcrumbs[moving_module_row][moving_module_col] = movement_step
                movement_step += 1
                
                -- Update module position
                moving_module_row = new_row
                moving_module_col = new_col
                
                -- Deduct movement point
                move -= 1
                
                -- Check if movement finished
                if move == 0 then
                    -- Movement complete - place module back on board
                    -- For CRANE, destination should be empty after pushing
                    -- For others, check final destination collision
                    local final_destination_occupied = board.boardState[moving_module_row][moving_module_col].type ~= EMPTY
                    local placement_allowed = false
                    
                    if not final_destination_occupied then
                        -- Empty destination - place module
                        placement_allowed = true
                    elseif moving_module_type ~= CRANE then
                        -- Non-CRANE modules cannot land on occupied spaces
                        placement_allowed = false
                    else
                        -- CRANE should have cleared the path already
                        placement_allowed = false
                    end
                    
                    if placement_allowed then
                        -- Place module at final position
                        board.boardState[moving_module_row][moving_module_col].type = moving_module_type
                        board.boardState[moving_module_row][moving_module_col].spr = moving_module_spr
                        board.boardState[moving_module_row][moving_module_col].used = moving_module_used
                    else
                        -- Return module to starting position (first breadcrumb)
                        for i = 1, 4 do
                            for j = 1, 5 do
                                if breadcrumbs[i][j] == 1 then
                                    board.boardState[i][j].type = moving_module_type
                                    board.boardState[i][j].spr = moving_module_spr
                                    board.boardState[i][j].used = moving_module_used
                                    break
                                end
                            end
                        end
                    end
                    
                    -- Reset movement state
                    moving_module_row = 0
                    moving_module_col = 0
                    movement_step = 0
                    moving_module_type = 0
                    moving_module_spr = 0
                    moving_module_used = 0
                    card_phase = true
                    board_phase = false
                    info = "pLAY cARD"
                end
            end
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