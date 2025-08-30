card_phase = true
board_phase = false
card_highlight = 1
board_row_highlight = 1
board_col_highlight = 1
board_row_selected = 0
board_col_selected = 0
-- New variables for direct sprite movement
moving_module_row = 0
moving_module_col = 0
breadcrumbs = {}
movement_step = 0
mission = 1
move = 0
info = "pLAY cARD"

-- Double-selection variables for finishing movement early
last_select_row = 0
last_select_col = 0
last_select_time = 0
double_click_threshold = 0.5  -- Time window in seconds for double-selection

-- Mission system variables
mission_deck = nil
current_mission = nil

function init_actors()
  deck = deck:new()
  deck:init()
  deck:shuffle()
  hand = {}

  -- hand init
  for i = 1, NORMAL do
    add(hand, deck:pop())
  end

  -- board init
  board = board:new()
  board:init()

  -- initialize breadcrumbs table
  breadcrumbs = {}
  for i = 1, 4 do
    breadcrumbs[i] = {}
    for j = 1, 5 do
      breadcrumbs[i][j] = 0
    end
  end

  -- Mission deck initialization
  mission_deck = deck:new()
  mission_deck:init_missions()
  mission_deck:shuffle()
  current_mission = mission_deck:pop()

end

function update_game()
  if card_phase then
    play_card()
  elseif board_phase then
    play_board()
  end
end

function draw_screen()
    rectfill(0, 0, 127, 127, DARK_BLUE)

    -- Game Info
    print(info, 0, 0, WHITE)
    print("mOVES:", 0, 10, GREEN)
    print(move, 47, 10, GREEN)
    print("mISSION:", 0, 20, WHITE)
    print(mission, 47, 20, WHITE)

    -- # Means Size in Lua. Weird AF syntax
    for i = 1, #hand do
      hand[i]:draw(i)
    end



    deck:draw()
    board:draw()
    
    -- Draw current mission
    if current_mission then
        current_mission:draw()
    end
    
    high_light()
end

