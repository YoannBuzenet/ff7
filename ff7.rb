#Stuff pour le récit
prompt = "> "

#On définit les personnages du jeu, gentils et méchants.
class Personnage
  attr_accessor :personnage_hp, :personnage_attaque, :personnage_defense, :xp, :lvl, :name, :loot, :personnage_alive
  def initialize(hp, attaque, defense, xp, lvl, name='Joueur', loot=0)
    @personnage_hp = hp
    @personnage_attaque = attaque
    @personnage_defense = defense
    @xp = xp
    @personnage_lvl = lvl
    @name = name
    @loot = loot
    @personnage_alive = true
  end

end

class Inventaire
  attr_accessor :potion, :grenade
  def initialize (potion, grenade)
    @potion = potion
    @grenade = grenade
  end

  def show_potion
    @potion
  end

  def show_grenade
    @grenade
  end

  def addpotion
    @potion += 1
  end

  def removpotion
    @potion -= 1
  end

  def addgrenade
    @grenade += 1
  end

  def removgrenade
    @grenade -= 1
  end
end

#C'est le début du jeu. On initialise certains paramètres.
mon_inventaire = Inventaire.new(0,0)
$mon_inventaire = mon_inventaire
user_nameP = Personnage.new(50,15,3,0,1)
barret = Personnage.new(60,7,2,10,1, 'barret')
equipe = [user_nameP, barret]

#On définit les fonctions de combat - Combat pour UN adversaire
def combat_1ennemi(user_nameP, ennemi)
      numero_tour = 0
puts '      _________  ________      _____ __________    ________________ '
puts '       \_   ___ \ \_____  \    /     \\______   \  /  _  \__    ___/ '
puts '       /    \  \/  /   |   \  /  \ /  \|    |  _/ /  /_\  \|    |    '
puts '       \     \____/    |    \/    Y    \    |   \/    |    \    |    '
puts '        \______  /\_______  /\____|__  /______  /\____|__  /____|    '
puts '               \/         \/         \/       \/         \/          '
  while ennemi.personnage_alive
    puts ""
  if ennemi.personnage_hp <= 0
    puts ""
    puts "--------------------------------"
    puts "Le #{ennemi.name} est mort !"
    puts "--------------------------------"
    puts "Vous gagnez #{ennemi.xp} points d'XP !"
    puts "--------------------------------"
    ennemi.personnage_alive = false

    if ennemi.loot == '1po'
      $mon_inventaire.addpotion
      puts "--------------------------------"
      puts "1x Potion ajoutée à votre inventaire."
      puts "--------------------------------"

    elsif ennemi.loot == '1gre'
      puts "--------------------------------"
      puts "1x Grenade ajoutée à votre inventaire."
      puts "--------------------------------"
      $mon_inventaire.addgrenade

    elsif ennemi.loot == '1po1gre'
        $mon_inventaire.addpotion
        $mon_inventaire.addgrenade
        puts "--------------------------------"
        puts "1x Potion ajoutée à votre inventaire."
        puts "1x Grenade ajoutée à votre inventaire."
        puts "--------------------------------"
    end

    puts ""
  elsif ennemi.personnage_hp > 0

    numero_tour += 1
    puts "--------------------------------"
      puts "Tour n°#{numero_tour}"
      puts "Ennemi : #{ennemi.name}"
      puts "TIRE A DISTANCE"
      puts "POINTS DE VIE : #{ennemi.personnage_hp} HP"
      puts ""
      puts "Que faites-vous ?"
      puts "1. Attaquer"
      puts "2. Défendre"
      puts "3. Utiliser un objet"
      user_choice_3 = $stdin.gets.chomp
      if user_choice_3 == "1"
        puts ""
        puts "BIM !"
        puts "Vous attaquez le #{ennemi.name}."
        puts "Le #{ennemi.name} réduit les dégats de #{ennemi.personnage_defense}."
        degats_totaux = user_nameP.personnage_attaque - ennemi.personnage_defense
        puts "Le #{ennemi.name} subit #{(user_nameP.personnage_attaque - ennemi.personnage_defense)} points de dégats !"
                if ennemi.personnage_hp > 0

                  ennemi.personnage_hp -= degats_totaux
                  puts ""
                  puts "Le #{ennemi.name} vous attaque !"
                  puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                  degats_encaisses = ennemi.personnage_attaque - user_nameP.personnage_defense
                  puts "Vous perdez #{degats_encaisses} points de vie !"
                  user_nameP.personnage_hp -= degats_encaisses
                  puts "Il vous reste #{user_nameP.personnage_hp} points de vie."
                  if ennemi.personnage_hp > 0
                  puts "Que faites-vous ?"
                end
              elsif ennemi.personnage_hp <= 0
                  puts ""
                  puts "Le #{ennemi.name} est mort !"
                  ennemi.personnage_alive = false
                end
      elsif user_choice_3 == "2"
        puts "Vous gagnez de la défense !"
        user_nameP.personnage_defense += 3
        puts ""
        puts "Le #{ennemi.name} vous attaque !"
        puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
        degats_encaisses = ennemi.personnage_attaque - user_nameP.personnage_defense
        puts "Vous perdez #{degats_encaisses} points de vie !"
        user_nameP.personnage_hp -= degats_encaisses
        puts " Que faites-vous ?"
      elsif user_choice_3 =="3"
        if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
          puts "Potions : #{$mon_inventaire.show_potion}"
          puts "Grenades : #{$mon_inventaire.show_grenade}"
          puts "Que voulez-vous utiliser ?"
                    if $mon_inventaire.show_potion > 0
                      puts "1. Une potion."
                      puts "2. Rien finalement."
                      combat1_potion_simple = $stdin.gets.chomp
                            if combat1_potion_simple == "1"
                              puts "Vous regagnez #{50 - user_nameP.personnage_hp} points de vie."
                              user_nameP.personnage_hp = 50
                              $mon_inventaire.removpotion
                              puts "Le #{ennemi.name} vous attaque !"
                              puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                              degats_encaisses = ennemi.personnage_attaque - user_nameP.personnage_defense
                              puts "Vous perdez #{degats_encaisses} points de vie !"
                              user_nameP.personnage_hp -= degats_encaisses
                              puts " Que faites-vous ?"
                            elsif  combat1_potion_simple == "2"
                              numero_tour -= 1
                            else
                              puts "Merci d'indiquer un nombre pertinent."
                              numero_tour -=1
                            end

                    elsif $mon_inventaire.show_grenade > 0
                      puts  "1. Une grenade !"
                      puts  "2. Rien finalement."
                      combat1_grenade_simple = $stdin.gets.chomp
                            if combat1_grenade_simple == "1"
                              "Le Garde subit 30 points de dégats."
                              ennemi.personnage_hp -= 30
                              $mon_inventaire.removgrenade
                            elsif combat1_grenade_simple == "2"
                              numero_tour -= 1
                            else
                              numero_tour -= 1
                            end
                    else
                      puts "1. Une potion."
                      puts "2. une grenade !"
                      puts "3. Rien finalement."
                      combat1_grenade_ou_potion = $stdin.gets.chomp
                            if combat1_grenade_ou_potion == "1"
                              puts "Vous regagnez #{50 - user_nameP.personnage_hp} points de vie."
                              user_nameP.personnage_hp = 50
                              $mon_inventaire.removpotion
                              puts "Le #{ennemi.name} vous attaque !"
                              puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                              degats_encaisses = ennemi.personnage_attaque - user_nameP.personnage_defense
                              puts "Vous perdez #{degats_encaisses} points de vie !"
                              user_nameP.personnage_hp -= degats_encaisses
                              puts " Que faites-vous ?"
                            elsif combat1_grenade_ou_potion == "2"
                              "Le #{ennemi.name} subit 30 points de dégats."
                              ennemi.personnage_hp -= 30
                              $mon_inventaire.removgrenade
                            elsif combat1_grenade_ou_potion == "3"
                              numero_tour -= 1
                            else
                              numero_tour -= 1
                            end


                    end
        else
          puts ""
          puts "Vous n'avez pas d'objet !"
          puts ""
          numero_tour -= 1
        end

      elsif user_choice_3 =="i" || user_choice_3 =="I" && $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
        puts ""
        puts '|' + '-'*20 + '|'
        puts "|INVENTAIRE          |"
        puts '|' + '-'*20 + '|'
        puts "|Potions : #{$mon_inventaire.show_potion}         |"
        puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
        puts '|' + '-'*20+ '|'
        numero_tour -= 1
      elsif user_choice_3 =="i" || user_choice_3 =="I"
        puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
        numero_tour -= 1
      else
        puts ""
        puts "Je n'ai pas compris. Que faites-vous ?"
        puts ""
        numero_tour -= 1
      end
    end

