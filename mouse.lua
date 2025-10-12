timer = 0

function draw_mouse()
    mouse_x = stat(32)
    mouse_y = stat(33)
    spr(2, mouse_x, mouse_y, 1, 1.2)
end

function left_click()
    if stat(34) == 1 and timer == 0 then
        timer = 1
        return true
    else
        return false
    end
end

function mouse_timer()
    if timer > 0 and timer < 3 then
        timer += 1
    else
        timer = 0
    end
end