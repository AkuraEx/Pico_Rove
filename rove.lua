-- Main Built-In Pico Functions
function _init()
    init_actors()


    -- Changing Peach to be transparent
    palt(BLACK, false)
    palt(PEACH, true)

    -- Loading monogram
    load_monogram()
end

function _update()
    update_game()    
end

function _draw()
    cls()
    draw_screen()
end