-- Main Built-In Pico Functions
function _init()
    init_actors()
end

function _update()
    update_ply1()    
end

function _draw()
    cls()
    draw_screen()
    for card in all(cards) do
        card:draw()
    end
end