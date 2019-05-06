-- =========================================
-- =              ASSETS LOADER            =
-- =========================================


-- =======================
-- =      TEXTURES       =
-- =======================

assets["background"] = lsfml.texture.createFromFile("./assets/menu/main_menu_background.png", {0, 0, 1920, 1080})
assets["button_idle"] = lsfml.texture.createFromFile("./assets/menu/button_idle.png", {0, 0, 421, 171})
assets["button_pressed"] = lsfml.texture.createFromFile("./assets/menu/button_pressed.png", {0, 0, 421, 171})
assets["button_hover"] = lsfml.texture.createFromFile("./assets/menu/button_hover.png", {0, 0, 421, 171})
assets["player"] = lsfml.texture.createFromFile("./assets/player/allsprite.png", {0, 0, 3300, 6492})
assets["hud_health"] = lsfml.texture.createFromFile("./assets/hud/health.png", {0, 0, 980, 328})
assets["hud_stamina"] = lsfml.texture.createFromFile("./assets/hud/stamina.png", {0, 0, 980, 328})
assets["hud_empty_health_bar"] = lsfml.texture.createFromFile("./assets/hud/empty_health_bar.png", {0, 0, 980, 328})
assets["hud_empty_stamina_bar"] = lsfml.texture.createFromFile("./assets/hud/empty_stamina_bar.png", {0, 0, 980, 328})
assets["hud_empty_mana_bar"] = lsfml.texture.createFromFile("./assets/hud/empty_mana_bar.png", {0, 0, 980, 328})
assets["hud_touche"] = lsfml.texture.createFromFile("./assets/hud/touche.png", {0, 0, 52, 54})
assets["sort_bar"] = lsfml.texture.createFromFile("./assets/hud/sort_bar.png", {0, 0, 1006, 233})
assets["hud_mana"] = lsfml.texture.createFromFile("./assets/hud/mana.png", {0, 0, 980, 328})
assets["inventory_hud"] = lsfml.texture.createFromFile("./assets/menu/inventory.png", {0, 0, 1337, 940})
assets["spell_hub"] = lsfml.texture.createFromFile("./assets/menu/spell_menu.png", {0, 0, 1337, 940})
assets["other_item"] = lsfml.texture.createFromFile("./assets/hud/other_item.png", {0, 0, 442, 208})
assets["case_dial"] = lsfml.texture.createFromFile("./assets/hud/case_dial.png", {0, 0, 384, 164})
assets["info"] = lsfml.texture.createFromFile("./assets/hud/info_window.png", {0, 0, 940, 1400})

assets["empty_boss_health"] = lsfml.texture.createFromFile("./assets/hud/bosshealth_empty.png", {0, 0, 426, 33})
assets["boss_health1"] = lsfml.texture.createFromFile("./assets/hud/bosshealth1.png", {0, 0, 426, 33})
assets["boss_health2"] = lsfml.texture.createFromFile("./assets/hud/bosshealth2.png", {0, 0, 426, 33})
assets["boss_health3"] = lsfml.texture.createFromFile("./assets/hud/bosshealth3.png", {0, 0, 426, 33})
assets["boss_health4"] = lsfml.texture.createFromFile("./assets/hud/bosshealth4.png", {0, 0, 426, 33})
assets["boss_health5"] = lsfml.texture.createFromFile("./assets/hud/bosshealth5.png", {0, 0, 426, 33})
assets["boss_health6"] = lsfml.texture.createFromFile("./assets/hud/bosshealth6.png", {0, 0, 426, 33})
assets["boss_health7"] = lsfml.texture.createFromFile("./assets/hud/bosshealth7.png", {0, 0, 426, 33})
assets["stats"] = lsfml.texture.createFromFile("./assets/hud/stats.png", {0, 0, 950, 1400})

assets["mob_health_empty"] = lsfml.texture.createFromFile("./assets/hud/mob_health_empty.png", {0, 0, 1040, 30})
assets["mob_health"] = lsfml.texture.createFromFile("./assets/hud/mob_health.png", {0, 0, 1040, 30})

assets["xp_bar"] = lsfml.texture.createFromFile("./assets/hud/xp_bar.png", {0, 0, 1080, 80})
assets["xp_bar_empty"] = lsfml.texture.createFromFile("./assets/hud/xp_bar_empty.png", {0, 0, 1080, 80})
assets["circle"] = lsfml.texture.createFromFile("./assets/hud/circle.png", {0, 0, 71, 71})

assets["scythe_right"] = lsfml.texture.createFromFile("./assets/hud/boomrang_dot.png", {0, 0, 71, 71})
assets["scythe_left"] = lsfml.texture.createFromFile("./assets/hud/slash_dot.png", {0, 0, 71, 71})

