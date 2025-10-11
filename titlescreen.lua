title_counter = 0
option_select = 0

function start_title()
    
end

function update_title()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    titlecontrols()
    title_counter += 1
    if title_counter > 2000 then
        title_counter = 0
    end

    if mouse_y >= 106 and mouse_y <= 116 and mouse_x >= 31 and mouse_x <= 97 then
        option_select = 1
    elseif mouse_y >= 96 and mouse_y <= 106 and mouse_x >= 31 and mouse_x <= 97 then
        option_select = 0
    end
end

function draw_title()
    rectfill(0, 0, 127, 127, PEACH)
    circfill(35, 70, 40, WHITE)
    for i = 1, 16 do
        line(0, 80 + i, 90, 50, WHITE)
    end

    rectfill(0, 100, 127, 127, ORANGE)
    rectfill(0, 110, 127, 127, MAGENTA)
    rectfill(30, 95, 98, 115, BLACK)

    rectfill(31, 96 + (option_select * 10), 97, 104 + (option_select * 10), LAVENDER)

    print("sTART gAME", 35, 97, WHITE)
    print("hOW tO pLAY", 32, 107, WHITE)
end