function load_monogram()
	-- enable custom fonts
	poke(0x5f58,0x81)
	
	-- add font to memory
	poke(0x5600,unpack(split"6,6,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,0,0,0,31,31,31,0,0,0,0,0,31,27,31,0,0,0,0,0,27,4,27,0,0,0,0,0,27,0,27,0,0,0,0,0,27,27,27,0,0,0,0,8,12,14,12,8,0,0,0,2,6,14,6,2,0,0,15,1,1,1,1,0,0,0,0,0,16,16,16,16,30,0,17,10,4,31,4,31,4,0,0,0,0,14,0,0,0,0,0,0,0,0,0,6,12,0,0,0,0,0,0,12,12,0,0,0,10,10,0,0,0,0,0,4,10,4,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,4,0,10,10,0,0,0,0,0,0,0,10,31,10,10,31,10,0,8,62,11,62,104,62,8,0,0,51,24,12,6,51,0,0,6,9,9,30,9,9,22,0,8,4,0,0,0,0,0,0,8,4,4,4,4,4,8,0,2,4,4,4,4,4,2,0,0,4,21,14,21,4,0,0,0,4,4,31,4,4,0,0,0,0,0,0,0,4,4,2,0,0,0,31,0,0,0,0,0,0,0,0,0,4,4,0,16,16,8,4,2,1,1,0,14,17,25,21,19,17,14,0,4,6,4,4,4,4,31,0,14,17,16,8,4,2,31,0,14,17,16,12,16,17,14,0,18,18,17,31,16,16,16,0,31,1,1,15,16,16,15,0,14,1,1,15,17,17,14,0,31,16,16,8,4,4,4,0,14,17,17,14,17,17,14,0,14,17,17,30,16,16,14,0,0,4,4,0,0,4,4,0,0,4,4,0,0,4,4,2,0,24,6,1,6,24,0,0,0,0,31,0,31,0,0,0,0,3,12,16,12,3,0,0,14,17,16,8,4,0,4,0,14,25,21,21,25,1,14,0,0,0,30,17,17,17,30,0,1,1,15,17,17,17,15,0,0,0,14,17,1,17,14,0,16,16,30,17,17,17,30,0,0,0,14,17,31,1,14,0,12,18,2,15,2,2,2,0,0,0,30,17,17,30,16,14,1,1,15,17,17,17,17,0,4,0,6,4,4,4,31,0,16,0,24,16,16,16,17,14,1,1,17,9,7,9,17,0,3,2,2,2,2,2,28,0,0,0,15,21,21,21,21,0,0,0,15,17,17,17,17,0,0,0,14,17,17,17,14,0,0,0,15,17,17,15,1,1,0,0,30,17,17,30,16,16,0,0,13,19,1,1,1,0,0,0,30,1,14,16,15,0,2,2,15,2,2,2,28,0,0,0,17,17,17,17,30,0,0,0,17,17,17,10,4,0,0,0,17,17,21,21,10,0,0,0,17,10,4,10,17,0,0,0,17,17,17,30,16,14,0,0,31,8,4,2,31,0,12,4,4,4,4,4,12,0,1,1,2,4,8,16,16,0,12,8,8,8,8,8,12,0,4,10,17,0,0,0,0,0,0,0,0,0,0,0,31,0,2,4,0,0,0,0,0,0,14,17,17,17,31,17,17,0,15,17,17,15,17,17,15,0,14,17,1,1,1,17,14,0,15,17,17,17,17,17,15,0,31,1,1,15,1,1,31,0,31,1,1,15,1,1,1,0,14,17,1,29,17,17,14,0,17,17,17,31,17,17,17,0,31,4,4,4,4,4,31,0,16,16,16,16,17,17,14,0,17,9,5,3,5,9,17,0,1,1,1,1,1,1,31,0,17,27,21,17,17,17,17,0,17,17,19,21,25,17,17,0,14,17,17,17,17,17,14,0,15,17,17,15,1,1,1,0,14,17,17,17,21,9,22,0,15,17,17,15,17,17,17,0,14,17,1,14,16,17,14,0,31,4,4,4,4,4,4,0,17,17,17,17,17,17,14,0,17,17,17,17,17,10,4,0,17,17,17,17,21,27,17,0,17,17,10,4,10,17,17,0,17,17,10,4,4,4,4,0,31,16,8,4,2,1,31,0,8,4,4,2,4,4,8,0,4,4,4,0,4,4,4,0,4,8,8,16,8,8,4,0,0,0,18,13,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,0,21,10,21,10,21,10,21,0,0,17,31,21,21,14,0,0,14,31,17,27,14,17,14,0,17,4,17,4,17,4,17,0,2,6,30,14,15,12,8,0,0,14,19,19,31,23,14,0,0,27,31,31,14,4,0,0,4,17,14,27,27,14,17,4,0,14,14,0,31,14,10,0,0,4,14,31,21,29,0,0,14,27,25,27,14,17,14,0,0,14,31,21,31,17,14,0,4,12,20,20,4,7,3,0,14,17,21,17,14,17,14,0,0,4,14,27,14,4,0,0,0,0,0,21,0,0,0,0,14,27,19,27,14,17,14,0,0,0,4,31,14,27,0,0,31,17,10,4,10,17,31,0,14,27,17,31,14,17,14,0,0,5,2,0,20,8,0,0,8,21,2,0,8,21,2,0,14,21,27,21,14,17,14,0,31,0,31,0,31,0,31,0,21,21,21,21,21,21,21,0"))
end

