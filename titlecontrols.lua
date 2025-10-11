function titlecontrols()
    if btnp(2) and option_select > 0 then
        option_select -= 1
    -- down
    elseif btnp(3) and option_select < 1 then
        option_select += 1
    -- option select
    elseif (btnp(5) or (stat(34) == 1 and stat(33) >= 96 and stat(33) <= 106 and stat(32) >= 31 and stat(32) <= 97))and option_select == 0 then
        INGAME = true
        start_game()
    end
end