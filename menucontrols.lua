function titlecontrols()
    if btnp(2) and menu_select > 0 then
        menu_select -= 1
    -- down
    elseif btnp(3) and menu_select < 1 then
        menu_select += 1
    -- option select
    elseif (btnp(5) or (left_click() and stat(33) >= 96 and stat(33) <= 106 and stat(32) >= 31 and stat(32) <= 97))and menu_select == 0 then
        MAINMENU = false
        INGAME = true
        menu_select = 0
        start_game()
    end
end

function gameovercontrols()
    click = left_click()

    if btnp(2) and menu_select > 0 then
        menu_select -= 1
    -- down
    elseif btnp(3) and menu_select < 1 then
        menu_select += 1
    end

    -- Retry Game
    if (btnp(5) or (click and stat(33) >= 96 and stat(33) <= 106 and stat(32) >= 31 and stat(32) <= 97))and menu_select == 0 then
        GAMEOVER = false
        INGAME = true
        menu_select = 0
        start_game()
    end

    -- Main Menu
    if (btnp(5) or (click and stat(33) >= 106 and stat(33) <= 117 and stat(32) >= 31 and stat(32) <= 97))and menu_select == 1 then
        GAMEOVER = false
        MAINMENU = true
        menu_select = 0
    end
end

function wincontrols()
    click = left_click()

    if btnp(2) and menu_select > 0 then
        menu_select -= 1
    -- down
    elseif btnp(3) and menu_select < 1 then
        menu_select += 1
    end

    -- Retry Game
    if (btnp(5) or (click and stat(33) >= 96 and stat(33) <= 106 and stat(32) >= 31 and stat(32) <= 97))and menu_select == 0 then
        WIN = false
        INGAME = true
        menu_select = 0
        start_game()
    end

    -- Main Menu
    if (btnp(5) or (click and stat(33) >= 106 and stat(33) <= 117 and stat(32) >= 31 and stat(32) <= 97))and menu_select == 1 then
        WIN = false
        MAINMENU = true
        menu_select = 0
    end
end