end
end
#Combat avec DEUX adversaires
def combat_2ennemi(user_nameP, barret, ennemi1, ennemi2)
  puts '      _________  ________      _____ __________    ________________ '
  puts '       \_   ___ \ \_____  \    /     \\______   \  /  _  \__    ___/ '
  puts '       /    \  \/  /   |   \  /  \ /  \|    |  _/ /  /_\  \|    |    '
  puts '       \     \____/    |    \/    Y    \    |   \/    |    \    |    '
  puts '        \______  /\_______  /\____|__  /______  /\____|__  /____|    '
  puts '               \/         \/         \/       \/         \/          '
  numero_tour = 0


  while ennemi1.personnage_alive && ennemi2.personnage_alive
    if ennemi1.personnage_hp <= 0
      puts ""
      puts "--------------------------------"
      puts "Le #{ennemi1.name} est mort !"
      puts "--------------------------------"
      puts ""
    end
    if ennemi2.personnage_hp <= 0
      puts ""
      puts "--------------------------------"
      puts "Le #{ennemi2.name} est mort !"
      puts "--------------------------------"
      puts ""
    end
    if ennemi1.personnage_hp <= 0 && ennemi2.personnage_hp <= 0
      puts ""
      puts "--------------------------------"
      puts "Les ennemis sont morts !"
      puts "--------------------------------"
      total_xp = ennemi1.xp + ennemi2.xp
      puts "Vous gagnez #{total_xp} points d'XP !"
      ennemi1.personnage_alive = false
      ennemi2.personnage_alive = false

      if ennemi1.loot == '1po'
        $mon_inventaire.addpotion
        puts "--------------------------------"
        puts "1x Potion ajoutée à votre inventaire."
        puts "--------------------------------"

      elsif ennemi1.loot == '1gre'
        $mon_inventaire.addgrenade
        puts "--------------------------------"
        puts "1x Grenade ajoutée à votre inventaire."
        puts "--------------------------------"

      elsif ennemi1.loot == '1po1gre'
        $mon_inventaire.addpotion
        $mon_inventaire.addgrenade
        puts "--------------------------------"
        puts "1x Potion ajoutée à votre inventaire."
        puts "1x Grenade ajoutée à votre inventaire."
        puts "--------------------------------"

      elsif ennemi2.loot == '1po'
        puts "--------------------------------"
        puts "1x Potion ajoutée à votre inventaire."
        puts "--------------------------------"
          $mon_inventaire.addpotion

      elsif ennemi2.loot == '1gre'
        puts "--------------------------------"
        puts "1x Grenade ajoutée à votre inventaire."
        puts "--------------------------------"
          $mon_inventaire.addgrenade
      end

      puts ""
    elsif ennemi1.personnage_hp > 0 || ennemi2.personnage_hp > 0

      numero_tour += 1
      puts "----------------------------------"
        puts "Tour n°#{numero_tour}"
        puts "Ennemis : #{ennemi1.name} ET #{ennemi2.name}"
        puts "TIRENT A DISTANCE"
        if ennemi1.personnage_hp > 0
        puts "POINTS DE VIE : #{ennemi1.name} #{ennemi1.personnage_hp} HP"
        end
        if ennemi1.personnage_hp <= 0
          puts "#{ennemi1.name} : mort."
        end
        if ennemi2.personnage_hp > 0
        puts "POINTS DE VIE : #{ennemi2.name} #{ennemi2.personnage_hp} HP"
        end
        if ennemi2.personnage_hp <= 0
          puts "#{ennemi2.name} : mort."
        end
        puts ""
        puts "Que faites-vous ?"
        puts "1. Attaquer"
        puts "2. Défendre"
        puts "3. Utiliser un objet"
        user_choice_4 = $stdin.gets.chomp
        if user_choice_4 == "1"
          puts "Qui attaquer ?"
          if ennemi1.personnage_hp > 0
          puts "1. #{ennemi1.name}"
        end
          if ennemi2.personnage_hp > 0
          puts "2. #{ennemi2.name}"
        end
          print "> "
          user_choice_4_fight = $stdin.gets.chomp
          if user_choice_4_fight == "1" && ennemi1.personnage_hp > 0
              puts ""
              puts "BIM !"
              puts "Vous attaquez le #{ennemi1.name}."
              puts "Le #{ennemi1.name} réduit les dégats de #{ennemi1.personnage_defense}."
              degats_totaux = user_nameP.personnage_attaque - ennemi1.personnage_defense
              puts "Le #{ennemi1.name} subit #{(user_nameP.personnage_attaque - ennemi1.personnage_defense)} points de dégats !"

              #On fait attaquer Barret

              puts "Barret attaque le #{ennemi1.name}."
              puts "Le #{ennemi1.name} réduit les dégats de #{ennemi1.personnage_defense}."
              degats_barret_1 = barret.personnage_attaque - ennemi1.personnage_defense
              puts "Le #{ennemi1.name} subit #{(barret.personnage_attaque - ennemi1.personnage_defense)} points de dégats !"

                      if ennemi1.personnage_hp > 0

                        ennemi1.personnage_hp -= degats_totaux
                        puts ""
                        puts "Le #{ennemi1.name} vous attaque !"
                        puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                        degats_encaisses = ennemi1.personnage_attaque - user_nameP.personnage_defense
                        puts "Vous perdez #{degats_encaisses} points de vie !"
                        user_nameP.personnage_hp -= degats_encaisses
                        puts "Il vous reste #{user_nameP.personnage_hp} points de vie."

                        puts "Le #{ennemi2.name} attaque Barret !"
                        degats_barret_encaiss = ennemi2.personnage_attaque - barret.personnage_defense
                        puts "Barret perd #{degats_barret_encaiss} points de vie !"
                        barret.personnage_hp -= degats_barret_encaiss
                        puts "Barret a #{barret.personnage_hp} points de vie."

                        if ennemi1.personnage_hp > 0 || ennemi2.personnage_hp > 0
                        puts "Que faites-vous ?"
                      end
                    elsif ennemi1.personnage_hp <= 0 || ennemi2.personnage_hp <= 0
                        puts ""
                        puts "Le #{ennemi1.name} est mort !"
                        ennemi1.personnage_alive = false
                      end
          elsif user_choice_4_fight == "2" && ennemi2.personnage_hp > 0
            puts ""
            puts "BIM !"
            puts "Vous attaquez le #{ennemi2.name}."
            puts "Le #{ennemi2.name} réduit les dégats de #{ennemi2.personnage_defense}."
            degats_totaux = user_nameP.personnage_attaque - ennemi2.personnage_defense
            puts "Le #{ennemi2.name} subit #{(user_nameP.personnage_attaque - ennemi2.personnage_defense)} points de dégats !"
                    if ennemi2.personnage_hp > 0

                      ennemi2.personnage_hp -= degats_totaux
                      puts ""
                      puts "Le #{ennemi2.name} vous attaque !"
                      puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                      degats_encaisses = ennemi2.personnage_attaque - user_nameP.personnage_defense
                      puts "Vous perdez #{degats_encaisses} points de vie !"
                      user_nameP.personnage_hp -= degats_encaisses
                      puts "Il vous reste #{user_nameP.personnage_hp} points de vie."

                      puts "Le #{ennemi2.name} attaque Barret !"
                      degats_barret_encaiss = ennemi2.personnage_attaque - barret.personnage_defense
                      puts "Barret perd #{degats_barret_encaiss} points de vie !"
                      barret.personnage_hp -= degats_barret_encaiss
                      puts "Barret a #{barret.personnage_hp} points de vie."

                      if ennemi1.personnage_hp > 0 || ennemi2.personnage_hp > 0
                      puts "Que faites-vous ?"
                    end
                  elsif ennemi1.personnage_hp <= 0 || ennemi2.personnage_hp <= 0
                      puts ""
                      puts "Le #{ennemi2.name} est mort !"
                      ennemi2.personnage_alive = false
                    end
                  end
        elsif user_choice_4 == "2"
          puts "Vous gagnez de la défense !"
          puts "Barret gagne de la défense !"
          user_nameP.personnage_defense += 3
          barret.personnage_defense += 3
          puts ""
          puts "Le #{ennemi1.name} vous attaque !"
          puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
          degats_encaisses = ennemi1.personnage_attaque - user_nameP.personnage_defense
          puts "Vous perdez #{degats_encaisses} points de vie !"
          user_nameP.personnage_hp -= degats_encaisses
          puts "Le #{ennemi1.name} attaque Barret !"
          degats_barret_encaiss = ennemi2.personnage_attaque - barret.personnage_defense
          puts "Barret perd #{degats_barret_encaiss} points de vie !"
          barret.personnage_hp -= degats_barret_encaiss
          puts "Barret a #{barret.personnage_hp} points de vie."

        elsif user_choice_4 =="3"
          if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
            puts "Potions : #{$mon_inventaire.show_potion}"
            puts "Grenades : #{$mon_inventaire.show_grenade}"
            puts "Que voulez-vous utiliser ?"
                      if $mon_inventaire.show_potion > 0
                        puts "1. Une potion."
                        puts "2. Rien finalement."
                        combat2_potion_simple = $stdin.gets.chomp

                              if combat2_potion_simple == "1"
                                puts "Sur qui la lancer ?"
                                puts "1. Sur vous-même."
                                puts "2. Sur Barret."
                                user_potion_fight = $stdin.gets.chomp

                                if user_potion_fight == "1"
                                puts "Vous regagnez #{50 - user_nameP.personnage_hp} points de vie."
                                user_nameP.personnage_hp = 50
                                $mon_inventaire.removpotion
                              elsif user_potion_fight =="2"
                                puts "Barret regagne #{60 - barret.personnage_hp} points de vie."
                                barret.personnage_hp = 60
                                $mon_inventaire.removpotion
                              else
                                "Merci d'indiquer un bon chiffre."
                              end
                                puts "Le #{ennemi1.name} vous attaque !"
                                puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                                degats_encaisses = ennemi1.personnage_attaque - user_nameP.personnage_defense
                                puts "Vous perdez #{degats_encaisses} points de vie !"
                                user_nameP.personnage_hp -= degats_encaisses
                                puts "Que faites-vous ?"
                              elsif  combat2_potion_simple == "2"
                                numero_tour -= 1
                              else
                                puts "Merci d'indiquer un nombre pertinent."
                                numero_tour -=1
                              end

                      elsif $mon_inventaire.show_grenade > 0
                        puts  "1. Une grenade !"
                        puts  "2. Rien finalement."
                        combat2_grenade_simple = $stdin.gets.chomp
                              if combat2_grenade_simple == "1"
                                "Le #{ennemi1.name} subit 30 points de dégats."
                                garde1.personnage_hp -= 30
                                $mon_inventaire.removgrenade
                              elsif combat2_grenade_simple == "2"
                                numero_tour -= 1
                              else
                                numero_tour -= 1
                              end
                      else
                        puts "1. Une potion."
                        puts "2. Une grenade !"
                        puts "3. Rien finalement."
                        combat2_grenade_ou_potion = $stdin.gets.chomp
                              if combat2_grenade_ou_potion == "1"
                                puts "Sur qui la lancer ?"
                                puts "1. Sur #{user_name}."
                                puts "2. Sur Barret."
                                user_potion_fight1 = $stdin.gets.chomp

                                if user_potion_fight1 == "1"
                                puts "Vous regagnez #{50 - user_nameP.personnage_hp} points de vie."
                                user_nameP.personnage_hp = 50
                                $mon_inventaire.removpotion
                              elsif user_potion_fight1 =="2"
                                puts "Barret regagne #{60 - barret.personnage_hp} points de vie."
                                barret.personnage_hp = 60
                                $mon_inventaire.removpotion
                              else
                                "Merci d'indiquer un bon chiffre."
                              end
                                puts "Le #{ennemi1.name} vous attaque !"
                                puts "Vous réduisez ses dégats de #{user_nameP.personnage_defense} !"
                                degats_encaisses = ennemi1.personnage_attaque - user_nameP.personnage_defense
                                puts "Vous perdez #{degats_encaisses} points de vie !"
                                user_nameP.personnage_hp -= degats_encaisses
                                puts " Que faites-vous ?"
                              elsif combat2_grenade_ou_potion == "2"
                                "Le #{ennemi1.name} subit 30 points de dégats."
                                garde1.personnage_hp -= 30
                                $mon_inventaire.removgrenade
                              elsif combat2_grenade_ou_potion == "3"
                                numero_tour -= 1
                              else
                                numero_tour -= 1
                              end


                      end
          else
            puts "Vous n'avez pas d'objet !"
            numero_tour -= 1
          end

        elsif user_choice_4 =="i" || user_choice_4 =="I" && $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
          puts ""
          puts '|' + '-'*20 + '|'
          puts "|INVENTAIRE          |"
          puts '|' + '-'*20 + '|'
          puts "|Potions : #{$mon_inventaire.show_potion}         |"
          puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
          puts '|' + '-'*20+ '|'
          numero_tour -= 1
        elsif user_choice_4 =="i" || user_choice_4 =="I"
          puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
          numero_tour -= 1
        else
          puts ""
          puts "Je n'ai pas compris. Que faites-vous ?"
          puts ""
          numero_tour -= 1
        end
      end
  end

  def afficher_inventaire
