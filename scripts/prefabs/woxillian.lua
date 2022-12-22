local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.WOXILLIAN
end
local prefabs = FlattenTree(start_inv, true)

local function GetEquippableDapperness(owner, equippable)
    local dapperness = equippable:GetDapperness(owner, owner.components.sanity.no_moisture_penalty)
    if equippable.inst:HasTag("shadow_item") then
        return dapperness * TUNING.WANDA_SHADOW_RESISTANCE_OLD
    end
end

local function CustomCombatDamage(inst, target, weapon, multiplier, mount, damage)
    if mount == nil then
        if weapon ~= nil and weapon:HasTag("wox_magic") then
            return TUNING.WOX_DAMAGE
        end
    end

    return 1
end

local function ActionDrains(inst, data)
    if data.action.action == ACTIONS.ATTACK then
        inst.components.sanity:DoDelta(-1)
    end
end

local function InducedInsanity(inst)
	if inst.components.sanity ~= nil then
		if inst.components.sanity:GetRealPercent() * 200 <= 20 then
			inst.components.sanity:SetInducedInsanity(inst, true)
		end
	
		if inst.components.sanity:GetRealPercent() * 200 >= 30 then
			inst.components.sanity:SetInducedInsanity(inst, false)
		end
	end
end


local function ForceToTakeMoreDamage(inst)
    local self = inst.components.combat
    local _GetAttacked = self.GetAttacked
    self.GetAttacked = function(self, attacker, damage, weapon, stimuli)
    	if attacker and damage then
    		damage = damage * 1.35
    	end
    	return _GetAttacked(self, attacker, damage, weapon, stimuli)
		
    end
end

local common_postinit = function(inst)
	inst.MiniMapEntity:SetIcon( "woxillian.tex" )

	inst:AddTag("wox")
	--if TUNING.WOXILLIAN_WANDASWATCH == true then
		inst:AddTag("pocketwatchcaster")
		inst:AddComponent("positionalwarp")
	--end
end

local master_postinit = function(inst)

	inst.Transform:SetScale(1, 1, .9)

    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

	inst.soundsname = "willow"

	inst.components.health:SetMaxHealth(TUNING.WOXILLIAN_HEALTH)
	inst.components.hunger:SetMax(TUNING.WOXILLIAN_HUNGER)
	inst.components.sanity:SetMax(TUNING.WOXILLIAN_SANITY)
	
    inst.components.combat.customdamagemultfn = CustomCombatDamage 
	inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness 

	inst.components.sanity.night_drain_mult = TUNING.WOXILLIAN_SANITY_NIGHT_DRAIN
    inst.components.sanity.neg_aura_mult = TUNING.WOXILLIAN_SANITY_DRAIN 
	
	inst.components.temperature.maxtemp = TUNING.WOXILLIAN_OVERHEAT_TEMP
	inst.components.temperature.mintemp = TUNING.WOXILLIAN_FREEZING_TEMP

	inst.components.foodaffinity:AddPrefabAffinity("ratatouille", TUNING.AFFINITY_15_CALORIES_MED)

	inst.customidleanim = "idle_wurt"

    if inst.components.efficientuser == nil then
        inst:AddComponent("efficientuser")
    end
    inst.components.efficientuser:AddMultiplier(ACTIONS.ATTACK, TUNING.WOX_EFFICIENCY, inst) 

	ForceToTakeMoreDamage(inst)

	inst:ListenForEvent("sanitydelta", InducedInsanity)
    inst:ListenForEvent("performaction", ActionDrains)

end

return MakePlayerCharacter("woxillian", prefabs, assets, common_postinit, master_postinit, prefabs)
