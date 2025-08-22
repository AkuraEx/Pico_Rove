number = 0
card_selected = 1

function init_actors()
  cards = {}

  for i = 1, 5 do
    add(cards, card:new({
      x= 18 * i,
      value = flr(rnd(13))
    }))
  end

end

function update_ply1()
  -- left
  if btnp(0) and card_selected > 1 then
    card_selected -= 1
  end
  -- right
  if btnp(1) and card_selected < 5 then
    card_selected += 1
  end
  -- x
  if btnp(5) then
    number += cards[card_selected].value
    cards[card_selected].value = flr(rnd(13))
  end
end

function draw_screen()
    print("press x to add", 0, 0, WHITE)
    print(number, MIDDLE, MIDDLE, GREEN)
    rect(cards[card_selected].x - 1, cards[card_selected].y - 1, cards[card_selected].x + 16, cards[card_selected].y + 24, WHITE)
end