#à compléter

  end
end

#################################################################################

# Début du jeu - Ce que voit le joueur.
puts '___________.___ _______      _____  .____'
puts '\_   _____/|   |\      \    /  _  \ |    |'
puts ' |    __)  |   |/   |   \  /  /_\  \|    |'
puts ' |     \   |   /    |    \/    |    \    |___'
puts ' \___  /   |___\____|__  /\____|__  /_______ \ '
puts '    \/                \/         \/        \/'
puts '________________    _______________________    ______________.___.'
puts '\_   _____/  _  \   \      \__    ___/  _  \  /   _____/\__  |   |'
puts ' |    __)/  /_\  \  /   |   \|    | /  /_\  \ \_____  \  /   |   |'
puts ' |     \/    |    \/    |    \    |/    |    \/        \ \____   |'
puts ' \___  /\____|__  /\____|__  /____|\____|__  /_______  / / ______|'
puts '     \/         \/         \/              \/        \/  \/       '
puts '_________'
puts '\______  \ '
puts '    /    / '
puts '   /    /  '
puts '  /____/ '
puts ''
puts "----------------------------------"
puts "Bienvenue dans Final Fantasy 7."
puts "Appuyez sur une touche pour commencer."
passer = $stdin.gets.chomp
puts ""
puts '-' * 30
puts "INTRODUCTION"
puts '-' * 30
puts "Une ville noire. Polluée. Au loin, on voit d'immenses réacteurs qui brulent l'énergie du sol, et alimentent en éléctricité la gourmande Midgar. "
puts "Midgar, la ville de tous les vices. La capitale du crime, de la pauvreté, mais aussi la plus grande ville du monde connu."
puts ""
puts "Au milieu de ce sombre décor, un train avance dans l'obscurité. Le bruit des rouages est tonitruant. Une fumée épaisse se dégage de sa base : il est en train de freiner. 'Pourquoi ai-je accepté cette mission ?' vous dites-vous en restant caché entre les wagons."
puts ""
puts "Le train s'approche doucement d'un de ces gigantesques réacteurs. Le voilà désormais arrêté."
puts "Vous êtes cachés derrière des caisses. Des gardes approchent de vous."
puts "Que faites-vous ?"
puts "1. Rester caché."
puts "2. Sortir."