-- =======================
-- =    ENTITY MOB       =
-- =======================

assets["robot1"] = lsfml.texture.createFromFile("./assets/ennemy/robo/robot1.png", {0, 0, 4095, 2972})
assets["robot2"] = lsfml.texture.createFromFile("./assets/ennemy/robo/robot2.png", {0, 0, 7216, 4200})
assets["turret"] = lsfml.texture.createFromFile("./assets/ennemy/tourelle.png", {0, 0, 156, 312})
assets["soucoupe"] = lsfml.texture.createFromFile("./assets/ennemy/boss/soucoupe/soucoupe250x86.png", {0, 0, 1993, 258})
assets["scythe"] = lsfml.texture.createFromFile("./assets/ennemy/boss/scythe/scythe.png", {0, 0, 673, 610})
assets["mage"] = lsfml.texture.createFromFile("./assets/ennemy/boss/mage/mage.png", {0, 0, 480, 846})
assets["robot3"] = lsfml.texture.createFromFile("./assets/ennemy/robo/robot3.png", {0, 0, 292, 256})

-- =======================
-- =    ENTITY PNJ       =
-- =======================

assets["pnj_homme"] = lsfml.texture.createFromFile("./assets/pnj/pnj_homme.png", {0, 0, 1100, 560})
assets["pnj_robo"] = lsfml.texture.createFromFile("./assets/pnj/robo_casser_240x540.png", {0, 0, 960, 540})

-- =======================
-- =    ENTITY TEXTURE   =
-- =======================

assets["rayon"] = lsfml.texture.createFromFile("./assets/entity/rayon.png", {0, 0, 199, 44})
assets["slash"] = lsfml.texture.createFromFile("./assets/entity/slash.png", {0, 0, 67, 147})
assets["vortex"] = lsfml.texture.createFromFile("./assets/entity/vortex.png", {0, 0, 386, 393})
assets["laser_beam"] = lsfml.texture.createFromFile("./assets/entity/laser_beam.png", {0, 0, 580, 32})
assets["vortex2"] = lsfml.texture.createFromFile("./assets/entity/vortex2.png", {0, 0, 386, 393})
assets["vortex3"] = lsfml.texture.createFromFile("./assets/entity/vortex3.png", {0, 0, 386, 393})
assets["laser"] = lsfml.texture.createFromFile("./assets/ennemy/robo/attack.png", {0, 0, 365, 33})
assets["laser_projectile"] = lsfml.texture.createFromFile("./assets/entity/laser.png", {0, 0, 40, 10})

-- =======================
-- =    SPELL TEXTURE    =
-- =======================

assets["douleurSpell"] = lsfml.texture.createFromFile("./assets/spell/chaine_de_douleur.png", {0, 0, 142, 142})
assets["elecSpell"] = lsfml.texture.createFromFile("./assets/spell/elec.png", {0, 0, 142, 142})
assets["healSpell"] = lsfml.texture.createFromFile("./assets/spell/heal.png", {0, 0, 142, 142})
assets["picSpell"] = lsfml.texture.createFromFile("./assets/spell/pic.png", {0, 0, 142, 142})
assets["rayonSpell"] = lsfml.texture.createFromFile("./assets/spell/rayon.png", {0, 0, 142, 142})
assets["bouleelecSpell"] = lsfml.texture.createFromFile("./assets/spell/bouleelec.png", {0, 0, 142, 142})
assets["dashSpell"] = lsfml.texture.createFromFile("./assets/spell/dash.png", {0, 0, 142, 142})
assets["repulsionSpell"] = lsfml.texture.createFromFile("./assets/spell/repulsion.png", {0, 0, 142, 142})
assets["shieldSpell"] = lsfml.texture.createFromFile("./assets/spell/shield.png", {0, 0, 142, 142})
assets["tempSpell"] = lsfml.texture.createFromFile("./assets/spell/temp.png", {0, 0, 142, 142})

-- =======================
-- =   SPELL ANIMATION   =
-- =======================

assets["rayonAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/rayon19x114.png", {0, 0, 342, 342})
assets["rayonIdleAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/rayon19x114.png", {0, 0, 76, 342})
assets["rayonEndAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/rayon19x114.png", {0, 0, 209, 342})

