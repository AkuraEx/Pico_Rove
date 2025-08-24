number = 0
card_selected = 1

function init_actors()
  deck = deck:new()
  deck:init()
  hand = {}
  for i = 1, 5 do
    add(hand, deck:pop())
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
    number += hand[card_selected].value
    hand[card_selected] = deck:pop()
  end
end

function draw_screen()
    print("press x to add", 0, 0, WHITE)
    print(number, MIDDLE, MIDDLE, GREEN)
    rect(18 * card_selected - 1, hand[card_selected].y - 1, 18 * card_selected + 16, hand[card_selected].y + 24, WHITE)
    for i = 1, 5 do
      hand[i]:draw(i)
    end
    deck:draw()
end
