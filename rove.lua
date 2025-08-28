-- Main Built-In Pico Functions
function _init()
    init_actors()


    -- Changing Peach to be transparent
    palt(BLACK, false)
    palt(PEACH, true)
end

function _update()
    update_ply1()    
end

function _draw()
    cls()
    draw_screen()
end