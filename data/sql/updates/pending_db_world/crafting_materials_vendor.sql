-- Crafting materials vendor (NPC 1275)
-- Uses INSERT IGNORE...SELECT so you can add items by name without looking up IDs.
-- To expand: add more names to any IN (...) list, or copy the pattern for a new section.

-- ============================================================
-- HERBALISM
-- ============================================================

-- fishing
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Oily Blackmouth', 'Firefin Snapper');

-- Apprentice (1–75)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Peacebloom', 'Silverleaf', 'Earthroot');

-- Journeyman (75–150)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Mageroyal', 'Briarthorn', 'Swiftthistle', 'Stranglekelp', 'Bruiseweed');

-- Artisan (150–225)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Wild Steelbloom', 'Grave Moss', 'Kingsblood', 'Liferoot', 'Fadeleaf', 'Goldthorn');

-- Master (225–300)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Firebloom', 'Purple Lotus', 'Arthas'' Tears', 'Sungrass', 'Blindweed', 'Ghost Mushroom', 'Gromsblood');

-- Grand Master (300–375)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Golden Sansam', 'Dreamfoil', 'Mountain Silversage', 'Plaguebloom', 'Icecap', 'Black Lotus');

-- WotLK (350–450)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5503, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Goldclover', 'Tiger Lily', 'Talandra''s Rose', 'Lichbloom', 'Icethorn', 'Adder''s Tongue');

-- ============================================================
-- MINING — Ore & Stone
-- ============================================================

-- Apprentice (1–65)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Copper Ore', 'Rough Stone');

-- Journeyman (65–125)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Tin Ore', 'Coarse Stone', 'Silver Ore');

-- Artisan (125–175)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Iron Ore', 'Heavy Stone', 'Gold Ore');

-- Master (175–305)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Mithril Ore', 'Solid Stone', 'Truesilver Ore');

-- Grand Master (275–375)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Thorium Ore', 'Dense Stone', 'Dark Iron Ore', 'Arcane Crystal');

-- WotLK (350–450)
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5512, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Cobalt Ore', 'Saronite Ore', 'Titanium Ore', 'Crystallized Earth');

-- ============================================================
-- SKINNING — Leather & Hide
-- ============================================================

INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5565, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN (
    'Light Leather',  'Light Hide',
    'Medium Leather', 'Medium Hide',
    'Heavy Leather',  'Heavy Hide',
    'Thick Leather',  'Thick Hide',
    'Rugged Leather', 'Rugged Hide'
);

-- WotLK leather
INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 5565, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN ('Borean Leather', 'Arctic Fur', 'Icy Dragonscale', 'Jormungar Scale', 'Nerubian Chitin', 'Deepsea Scale');

-- ============================================================
-- CLOTH (Tailoring)
-- ============================================================

INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 1347, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN (
    'Linen Cloth',
    'Wool Cloth',
    'Silk Cloth',
    'Mageweave Cloth',
    'Runecloth',
    'Netherweave Cloth',
    'Frostweave Cloth'
);

-- ============================================================
-- mage reagents
-- ============================================================

INSERT IGNORE INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
SELECT 1275, 0, entry, 0, 0, 0 FROM item_template
WHERE name IN (
    'Light Feather'
);