assets["shieldAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/shield686x655.png", {0, 0, 5488, 655})
assets["healAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/heal192x192.png", {0, 0, 2304, 192})
assets["picAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/pic457x224.png", {0, 0, 3656, 224})
assets["elecAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/elec83x249.png", {0, 0, 415, 248})
assets["bouleelecAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/bouleelec71x71.png", {0, 0, 281, 71})
assets["tempAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/sablier573x573.png", {0, 0, 5157, 572})
assets["repulsionAnimation"] = lsfml.texture.createFromFile("./assets/spell/animation/repulsion900x900.png", {0, 0, 3600, 900})

-- =======================
-- =        ITEMS        =
-- =======================

assets["companion_cube"] = lsfml.texture.createFromFile("./assets/items/companion_cube.png", {0, 0, 64, 64})
assets["core"] = lsfml.texture.createFromFile("./assets/items/core.png", {0, 0, 64, 64})
assets["key"] = lsfml.texture.createFromFile("./assets/items/key.png", {0, 0, 64, 64})
assets["seringue"] = lsfml.texture.createFromFile("./assets/items/seringue.png", {0, 0, 64, 64})
assets["seringue_mana"] = lsfml.texture.createFromFile("./assets/items/seringue_mana.png", {0, 0, 64, 64})
assets["parchemin__1"] = lsfml.texture.createFromFile("./assets/items/parchemin_1.png", {0, 0, 64, 64})
assets["parchemin__2"] = lsfml.texture.createFromFile("./assets/items/parchemin_2.png", {0, 0, 64, 64})
assets["parchemin__3"] = lsfml.texture.createFromFile("./assets/items/parchemin_3.png", {0, 0, 64, 64})
assets["parchemin__4"] = lsfml.texture.createFromFile("./assets/items/parchemin_4.png", {0, 0, 64, 64})
assets["parchemin__5"] = lsfml.texture.createFromFile("./assets/items/parchemin_5.png", {0, 0, 64, 64})
assets["parchemin__6"] = lsfml.texture.createFromFile("./assets/items/parchemin_6.png", {0, 0, 64, 64})
assets["parchemin"] = lsfml.texture.createFromFile("./assets/items/parchemin.png", {0, 0, 64, 64})
assets["metal_scrap"] = lsfml.texture.createFromFile("./assets/items/metal_scrap.png", {0, 0, 64, 64})
assets["tablette"] = lsfml.texture.createFromFile("./assets/items/tablette.png", {0, 0, 64, 64})
assets["scythe_item"] = lsfml.texture.createFromFile("./assets/items/scythe.png", {0, 0, 64, 64})

assets["botte1"] = lsfml.texture.createFromFile("./assets/items/armure/botte1.png", {0, 0, 64, 64})
assets["casque1"] = lsfml.texture.createFromFile("./assets/items/armure/casque1.png", {0, 0, 64, 64})
assets["jambiere1"] = lsfml.texture.createFromFile("./assets/items/armure/jambiere1.png", {0, 0, 64, 64})
assets["plastron1"] = lsfml.texture.createFromFile("./assets/items/armure/plastron1.png", {0, 0, 64, 64})
assets["botte2"] = lsfml.texture.createFromFile("./assets/items/armure/botte2.png", {0, 0, 64, 64})
assets["casque2"] = lsfml.texture.createFromFile("./assets/items/armure/casque2.png", {0, 0, 64, 64})
assets["jambiere2"] = lsfml.texture.createFromFile("./assets/items/armure/jambiere2.png", {0, 0, 64, 64})
assets["plastron2"] = lsfml.texture.createFromFile("./assets/items/armure/plastron2.png", {0, 0, 64, 64})
assets["botte3"] = lsfml.texture.createFromFile("./assets/items/armure/botte3.png", {0, 0, 64, 64})
assets["casque3"] = lsfml.texture.createFromFile("./assets/items/armure/casque3.png", {0, 0, 64, 64})
assets["jambiere3"] = lsfml.texture.createFromFile("./assets/items/armure/jambiere3.png", {0, 0, 64, 64})
assets["plastron3"] = lsfml.texture.createFromFile("./assets/items/armure/plastron3.png", {0, 0, 64, 64})
assets["botte4"] = lsfml.texture.createFromFile("./assets/items/armure/botte4.png", {0, 0, 64, 64})
assets["casque4"] = lsfml.texture.createFromFile("./assets/items/armure/casque4.png", {0, 0, 64, 64})
assets["jambiere4"] = lsfml.texture.createFromFile("./assets/items/armure/jambiere4.png", {0, 0, 64, 64})
assets["plastron4"] = lsfml.texture.createFromFile("./assets/items/armure/plastron4.png", {0, 0, 64, 64})
assets["botte5"] = lsfml.texture.createFromFile("./assets/items/armure/botte5.png", {0, 0, 64, 64})
assets["casque5"] = lsfml.texture.createFromFile("./assets/items/armure/casque5.png", {0, 0, 64, 64})
assets["jambiere5"] = lsfml.texture.createFromFile("./assets/items/armure/jambiere5.png", {0, 0, 64, 64})
assets["plastron5"] = lsfml.texture.createFromFile("./assets/items/armure/plastron5.png", {0, 0, 64, 64})

