-- Main Built-In Pico Functions
function _init()
    -- start_title()
    poke(0x5f2d, 0x4 + 0x1)


    -- Changing GREY to be transparent
    palt(BLACK, false)
    palt(GREY, true)

    -- Loading monogram
    load_monogram()
end

function _update()
    if MAINMENU do
    update_title()
    elseif INGAME do
    update_game()    
    elseif GAMEOVER do
    update_gameover()
    elseif WIN do
    update_win()
    end

    counter += 1
    if counter > 2000 then
        counter = 0
    end
    mouse_timer()
end

function _draw()
    cls()

    if INGAME do
    draw_screen()
    elseif MAINMENU do 
    draw_title()
    elseif GAMEOVER do
    draw_screen()
    draw_gameover()
    elseif WIN do
    draw_screen()
    draw_win()
    end

    draw_mouse()

end