#Premier choix.
a = true
while a
  choix = true
  choix_2 = false
  print "> "
  choice_1 = $stdin.gets.chomp
  if choice_1 == "1" && choix
    puts ""
    puts "--------------------------------"
    puts "Les gardes passent à coté de vous et ne vous voient pas."
    puts "Vous entendez soudain un bruit cinglant."
    puts 'BAM !'
    choix = false
    choix_2 = true
    puts ""
    puts "- Qu'est-ce tu branles putain ?"
    puts "Vous regardez autour de vous. Trois gardes sont couchés, inconscients."
    puts "- J'ai encore tout fait moi-même ! Et tu te dis membre du SOLDAT ?"
    puts "Un grand guerrier vous fait face. C'est Barret, votre boss. On le reconnait grace à sa cicatrice sur le visage, et son bras robotisé qui sert de mitraillette automatique. On sait pas grand chose sur Barret. Juste que c'est le leader de la cause rebelle."
    puts "- C'est quoi ton nom déjà ?' Vous demande-t-il."
    puts "Indiquez votre nom."
    print "> "
    user_name = $stdin.gets.chomp
    puts ""
    puts "- Ok #{user_name}. Il faut qu'on avance. On a pas beaucoup de temps."
    puts "Barret part devant. Vous voyez les gardes inconscients par terre."
    mon_inventaire.addpotion
    puts "Vous fouillez les gardes et trouvez une potion."
    puts ""
    puts "--------------------------------"
    puts "1x Potion ajoutée à votre inventaire."
    puts "--------------------------------"
    puts ""
    puts "Appuyez sur I à tout moment pour accéder à votre inventaire."
    puts ""
    puts "Des gardes approchent ! Appuyez sur une touche pour continuer."
    just_print = $stdin.gets.chomp
    a = false
    b = true
    garde2 = Personnage.new(30,10,2,10,1,'Garde 1','1po')
    garde3 = Personnage.new(30,10,2,10,1,'Garde 2')

