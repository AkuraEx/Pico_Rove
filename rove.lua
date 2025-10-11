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
    if not INGAME do
    update_title()
    else
    update_game()    
    end
end

function _draw()
    cls()

    if not INGAME do
    draw_title()
    else 
    draw_screen()
    end

    draw_mouse()

end