menu_select = 0


-- Title Screen Menu
function start_title()
    
end

function update_title()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    titlecontrols()

    if mouse_y >= 106 and mouse_y <= 116 and mouse_x >= 31 and mouse_x <= 97 then
        menu_select = 1
    elseif mouse_y >= 96 and mouse_y <= 106 and mouse_x >= 31 and mouse_x <= 97 then
        menu_select = 0
    end
end

function draw_title()
    rectfill(0, 0, 127, 127, PEACH)
    circfill(35, 70, 40, WHITE)
    for i = 1, 16 do
        line(0, 80 + i, 90, 50, WHITE)
    end

    draw_background()
    rectfill(30, 95, 98, 115, BLACK)

    rectfill(31, 96 + (menu_select * 10), 97, 104 + (menu_select * 10), LAVENDER)

    print("sTART gAME", 35, 97, WHITE)
    print("hOW tO pLAY", 32, 107, WHITE)
end



-- Game Over menu

function update_gameover()
    local mouse_x = stat(32)
    local mouse_y = stat(33)

    gameovercontrols()

    if mouse_y >= 106 and mouse_y <= 116 and mouse_x >= 31 and mouse_x <= 97 then
        menu_select = 1
    elseif mouse_y >= 96 and mouse_y <= 106 and mouse_x >= 31 and mouse_x <= 97 then
        menu_select = 0
    end
end

function draw_gameover()
    rectfill(30, 30, 98, 50, BLACK)
    rect(29, 29, 99, 51, GREY)
    print("game over", 38, 37, WHITE)

    rectfill(30, 95, 98, 115, BLACK)

    rectfill(31, 96 + (menu_select * 10), 97, 104 + (menu_select * 10), LAVENDER)

    print("tRY aGAIN", 38, 97, WHITE)
    print("mAIN mENU", 38, 107, WHITE)
end