combat_2ennemi(user_nameP,barret,garde2,garde3)

elsif choice_1 =="2" && choix
  choix = false
  a = false
  b = false
  c = true
  pechonom = true
  puts ""
  puts "Vous sortez et êtes soudain face à face avec un garde. Ni une, ni deux : il prend son flingue et cherche à vous mettre en joue."
  puts ""
  puts "Un garde vous attaque !"
  garde1 = Personnage.new(30,12,2,10,1,'Garde','1po1gre')

combat_1ennemi(user_nameP, garde1)

elsif choice_1 =="I" || choice_1 =="i"
          if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
            puts '|' + '-'*20 + '|'
            puts "|INVENTAIRE          |"
            puts '|' + '-'*20 + '|'
            puts "|Potions : #{$mon_inventaire.show_potion}         |"
            puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
            puts '|' + '-'*20+ '|'
            print '>'
          else
            puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
            print '>'
          end
  else
    puts "Je n'ai pas compris. Que faites-vous ?"

end
end
puts "'- Ok. Bien joué', vous dit Barret. 'Tu vois ça ? Il faut maintenant entrer là dedans.'"
if pechonom
  puts "'- Au fait, c'est quoi ton nom' ?"
  print "> "
  user_name = $stdin.gets.chomp
  puts "'- Ok #{user_name}, c'est noté. Allez viens, on a du boulot.'"
end
sleep 3
puts ''
puts '_________ .__                  .__  __                    ____ '
puts '\_   ___ \|  |__ _____  ______ |__|/  |________   ____   /_   |'
puts '/    \  \/|  |'  '\ \__   \ \____ \|  \   __\_  __ \_/ __ \   |   |'
puts '\     \___|   Y  \/ __ \|  |_> >  ||  |  |  | \/\  ___/   |   |'
puts ' \______  /___|  (____  /   __/|__||__|  |__|    \___  >  |___|'
puts '        \/     \/     \/|__|                         \/        '
puts""
puts '-'*60
puts "                        LE REACTEUR"
puts '-'*60
puts ""
puts "Devant vous se dresse un immense batiment. Une lumière bleue claire brille, brille si fort depuis le sommet qu'elle en est aveuglante."
puts ""
puts "'- T'es devant un réacteur MAKO', précise Barret."
puts "'- La SHINRA a construit ces réacteurs il y a des années. Depuis, elle pompe l'énergie de la planète pour la vendre.' "
puts ""
puts "'- Et toi, pourquoi tu nous as rejoint ?'"
puts "1. Je m'en fous de ça. Je bosse pour la thune."
puts "2. Pour sauver la planète, pardi."
print '>'

