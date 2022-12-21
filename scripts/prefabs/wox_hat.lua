local assets =
{
	Asset("ANIM", "anim/hat_mox.zip"),
	Asset("ATLAS", "images/inventoryimages/wox_hat.xml"),
	Asset("IMAGE", "images/inventoryimages/wox_hat.tex"),
}

local hungerloots =
{
	carrot = 1,
	kelp = 0.25,
	ratatouille = 0.1,
	carrat = 0.005,
}

local sanityloots =
{
	balloonparty_confetti_cloud = 1,
	flower = 0.25,
	moonbutterfly = 0.1,
	bird_mutant_spitter = 0.005,
}

local healthloots =
{
	healingsalve = 1,
	tillweedsalve = 0.25,
	bandage = 0.1,
	bunnystew = 0.005,
}

local function OnCharged(inst)
	inst.components.useableitem.inuse = false
end

local function OnDischarged(inst)
	inst.components.useableitem.inuse = true
end

local function onequip(inst, owner)

	owner.AnimState:OverrideSymbol("swap_hat", "hat_mox", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAIR_HAT")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Hide("HAIR")

	if owner:HasTag("player") then
		owner.AnimState:Hide("HEAD")
		owner.AnimState:Show("HEAD_HAT")
	end
end

local function onunequip(inst, owner)

	owner.AnimState:ClearOverrideSymbol("swap_hat")
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAIR_HAT")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")

	if owner:HasTag("player") then
		owner.AnimState:Show("HEAD")
		owner.AnimState:Hide("HEAD_HAT")
	end
end

local function onuse(inst)

	local char_tags = 
	{
		"quagmire_foodie", "pyromaniac", 
		"strongman", "ghostlyfriend", 
		"soulless", "insomniac", 
		"woodcutter", "mime", 
		"shadowmagic", "valkyrie", 
		"spiderwhisperer", "handyperson", 
		"masterchef", "soulstealer", 
		"self_fertilizable", "playermerm", 
		"pebblemaker", "pocketwatchcaster"
	}
	
	local char_loots = 
	{
		"nightmarefuel", "beardhair", 
		"potato", "ghostflower", 
		"trinket_6", "cutreeds", 
		"monstermeat", "poop", 
		"rabbit", "meat", 
		"spider", "sewing_tape", 
		"saltrock", "wortox_soul", 
		"compostwrap", "tentaclespots", 
		"smallmeat_dried", "thulecite_pieces"
	}
	
	local had_loot = false

	local owner = inst.components.inventoryitem.owner

	local hungerper = owner.components.hunger:GetPercent()
	local healthper = owner.components.health:GetPercent()
	local sanityper = owner.components.sanity:GetPercent()

	if owner:HasTag("wox") then
	
		if hungerper < 0.5 and hungerper < healthper and hungerper < sanityper then
		
			for i = 1, 2 do
				inst.hungerloot = SpawnPrefab(weighted_random_choice(hungerloots))
				owner.components.inventory:GiveItem(inst.hungerloot, nil, owner:GetPosition())
			end
			
		elseif hungerper < healthper and hungerper < sanityper then
			
			inst.hungerloot = SpawnPrefab(weighted_random_choice(hungerloots))
			owner.components.inventory:GiveItem(inst.hungerloot, nil, owner:GetPosition())

		elseif sanityper < 0.85 and sanityper < healthper then
			
			for i = 1, 3 do
				inst.sanityloot = SpawnPrefab(weighted_random_choice(sanityloots)).Transform:SetPosition(owner.Transform:GetWorldPosition())
			end
			
		elseif sanityper < healthper then
			
			inst.sanityloot = SpawnPrefab(weighted_random_choice(sanityloots)).Transform:SetPosition(owner.Transform:GetWorldPosition())
		
		elseif healthper < sanityper then
			
			inst.healthloot = SpawnPrefab(weighted_random_choice(healthloots))
			owner.components.inventory:GiveItem(inst.healthloot, nil, owner:GetPosition())
		
		else
			
			inst.hungerloot = SpawnPrefab(weighted_random_choice(hungerloots))
			owner.components.inventory:GiveItem(inst.hungerloot, nil, owner:GetPosition())
			
		end
	
		had_loot = true
	
	else
	
		for i, v in pairs(char_tags) do
			if owner:HasTag(char_tags[i]) then
				owner.components.inventory:GiveItem(SpawnPrefab(char_loots[i]), nil, owner:GetPosition())
				had_loot = true
			end
		end
	
	end
		
	if had_loot == false then
		owner.components.inventory:GiveItem(SpawnPrefab("nightmarefuel"), nil, owner:GetPosition())
	end
	
	inst.components.rechargeable:Discharge(TUNING.WOXILLIAN_HAT_COOLDOWN)
	owner.sg:GoToState("research")
	owner.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
	SpawnPrefab("chester_transform_fx").Transform:SetPosition(owner.Transform:GetWorldPosition())
	
end

local function fn()

	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("moxhat")
	inst.AnimState:SetBuild("hat_mox")
	inst.AnimState:PlayAnimation("anim")

	inst:AddTag("hat")

	MakeInventoryFloatable(inst)

	inst.entity:SetPristine()

	inst.components.floater:SetSize("med")
	inst.components.floater:SetVerticalOffset(0.1)
	inst.components.floater:SetScale(0.63)

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/wox_hat.xml"

	inst:AddComponent("inspectable")

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(onuse)

	inst:AddComponent("rechargeable")
	inst.components.rechargeable:SetOnDischargedFn(OnDischarged)
	inst.components.rechargeable:SetOnChargedFn(OnCharged)

	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)

	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED

	MakeHauntableLaunch(inst)

	return inst
end

return Prefab("wox_hat", fn, assets)