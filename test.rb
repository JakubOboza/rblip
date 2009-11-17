require 'rblip.rb'

# Agenci Mroku
# stevie, password1
# billy, password1

#Stevie
flame_war_set_1 = [
 "#windows to najgorsze co moze cie spotkac",
 "a stabilnosc #windows ?",
 "a za to #linux jest duzo szybszy niz #windows",
 "prawdziwi mężczyźni używają linux",
 "tak developers developers developers...malpy #windows",
 "Nie jestes true",
 "#window to kupa wirusow, tam pewnie powstalo AH1N1",
 "#linux jest pro, #windows jest lame panie",
 "#windows #linux #mac OS X ssie!"
]

#Billy
flame_war_set_2 = [
  "nie masz zadnych argumentow",
  "#windows 7 jest bardziej stabilny niz #linux",
  "nie wiesz co mowisz #windows jest lepszy niz #linux",
  "na linuxie siedzą tylko masochiści, windows jest prosty w obsłudze",
  "uzywanie #linux to jak granie na padzie w FPS'a",
  "Zamiast gentoo #linux Origami 1!!!!11!!!",
  "Naucz moja laske #linux 'a to osiwiejesz",
  "#linux jest jak pamiatka z NRD dla nerdow !",
  "#windows plug'n'play vs #linux plug'n'wtf :D",
  "#mac #windows #linux OS X ssie!"
]

steve = RBlip.new({:login => "stevie", :password => "password1"})
billy = RBlip.new({:login => "billy", :password => "password1"})

linux = steve.get_tag_msgs("linux")
steve.set_status("Czy wiedziales ^#{linux[0]['user_path'].gsub(/.+\//,"")} #windows 7 ma teraz duzo wieksze mozliwosci multimedialne niz #linux ?")
sleep(25)
billy.set_status("^stevie ja ci nie wchodze do domu z lomem #linux na 100%")

1.upto(10) do |i|
  puts "#{i}"
  sleep(35) 
  steve.set_status(flame_war_set_1[rand(flame_war_set_1.length)])
  puts "Stevie nadal sygnal"
  sleep(35)
  billy.set_status(flame_war_set_2[rand(flame_war_set_2.length)])
  puts "Billy nadal sygnal"
end 