-- ==========================
-- =     MAP BACKGROUND     =
-- ==========================

assets["labo_pop"] = lsfml.texture.createFromFile("./assets/map/labo/pop.png", {0, 0, 1920, 1080})
assets["labo_angle_gauche"] = lsfml.texture.createFromFile("./assets/map/labo/angle_gauche.png", {0, 0, 1920, 1080})
assets["labo_intersection_bas"] = lsfml.texture.createFromFile("./assets/map/labo/intersection_bas.png", {0, 0, 1920, 1080})
assets["labo_angle_haut_gauche"] = lsfml.texture.createFromFile("./assets/map/labo/angle_haut_gauche.png", {0, 0, 1920, 1080})
assets["labo_angle_droit"] = lsfml.texture.createFromFile("./assets/map/labo/angle_droit.png", {0, 0, 1920, 1080})
assets["labo_vertical"] = lsfml.texture.createFromFile("./assets/map/labo/vertical.png", {0, 0, 1920, 1080})
assets["labo_angle_haut_droit"] = lsfml.texture.createFromFile("./assets/map/labo/angle_haut_droit.png", {0, 0, 1920, 1080})
assets["labo_escalier"] = lsfml.texture.createFromFile("./assets/map/labo/escalier.png", {0, 0, 1920, 1080})
assets["labo_horizontal"] = lsfml.texture.createFromFile("./assets/map/labo/horizontal.png", {0, 0, 1920, 1080})
assets["labo_intersection_haut"] = lsfml.texture.createFromFile("./assets/map/labo/intersection_haut.png", {0, 0, 1920, 1080})

assets["start_cave"] = lsfml.texture.createFromFile("./assets/map/cave/arriver.png", {0, 0, 1920, 1080})
assets["left_start"] = lsfml.texture.createFromFile("./assets/map/cave/grotte_gauche.png", {0, 0, 1920, 1080})
assets["right_start"] = lsfml.texture.createFromFile("./assets/map/cave/avant_boss.png", {0, 0, 1920, 1080})
assets["boss"] = lsfml.texture.createFromFile("./assets/map/cave/boss.png", {0, 0, 1920, 1080})

-- =======================
-- =     MAP TEXTURE     =
-- =======================