d = true
while d
user_rep = $stdin.gets.chomp
if user_rep =="1"
  d = false
  puts ""
puts "'Je m'en doutais. Un connard de plus qui veut juste du fric...'"
puts ""
puts "Une jeune femme s'approche de vous."
puts ""
puts "'Laisse-le Barret. Il bosse avec nous, c'est tout ce qui compte'."
puts "'- Je suis Jesse. Ravie de faire ta connaissance.'"
puts "'- On a beaucoup de boulot, et peu de temps avant que l'alarme ne sonne. Allons-y.'"
elsif user_rep =="2"
  d = false
puts ""
puts "Barret vous dévisage lentement."
puts "'Mouais. J'y crois pas trop.'"
puts ""
puts "Un jeune homme, un peu en surpoids, arrive avec un grand sourire."
puts ""
puts "'- Barret, tu casses les couilles. Il fait ce qu'il veut.'"
puts "Il poursuit. '- T'es avec nous maintenant. C'est ce qui compte. Ecoute pas Barret, et ça ira. Allez, on trace."
elsif user_rep =="I" || user_rep =="i"
          if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
            puts '|' + '-'*20 + '|'
            puts "|INVENTAIRE          |"
            puts '|' + '-'*20 + '|'
            puts "|Potions : #{$mon_inventaire.show_potion}         |"
            puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
            puts '|' + '-'*20+ '|'
            print '>'
          else
            puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
            print '>'
          end
else
puts "Merci d'indiquer votre réponse."
print '>'
end
end
puts ""
puts "Appuyez sur une touche pour continuer."
block_text = $stdin.gets.chomp
puts ""
puts "'- Nous on se bat pour ça', continue Barret. Pour sauver la planète.'"
puts ""
puts "Vous avancez rapidement dans des longs couloirs ternes. Les pièces metalliques entreposées ça et là font écho aux grillages rouillés apposés contre les murs."
puts "Après avoir parcouru plusieurs couloirs et pièces, vous vous retrouvez face à une grande porte blindée."
puts ""
puts "Appuyez sur une touche pour continuer."
block_text = $stdin.gets.chomp
puts ""
puts '____________________'
puts '_]|  |  |  |  |  |[_'
puts '_]|==|==|==|==|==|[_'
puts '_]|_ _  |  |  |  |[_'
puts '_]|_|_[ |  |  |  |[_'
puts '_]|_|_[ |  |  |  |[_'
puts '_]|  |  |  |  |  |[_'
puts '_]|  |  |  |  |  |[_'
puts '_]|==|==|==|==|==|[_'
puts '_]|  |  |.-|--|  |[_'
puts '_]|  |  | `.  |  |[_'
puts '_]|  |  |  |`.|  |[_'
puts '_]|  |  |  |  |`.|[_'
puts '_]|  |  |  |  |  |[_'
puts '_]|==|==|==|==|==|[_'
puts '_]|__|__|__|__|__|[_'
puts ""
puts "'- Et merde', dit Barret. 'Une porte blindée, et bloquée.'"
puts "Barret tire sur la porte."
puts "'- Elle ne bouge pas.'"
puts ""
puts "Que faites-vous ?"
puts "1. Regarder la porte de plus près."
puts "2. Demander à Barret de tirer dessus."
puts "3. Demander aux mercenaires qui vous accompagnent."
print '>'
while true
user_rep2 = $stdin.gets.chomp
if user_rep2 == "1"
puts "La porte est épaisse, au moins 40 centimètres de métal renforcé - une espèce d'alliage solide. On dirait du bronze. Aucune chance qu'on la casse."
puts "Un digicode est à coté."
puts ""
puts "Que faites-vous ?"
puts ">"

elsif user_rep2 == "2"
  puts ""
  puts "'- Mouais, si tu veux.'"
  puts "Barret tire sur la porte. Une balle ricoche et passe à coté de votre visage."
  puts ""
  puts "Vous perdez 2 points de vie."
  user_nameP.personnage_hp -= 2
  puts "Que faites-vous ?"
  print '>'

elsif user_rep2 == "3"
  puts ""
  puts "'- C'est mon rayon', dit Jesse. La belle jeune femme s'approche de la porte et se branche au digicode."
  puts "Un bruit éléctronique de validation résonne."
  puts "'- Et voilà ! C'est ouvert !"
  puts "La porte s'ouvre. L'équipe avance au batiment suivant."
break

elsif user_rep2 == "i" || user_rep2 =="I"
  if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
    puts '|' + '-'*20 + '|'
    puts "|INVENTAIRE          |"
    puts '|' + '-'*20 + '|'
    puts "|Potions : #{$mon_inventaire.show_potion}         |"
    puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
    puts '|' + '-'*20+ '|'
    print '>'
    print '>'
  else
    puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
    print '>'
  end

else
  puts "Merci d'indiquer votre réponse."
  print '>'
end
end
puts ""
puts "'On est plusieurs dans le groupe', vous dit Jesse pendant la marche."
puts "'Barret, Biggs, et moi. C'est notre groupe d'intervention."
puts "Tu as des questions sur notre fonctionnement ?"
puts "1. Oui. Pourquoi on attaque ce réacteur ?"
puts "2. Oui. Barret est toujours aussi con ?"
puts "3. Non, merci ça va."

while true
user_rep3 = $stdin.gets.chomp

if user_rep3 =="1"
  puts ""
