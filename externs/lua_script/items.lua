
-- =========================================
-- =                  ITEMS                =
-- =========================================

item.create("key", assets["key"], 1, {type="item", name="Clef", desc="Une clef.\nN'a pas d'utilite\npuisque vous n'avez\npas vu de serrure.\n"})
item.create("core", assets["core"], 64, {type="item", name="Coeur", desc="La partie la plus\nimportante d'un robot.\n"})
item.create("seringue", assets["seringue"], 64, {type="item", name="Seringue", desc="C'est rouge et\npourtant c'est pas\ndu sang !!!\n(coming soon)"})
item.create("seringue_mana", assets["seringue_mana"], 64, {type="item", name="Seringue bleu", desc="De la mana en seringue.\nEtonnant !"})
item.create("companion_cube", assets["companion_cube"], 64, {type="item", name="Companion Cube", desc="Le plus fidele ami\n de l'homme, du\nmoin de vous..."})
item.create("parchemin_1", assets["parchemin__1"], 1, {type="item", name="Morceau de parchemin", desc="Le premier morceau.\n"})
item.create("parchemin_2", assets["parchemin__2"], 1, {type="item", name="Morceau de parchemin", desc="Le second morceau.\n"})
item.create("parchemin_3", assets["parchemin__3"], 1, {type="item", name="Morceau de parchemin", desc="Le troisieme morceau.\n"})
item.create("parchemin_4", assets["parchemin__4"], 1, {type="item", name="Morceau de parchemin", desc="Le quatrieme morceau.\n"})
item.create("parchemin_5", assets["parchemin__5"], 1, {type="item", name="Morceau de parchemin", desc="Le cinquieme morceau.\n"})
item.create("parchemin_6", assets["parchemin__6"], 1, {type="item", name="Morceau de parchemin", desc="Le dernier morceau.\n"})
item.create("parchemin", assets["parchemin"], 1, {type="item", name="Parchemin entier", desc="Le parchemin complet\nIl emane un pouvoir\n extraordinaire."})
item.create("metal_scrap", assets["metal_scrap"], 64, {type="item", name="Bout de metal", desc="Un bout de metal.\nIl peut vous etre\nutile."})
item.create("tablette", assets["tablette"], 1, {type="item", name="tablette", desc="Oeuvre technologique !\n"})

-- =========================================
-- =                  ARMORS               =
-- =========================================

item.create("botte1", assets["botte1"], 1, {type="equipement", subtype="boot", name="Botte en bois", desc="Gaffe aux ampoules."})
item.create("casque1", assets["casque1"], 1, {type="equipement", subtype="helmet", name="Casque en bois", desc="Mieux que rien..."})
item.create("jambiere1", assets["jambiere1"], 1, {type="equipement", subtype="pant", name="Jambiere en bois", desc="Difficile de courir."})
item.create("plastron1", assets["plastron1"], 1, {type="equipement", subtype="chestplate", name="Plastron en bois", desc="Impossible a enlever."})
item.create("botte2", assets["botte2"], 1, {type="equipement", subtype="boot", name="Botte en tissu", desc="Faite gaffe ou\nvous marchez."})
item.create("casque2", assets["casque2"], 1, {type="equipement", subtype="helmet", name="Chapeau en tissu", desc="Merlin !!?"})
item.create("jambiere2", assets["jambiere2"], 1, {type="equipement", subtype="pant", name="Pantalon en tissu", desc="Mieux qu'un jean !"})
item.create("plastron2", assets["plastron2"], 1, {type="equipement", subtype="chestplate", name="Robe en tissu", desc="Pas que pour les\nfilles"})
item.create("botte3", assets["botte3"], 1, {type="equipement", subtype="boot", name="Botte en Fer", desc="Digne d'un bon\nRPG."})
item.create("casque3", assets["casque3"], 1, {type="equipement", subtype="helmet", name="Casque en Fer", desc="Digne d'un bon\nRPG"})
item.create("jambiere3", assets["jambiere3"], 1, {type="equipement", subtype="pant", name="Jambiere en Fer", desc="Digne d'un bon\nRPG"})
item.create("plastron3", assets["plastron3"], 1, {type="equipement", subtype="chestplate", name="Plastron en Fer", desc="Vous avez compris"})
item.create("botte4", assets["botte4"], 1, {type="equipement", subtype="boot", name="Botte en Or", desc="Plus resistant que\ndans Minecraft"})
item.create("casque4", assets["casque4"], 1, {type="equipement", subtype="helmet", name="Casque en Or", desc="Moins lourd qu'on\nle crois."})
item.create("jambiere4", assets["jambiere4"], 1, {type="equipement", subtype="pant", name="Jambiere en Or", desc="Plus lourd qu'on\nle crois."})
item.create("plastron4", assets["plastron4"], 1, {type="equipement", subtype="chestplate", name="Plastron en Or", desc="Go enchant P4."})
item.create("botte5", assets["botte5"], 1, {type="equipement", subtype="boot", name="Botte en Mythril", desc="Plutot rare !"})
item.create("casque5", assets["casque5"], 1, {type="equipement", subtype="helmet", name="Casque en Mythril", desc="Quel chance !"})
item.create("jambiere5", assets["jambiere5"], 1, {type="equipement", subtype="pant", name="Jambiere en Mythril", desc="Fait de l'or des\nnains"})
item.create("plastron5", assets["plastron5"], 1, {type="equipement", subtype="chestplate", name="Plastron en Mythril", desc="Abrite l'ame du\nguerrier"})

-- =========================================
-- =                  WEAPONS              =
-- =========================================

item.create("scythe", assets["scythe_item"], 1, {type="weapon", name="Scythe", desc="Equipez la dans le\nslot du bas de\nvotre inventaire.\nVous pouvez charger\nvos attaques.", damage=50, rarity="God"})