assets["geant_tapis_gauche"] = lsfml.texture.createFromFile("./assets/map/to_give/geant_tapis_gauche.png", {0, 0, 483, 369})
assets["grand_tapis_droite"] = lsfml.texture.createFromFile("./assets/map/to_give/grand_tapis_droite.png", {0, 0, 411, 272})
assets["moyen_tapis_haut_droite"] = lsfml.texture.createFromFile("./assets/map/to_give/moyen_tapis_haut_droite.png", {0, 0, 324, 248})
assets["petit_tapis_bas_gauche"] = lsfml.texture.createFromFile("./assets/map/to_give/petit_tapis_bas_gauche.png", {0, 0, 292, 248})
assets["hologram"] = lsfml.texture.createFromFile("./assets/map/to_give/hologram.png", {0, 0, 155, 155})
assets["hologram_break"] = lsfml.texture.createFromFile("./assets/map/to_give/hologram_break.png", {0, 0, 155, 39})
assets["mini_holo"] = lsfml.texture.createFromFile("./assets/map/to_give/mini_holo.png", {0, 0, 56, 56})
assets["mini_tp"] = lsfml.texture.createFromFile("./assets/map/to_give/mini_tp.png", {0, 0, 31, 60})
assets["mini_tube"] = lsfml.texture.createFromFile("./assets/map/to_give/mini_tube.png", {0, 0, 56, 87})
assets["parchemin_1"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_1.png", {0, 0, 215, 65})
assets["parchemin_2"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_2.png", {0, 0, 187, 62})
assets["parchemin_3"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_3.png", {0, 0, 216, 57})
assets["parchemin_4"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_4.png", {0, 0, 216, 90})
assets["parchemin_5"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_5.png", {0, 0, 182, 70})
assets["parchemin_6"] = lsfml.texture.createFromFile("./assets/map/to_give/parchemin_6.png", {0, 0, 215, 64})
assets["pot1"] = lsfml.texture.createFromFile("./assets/map/to_give/pot1.png", {0, 0, 76, 84})
assets["pot2"] = lsfml.texture.createFromFile("./assets/map/to_give/pot2.png", {0, 0, 28, 56})
assets["pot3"] = lsfml.texture.createFromFile("./assets/map/to_give/pot3.png", {0, 0, 35, 56})
assets["pot4"] = lsfml.texture.createFromFile("./assets/map/to_give/pot4.png", {0, 0, 76, 80})
assets["pot5"] = lsfml.texture.createFromFile("./assets/map/to_give/pot5.png", {0, 0, 34, 84})
assets["pot6"] = lsfml.texture.createFromFile("./assets/map/to_give/pot6.png", {0, 0, 28, 32})
assets["status"] = lsfml.texture.createFromFile("./assets/map/to_give/status.png", {0, 0, 100, 174})
assets["table"] = lsfml.texture.createFromFile("./assets/map/to_give/table.png", {0, 0, 200, 127})
assets["tablette"] = lsfml.texture.createFromFile("./assets/map/to_give/tablette.png", {0, 0, 176, 116})
assets["teleporter"] = lsfml.texture.createFromFile("./assets/map/to_give/teleporter.png", {0, 0, 130, 248})
assets["torch"] = lsfml.texture.createFromFile("./assets/map/to_give/torch.png", {0, 0, 55, 111})
assets["torch_empty"] = lsfml.texture.createFromFile("./assets/map/to_give/torch_empty.png", {0, 0, 55, 84})
assets["tube_bleu_casser"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_bleu_casser.png", {0, 0, 252, 248})
assets["tube_bleu_femme"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_bleu_femme.png", {0, 0, 159, 247})
assets["tube_bleu_homme"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_bleu_homme.png", {0, 0, 157, 244})
assets["tube_bleu_transform"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_bleu_transform.png", {0, 0, 131, 204})
assets["tube_vert_casser"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_vert_casser.png", {0, 0, 252, 248})
assets["tube_vert_empty"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_vert_empty.png", {0, 0, 159, 248})
assets["tube_vert_femme"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_vert_femme.png", {0, 0, 159, 248})
assets["tube_vert_homme"] = lsfml.texture.createFromFile("./assets/map/to_give/tube_vert_homme.png", {0, 0, 160, 248})
assets["door"] = lsfml.texture.createFromFile("./assets/map/hodooor400x351.png", {0, 0, 5200, 351})

-- =======================
-- =        FONTS        =
-- =======================

assets["fsys"] = lsfml.font.createFromFile("./assets/fonts/fsys.ttf")

-- =======================
-- =       SOUNDS        =
-- =======================

assets["button_hover_sfx"] = lsfml.sound.createFromFile("./assets/sound/button_hover.wav")
assets["dash"] = lsfml.sound.createFromFile("./assets/sound/dash.wav")
assets["heal"] = lsfml.sound.createFromFile("./assets/sound/heal.ogg")
assets["shield"] = lsfml.sound.createFromFile("./assets/sound/shield.ogg")
assets["deny"] = lsfml.sound.createFromFile("./assets/sound/denied.wav")
assets["time"] = lsfml.sound.createFromFile("./assets/sound/time.ogg")
assets["elec"] = lsfml.sound.createFromFile("./assets/sound/elec.ogg")
assets["repulsion"] = lsfml.sound.createFromFile("./assets/sound/shockwave.ogg")
assets["bouleelec"] = lsfml.sound.createFromFile("./assets/sound/bouleelec.ogg")
assets["rayon_start"] = lsfml.sound.createFromFile("./assets/sound/rayon_start.ogg")
assets["rayon_idle"] = lsfml.sound.createFromFile("./assets/sound/rayon_idle.ogg")
assets["rayon_end"] = lsfml.sound.createFromFile("./assets/sound/rayon_end.ogg")
assets["pic"] = lsfml.sound.createFromFile("./assets/sound/pic.ogg")
assets["robot2_sound"] = lsfml.sound.createFromFile("./assets/sound/robot2.ogg")
assets["robot1_sound"] = lsfml.sound.createFromFile("./assets/sound/robot1.ogg")
assets["laser_sound"] = lsfml.sound.createFromFile("./assets/sound/laser.ogg")
assets["door_sound"] = lsfml.sound.createFromFile("./assets/sound/door.ogg")

-- =======================
-- =        MUSICS       =
-- =======================

assets["menu_music"] = lsfml.music.createFromFile("./assets/music/main_menu.ogg")
assets["ambiance_music"] = lsfml.music.createFromFile("./assets/music/ambiance_game.ogg")