puts "'- La SHINRA aspire toute l'énergie du sol. C'est pour ça que le sol est noir foncé partout.'"
puts "'L'énergie est ensuite transformée en MAKO. Puis vendue au plus offrant.'"
puts "'- Ca tue la planète à petits feux...On fait ça avant qu'il soit trop tard."

break
elsif user_rep3 =="2"
  puts ""
puts "Jesse éclate de rire."
puts "'- Des fois, il est pire. Mais faut pas l'dire.'"
puts ""
puts "Barret aproche dans votre direction."
puts "'- Si t'as des questions demande moi', dit-il. 'Allez, on doit faire vite ! L'énergie MAKO n'attends pas.'"
break
elsif user_rep3 == "3"
  puts ""
puts "Jesse vous dévisage quelques secondes."
puts "'Ok, comme tu veux.'"
break
elsif user_rep3 =="i" || user_rep3 =="I"
  if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
    puts '|' + '-'*20 + '|'
    puts "|INVENTAIRE          |"
    puts '|' + '-'*20 + '|'
    puts "|Potions : #{$mon_inventaire.show_potion}         |"
    puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
    puts '|' + '-'*20+ '|'
    print '>'
  else
    puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
    print '>'
  end
else
puts "Je n'ai pas compris. Que veux-tu dire ?"
print '>'
end
end
puts ""
puts "Vous arrivez dans une grande pièce."
puts ""
puts "'Wow.'"
puts "'C'est quoi ça ?'"
puts ""
puts "Appuyez sur une touche pour continuer."
block_text = $stdin.gets.chomp
puts 'ooooooooooooooooooooooooooooooooooooo'
puts '8                                .d88'
puts '8  oooooooooooooooooooooooooooood8888'
puts '8  8888888888888888888888888P"   8888    oooooooooooooooo'
puts '8  8888888888888888888888P"      8888    8              8'
puts '8  8888888888888888888P"         8888    8             d8'
puts '8  8888888888888888P"            8888    8            d88'
puts '8  8888888888888P"               8888    8           d888'
puts '8  8888888888P"                  8888    8          d8888'
puts '8  8888888P"                     8888    8         d88888'
puts '8  8888P"                        8888    8        d888888'
puts '8  8888oooooooooooooooooooooocgmm8888    8       d8888888'
puts '8 .od88888888888888888888888888888888    8      d88888888'
puts '8888888888888888888888888888888888888    8     d888888888'
puts '                                         8    d8888888888'
puts '   ooooooooooooooooooooooooooooooo       8   d88888888888'
puts '  d                       ...oood8b      8  d888888888888'
puts ' d              ...oood888888888888b     8 d8888888888888'
puts 'd     ...oood88888888888888888888888b    8d88888888888888'
puts 'dood8888888888888888888888888888888888b'
puts ""
puts "'- Surement une salle de contrôle.'"
puts "'J'y capte que dalle', dit Jesse. #{user_name}, tu veux pas jeter un oeil ?'"
puts "Appuyez sur une touche pour continuer."
block_text = $stdin.gets.chomp
puts ""
puts "Vous vous approchez de l'ordinateur. Il demande 'MOT DE PASSE ?'"
puts "Que faites-vous ?"
puts "1. Regarder autour."
puts "2. Demander à Barret de tirer sur l'ordinateur."
puts "3. Tenter d'entrer un mot de passe."
puts "4. On s'en fout, on avance sans toucher l'ordi."
print '>'
pc_cracked = false
tentatives = 3
while true
  user_rep4 = $stdin.gets.chomp
  if user_rep4 =="1"
puts ""
puts "Vous regardez autour de vous. Le bureau est vide. Rien aux murs. Que du béton, gris et froid."
puts "Une photo de famille est apposée sur le bureau. Au dos, on peut lire 'Energie'."
puts "Serait-ce un indice ?"
puts "Que faites-vous ?"
print '>'
  elsif user_rep4 =="2"
puts ""
puts "BAM BAM BAM !"
puts "Un bruit tonitruant emplit la pièce. Le PC git là, par terre, éclaté et fumant."
puts "'T'es sur que c'était une bonne idée #{user_name} ?'"
puts ""
puts "Il n'y a plus rien à faire dans cette pièce. On avance, tant pis pour le PC."
break
  elsif user_rep4 =="3"
    while true
    puts "(Ecrivez EXIT pour sortir de l'ordinateur)"
    puts "Quel mot de passe écrivez-vous ?"
    print '>'
    user_pswrd = $stdin.gets.chomp
      if user_pswrd == "MAKO" || user_pswrd == "mako" || user_pswrd == "Mako"
        pc_cracked = true
        puts ""
        "MOT DE PASSE ACCEPTE"
        puts ""
        puts "Yes ! Ca a marché !"
        break
      elsif user_pswrd =="EXIT"
        break
        puts "Que faites-vous ?"
        print '>'
      else
        tentatives -= 1
        puts ""
        puts "MAUVAIS MOT DE PASSE"
          if tentatives == 2
            puts "'Il y a écrit 'Energie' au dos de la photo sur le bureau. L'énergie ? C'est quoi l'énergie ?' demande Jesse.'"
            puts ""
          end
          if tentatives == 1
            puts "'Ca aurait quelque chose à voir avec le MAKO ?'"
          end
          if tentatives > 0
            puts "IL VOUS RESTE #{tentatives} TENTATIVES AVANT ALARME"
          else
            alarm = true
            puts "ALARME DECLENCHEE"
            puts ""
            puts "MERDE ! Il faut qu'on se barre. Direction le réacteur et vite !!!"
            garde4 = Personnage.new(30,10,2,10,1,'Garde 1','1po')
            garde5 = Personnage.new(30,10,2,10,1,'Garde 2','1gre')
            combat_2ennemi(user_nameP, barret, garde4, garde5)
            break
          end
      end
    end
    break
  elsif user_rep4 =="4"
