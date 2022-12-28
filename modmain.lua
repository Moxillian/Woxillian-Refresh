PrefabFiles = {
	"woxillian",
	"woxillian_none",
	"wox_hat",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/woxillian.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/woxillian.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/woxillian.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/woxillian.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/woxillian_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/woxillian_silho.xml" ),

    Asset( "IMAGE", "bigportraits/woxillian.tex" ),
    Asset( "ATLAS", "bigportraits/woxillian.xml" ),

	Asset( "IMAGE", "images/map_icons/woxillian.tex" ),
	Asset( "ATLAS", "images/map_icons/woxillian.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_woxillian.xml" ),

	Asset( "IMAGE", "images/avatars/avatar_ghost_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_woxillian.xml" ),

	Asset( "IMAGE", "images/avatars/self_inspect_woxillian.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_woxillian.xml" ),

	Asset( "IMAGE", "images/names_woxillian.tex" ),
    Asset( "ATLAS", "images/names_woxillian.xml" ),

	Asset( "IMAGE", "images/names_gold_woxillian.tex" ),
    Asset( "ATLAS", "images/names_gold_woxillian.xml" ),

	Asset("ANIM", "anim/hat_mox.zip"),

    Asset( "IMAGE", "images/inventoryimages/wox_hat.tex" ),
    Asset( "ATLAS", "images/inventoryimages/wox_hat.xml" ),
}

AddMinimapAtlas("images/map_icons/woxillian.xml")

local _G = GLOBAL
local env = env
_G.setfenv(1, _G)

STRINGS.CHARACTER_TITLES.woxillian = "The Magician"
STRINGS.CHARACTER_NAMES.woxillian = "Wox"
STRINGS.CHARACTER_DESCRIPTIONS.woxillian = "*A magician by heart\n*Has a hat for his desires\n*Is a frail bunny with a weak mind"
STRINGS.CHARACTER_QUOTES.woxillian = "\"Quite a fine day.\""
STRINGS.CHARACTER_SURVIVABILITY.woxillian = "Low"

STRINGS.NAMES.WOX_HAT = "Wox's Magic Hat"
STRINGS.RECIPE_DESC.WOX_HAT = "Gives you what you most desire!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WOX_HAT = ("It's got some magic inside!")
STRINGS.CHARACTERS.WILLOW.DESCRIBE.WOX_HAT = ("I hate this magic!")
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.WOX_HAT = ("I don't know where its contents are coming from.")
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.WOX_HAT = ("I could perform my old act, if I feel like demeaning myself.")
STRINGS.CHARACTERS.WOODIE.DESCRIBE.WOX_HAT = ("Too dapper for my tastes.")
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.WOX_HAT = ("Where stuff come from?")
STRINGS.CHARACTERS.WENDY.DESCRIBE.WOX_HAT = ("Can you pull a cure for everlasting sadness from it?")
STRINGS.CHARACTERS.WX78.DESCRIBE.WOX_HAT = ("ILLOGICAL HAT SPACE")

STRINGS.CHARACTERS.WINONA.DESCRIBE.WOX_HAT = ("Tell me when it starts making something useful.")
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.WOX_HAT = ("Squee Hopper Hat")
STRINGS.CHARACTERS.WORTOX.DESCRIBE.WOX_HAT = ("I'm quite familiar with pocket dimensions.")
STRINGS.CHARACTERS.WURT.DESCRIBE.WOX_HAT = ("Stupid hat!")
STRINGS.CHARACTERS.WALTER.DESCRIBE.WOX_HAT = ("I appreciate the mystery, but it's not my style.")
STRINGS.CHARACTERS.WANDA.DESCRIBE.WOX_HAT = ("Oh botheration, does he tangle with shadow magic as well?")

STRINGS.CHARACTERS.WOXILLIAN = require "speech_woxillian"

STRINGS.NAMES.WOXILLIAN = "Wox"
STRINGS.SKIN_NAMES.woxillian_none = "Wox"

local skin_modes = {
    {
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle",
        scale = 0.75,
        offset = { 0, -25 }
    },
}

env.AddModCharacter("woxillian", "MALE", skin_modes)

env.Recipe("wox_hat", {Ingredient("tophat", 1), Ingredient("nightmarefuel", 10), Ingredient("manrabbit_tail", 5)}, RECIPETABS.DRESS, TECH.NONE, nil, nil, nil, nil, "wox", "images/inventoryimages/wox_hat.xml", "wox_hat.tex")

STRINGS.NAMES.WOX_HAT = "Wox's Magic Hat"
TUNING.STARTING_ITEM_IMAGE_OVERRIDE.wox_hat = {atlas = "images/inventoryimages/wox_hat.xml", image = "wox_hat.tex" }

TUNING.WOXILLIAN_HEALTH = 125 --GetModConfigData("WOXHEALTH")
TUNING.WOXILLIAN_HUNGER = 175 --GetModConfigData("WOXHUNGER")
TUNING.WOXILLIAN_SANITY = 200 --GetModConfigData("WOXSANITY")

TUNING.WOX_DAMAGE = 1.5 --GetModConfigData("WOXDAMAGE")
TUNING.WOX_EFFICIENCY = 2/3 --GetModConfigData("WOXEFFECIENCY")

TUNING.WOXILLIAN_SANITY_NIGHT_DRAIN = 0.75 
TUNING.WOXILLIAN_SANITY_DRAIN  = 1.35

TUNING.WOXILLIAN_OVERHEAT_TEMP = 100
TUNING.WOXILLIAN_FREEZING_TEMP = -10

TUNING.WOXILLIAN_HAT_COOLDOWN = 240

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WOXILLIAN = {
	"wox_hat",
}

local magics = {
    "nightsword",
    "batbat",
    "multitool_axe_pickaxe",
    "ruins_bat",
    "glasscutter",
    "moonglassaxe",
}

for i, v in pairs(magics) do
    env.AddPrefabPostInit(v, function(inst)
        inst:AddTag("wox_magic")
    end)
end
