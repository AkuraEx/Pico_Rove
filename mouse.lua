function draw_mouse()
    mouse_x = stat(32)
    mouse_y = stat(33)
    rect(mouse_x, mouse_y, mouse_x + 1, mouse_y + 1, BLACK)
end