function high_light()
    if card_phase then 
      start = ((card_highlight - 1) * 18) + 4 
      rect(start, hand[card_highlight].y - 1, start + 18, hand[card_highlight].y + 25, GREEN)
    elseif board_phase then
      -- Draw breadcrumbs first
      for i = 1, 4 do
        for j = 1, 5 do
          if breadcrumbs[i][j] > 0 then
            local x = 12 + (21 * (j - 1)) + 8
            local y = 30 + (16 * (i - 1)) + 6
            print(breadcrumbs[i][j], x, y, YELLOW)
          end
        end
      end
      
      -- Highlight cursor or moving module
      if moving_module_row > 0 then
        -- Highlight the moving module with a different color
        x = 12 + (21 * (moving_module_col - 1))
        y = 30 + (16 * (moving_module_row - 1))
        rect(x, y, x + 19, y + 15, RED)
      else
        -- Normal cursor highlighting
        x = 12 + (21 * (board_col_highlight - 1))
        y = 30 + (16 * (board_row_highlight - 1))
        rect(x, y, x + 19, y + 15, GREEN)
      end
    end
end

-- Check if a card's pattern matches any 3x3 region on the board
-- TODO: Reuse with passed flag to also check mission success after card placement
-- TODO: Adjust to allow for flexible grid, that'll be a doozy

function check_pattern_match(card, board_state)
  -- The 4x5 board has 6 possible 3x3 regions to check
  -- Top row: (1,1), (1,2), (1,3)
  -- Bottom row: (2,1), (2,2), (2,3)
  for start_row = 1, 2 do
    for start_col = 1, 3 do
      local pattern_matches = true
      
      -- Check each position in the 3x3 pattern
      for pattern_row = 1, 3 do
        for pattern_col = 1, 3 do
          local board_row = start_row + pattern_row - 1
          local board_col = start_col + pattern_col - 1
          local card_value = card.modules[pattern_row][pattern_col]
          local board_value = board_state[board_row][board_col].type
          
          -- Pattern matching rules:
          -- 0 (EMPTY) in card pattern matches anything
          -- FILLED in card pattern matches any non-empty tile
          -- Specific types must match exactly
          if card_value == EMPTY then
            -- EMPTY matches anything, continue
          elseif card_value == FILLED then
            -- FILLED matches any non-empty tile
            if board_value == EMPTY then
              pattern_matches = false
              break
            end
          else
            -- Specific type must match exactly
            if card_value ~= board_value then
              pattern_matches = false
              break
            end
          end
        end
        
        if not pattern_matches then
          break
        end
      end
      
      -- If we found a match in this 3x3 region, return true
      if pattern_matches then
        return true
      end
    end
  end
  
  -- No pattern matches found
  return false
end

-- Check if current mission is completed
-- Mission logic: 6 filled positions + 1 specific module in the 3x4 pattern
function check_mission_complete()
  local mission_modules = current_mission.modules
  
  -- Count filled positions and check for required specific module
  local filled_count = 0
  local required_module_found = false
  local required_module = nil
  
  -- First pass: identify the required specific module (non-EMPTY, non-FILLED)
  for i = 1, 4 do
    for j = 1, 3 do
      if mission_modules[i][j] ~= EMPTY and mission_modules[i][j] ~= FILLED then
        required_module = mission_modules[i][j]
        break
      end
    end
    if required_module then break end
  end
  
  -- Second pass: check if pattern exists anywhere on board
  for start_row = 1, 1 do  -- 4x5 board can fit 3x4 pattern starting at row 1 only
    for start_col = 1, 3 do  -- Can start at columns 1, 2, or 3
      filled_count = 0
      required_module_found = false
      
      -- Check each position in the 3x4 pattern
      for pattern_row = 1, 4 do
        for pattern_col = 1, 3 do
          local board_row = start_row + pattern_row - 1
          local board_col = start_col + pattern_col - 1
          local mission_value = mission_modules[pattern_row][pattern_col]
          local board_value = board.boardState[board_row][board_col].type
          
          if mission_value == FILLED then
            -- Count filled positions
            if board_value ~= EMPTY then
              filled_count += 1
            end
          elseif mission_value ~= EMPTY then
            -- Check for specific required module
            if board_value == mission_value then
              required_module_found = true
              filled_count += 1
            end
          end
        end
      end
      
      -- Check if this position satisfies mission requirements
      if filled_count >= 6 and (required_module == nil or required_module_found) then
        return true
      end
    end
  end
  
  return false
end