puts ""
puts "On avance, tant pis pour le PC."
puts "Vous avancez, en laissant le PC bloqué."
break
  elsif user_rep4 =="i" || user_rep4=="I"
    if $mon_inventaire.show_potion > 0 || $mon_inventaire.show_grenade > 0
      puts '|' + '-'*20 + '|'
      puts "|INVENTAIRE          |"
      puts '|' + '-'*20 + '|'
      puts "|Potions : #{$mon_inventaire.show_potion}         |"
      puts "|Grenades : #{$mon_inventaire.show_grenade}        |"
      puts '|' + '-'*20+ '|'
      print '>'
    else
      puts "Vous n'avez pas d'objets dans votre inventaire pour l'instant."
      print '>'
    end
  else
puts "Merci d'indiquer une bonne réponse."
  end
end
defense_auto = true
if pc_cracked
puts '                   ___'
puts '                  /  /\ '
puts '                 /  /  \ '
puts '                /  /    \ '
puts '               /  /  /\  \ '
puts '              /  /  /  \  \ '
puts '             /  /  /    \  \ '
puts '            /  /  /  /\  \  \ '
puts '           /  /  /  /\ \  \  \ '
puts '          /  /  /  /  \ \  \  \ '
puts '         /  /  /__/____\ \  \  \ '
puts '        /  /____________\ \  \  \ '
puts '       /___________________\  \  /'
puts '       \_______________________\/'
puts '_'*40
puts "              FICHIERS SHINRA"
puts "     POSTE DE CONTROLE REACTEUR 7"
puts "1. ETAT DU REACTEUR"
puts "2. DESACTIVER DEFENSE AUTOMATIQUE"
puts "3. DONNES CONFIDENTIELLES"
puts "4. ETEINDRE"
while true
user_pc = $stdin.gets.chomp
if user_pc =="1"
   puts ""
   puts "REACTEUR ACTIVE"
   puts "SCORPION SECURITE EN PLACE"
   puts ""
   puts "SAISIR COMMANDE"
   print '>'
elsif user_pc == "2"
  defense_auto = false
  puts ""
  puts "DEFENSE AUTOMATIQUE DESACTIVEE"
  puts ""
  puts "SAISIR COMMANDE"
  print '>'

elsif user_pc =="3"
puts ""
puts "SCORPION SECURITE ENDOMMAGE LORS DU DERNIER EXERCICE"
puts "PROBLEME AU NIVEAU DU CAPTEUR FRONTAL - NON REPARE"
puts ""
puts "SAISIR COMMANDE"
print '>'

elsif user_pc =="4"
puts ""
puts "FIN DE SESSION"
puts ""
break
else
puts "MERCI D'INDIQUER BONNE REPONSE"

end
end
end

puts ""
puts "'- OK, on avance. Dépechons-nous !'"

if !pc_cracked
puts ""
puts "L'équipe avance le long des couloirs interminables."
puts "'- A votre avis, on a raté des choses importantes sur l'ordi ? demande Jesse."
puts "'- Aucun moyen de le savoir', répond Barret. 'Restons sur nos gardes.'"
puts ""
end

if alarm
puts "Les lumières dans le réacteur sont devenues rouges. Elles clignotent."
puts "'- Cette putain d'alarme va nous mettre dedans' dit Barret."
puts "Des gardes patrouillent maintenant dans le réacteur."
end

puts "'- Voilà le réacteur', dit Barret."
puts "#{user_name}, pose la bombe."
puts ""
puts "Appuyez sur une touche pour poser la bombe."
bomb = $stdin.gets.chomp
puts ""
puts "ALARME, ALARME. INTRUSION"
if defense_auto
puts "ACTIVATION DE LA DEFENSE AUTOMATIQUE"
puts ""
puts "Un robot apparait devant vous."
puts ""
puts '                         /[-])//  ___'
puts '                     __ --\ `_/~--|  / \ '
puts '                   /_-/~~--~~ /~~~\\_\ /\ '
puts '                   |  |___|===|_-- | \ \ \ '
puts ' _/~~~~~~~~|~~\,   ---|---\___/----|  \/\-\ '
puts ' ~\________|__/   / // \__ |  ||  / | |   | |'
puts '          ,~-|~~~~~\--, | \|--|/~|||  |   | |'
puts "          [3-|____---~~ _--'==;/ _,   |   |_|"
puts '                      /   /\__|_/  \  \__/--/'
puts '                     /---/_\  -___/ |  /,--|'
puts '                     /  /\/~--|   | |  \///'
puts '                    /  / |-__ \    |/'
puts '                   |--/ /      |-- | \ '
puts "                  \^~~\\/\      \   \/- _"
puts '                   \    |  \     |~~\~~| \ '
puts '                    \    \  \     \   \  | \ '
puts '                      \    \ |     \   \    \ '
puts '                       |~~|\/\|     \   \   |'
puts '                      |   |/         \_--_- |\ '
puts '                      |  /            /   |/\/'
puts '                       ~~             /  /'
puts "                                     |__/' "
robot_auto = Personnage.new(50,12,2,50,1,'Robot Défnseur','1gre')
combat_1ennemi(user_nameP, robot_auto)
end

if !defense_auto
puts "DEFENSE AUTOMATIQUE DESACTIVEE."
end

puts "APPEL DU SCORPION"
puts ""
puts "'- Le scorpion ? C'est quoi ça ?' dit Barret."
puts "'- T'inquiète, je connais."

scorption = Personnage.new(60,13,2,100,1,'SCORPION MECANIQUE','1gre')
combat_1ennemi(user_nameP, scorption)

puts ""
puts "Vous avez fini le jeu. Félicitations !!"
puts ""
