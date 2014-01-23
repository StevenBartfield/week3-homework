Dice::Application.routes.draw do
  

get("/dicegame", { :controller => "dicegame", :action => "play_dice_game"})



end
