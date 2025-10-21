function draw_background()

    rectfill(0, 0, 127, 127, PEACH)

    circfill(35, 70, 40, WHITE)
    for i = 1, 16 do
        line(0, 80 + i, 90, 50, WHITE)
    end

    -- rectfill(125 - counter, 50, 175 - counter, 120, ORANGE)
    for i = 0, 5 do
        spr(160, (i * 32) - (counter / 16) % 32, 100, 4, 1.9)
    end
    -- rectfill(0, 100, 127, 127, ORANGE)

    -- rectfill(100 - counter * 2, 80, 150 - counter * 2, 127, MAGENTA)
    rectfill(0, 119, 127, 127, MAGENTA)
     for i = 0, 5 do
         spr(224, (i * 32) - (counter) % 32, 108, 4, 2)
     end
end