local Utility = require("Utility")


local Abaddon = {}

optionEnableScript = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "1.Enable", "Turn on/off this script.")
PressComboKey = Menu.AddKeyOption({ "Hero by Rasta","Abaddon" }, "2. Execute combo key", Enum.ButtonCode.KEY_I)
local Addskill1 = Menu.AddOption({"Hero by Rasta", "Abaddon", "Skills"}, "Aphotic Shield","Enable Skill")
local Addskill2 = Menu.AddOption({"Hero by Rasta", "Abaddon", "Skills"}, "Mist Coil","Enable Skill")
local optionAutoSave = Menu.AddOption({"Hero by Rasta", "Abaddon","Skills"}, "Auto Save", "Auto cast 'Aphotic Shield' to save needed ally")
local optionKillSteal = Menu.AddOption({"Hero by Rasta", "Abaddon","Skills"}, "Kill Steal", "Auto cast 'Mist Coil' to Kill Steal")
local Addethereal = Menu.AddOptionCombo({"Hero by Rasta", "Abaddon", "Items" }, "Ethereal Blade", {"Use in Combo", "Just Kill Steal"}, 1)
local AddSatanic = Menu.AddOptionSlider({"Hero by Rasta", "Abaddon", "Items"}, "Auto Satanic", "hp for acrivation", 400, 2000, 1000)
local Addurna = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Urn of Shadows","Use item on combo")
local Addsoulring = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Soul Ring","Use item on combo")
local Addspirit = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Spirit Vessel","Use item on combo")
local Addpipe = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Pipe of Insigth","Use item on combo")
local Addskythe = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Scythe of Vyse","Use item on combo")
local Addcrimpson = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Crimson Guard","Use item on combo")
local Addhalebard = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Heavens Halberd","Use item on combo")
local AddBKB = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "BKB","Use item on combo")
local Addshivas = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Shivas Guard","Use item on combo")
local Addmjollnir = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Mjollnir","Use item on combo")
local Addatos = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Rod of Atos","Use item on combo")
local AddMoM = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Mask of Madnes","Use item on combo")
local Addnecronomicon = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Necronomicon","Use item on combo")
local Addveilofdiscord = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Veil of Discord","Use item on combo")
local Addlotusorb = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Lotus Orb","Use item on combo")
local Addmanta = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Manta Style","Use item on combo")
local Addblademail = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Blade Mail","Use item on combo")
local Adddiffusalblade = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Diffusal Blade","Use item on combo")
local Addnullifier = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Nullifier","Use item on combo")
local Addmedallion = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Medallion of Courage","Use item on combo")
local Addsolarcrest = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Solar Crest","Use item on combo")
local Addorchid = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Orchid","Use item on combo")
local Addbloodthorn = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Bloodthorn","Use item on combo")
local Addabyssalblade = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Abyssal Blade","Use item on combo")
local Addforcestaff = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Force Staff","Use item on combo")
local Addhurricanepike = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Hurricane pike","Use item on combo")
local Addblink = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Blink","Use item on combo")
local Addeul = Menu.AddOption({"Hero by Rasta", "Abaddon", "Items" }, "Eul","Use item on combo")
local optionAwareness = Menu.AddOption({"Hero by Rasta", "Abaddon"}, "Awareness", "Show how many hits left to kill enemy")
local font = Renderer.LoadFont("Tahoma", 30, Enum.FontWeight.EXTRABOLD)
Abaddon.npcName = "npc_dota_hero_abaddon"

function Abaddon.OnUpdate()

	hp = Menu.GetValue(AddSatanic)	

    local myHero = Heroes.GetLocal()
    if not myHero then return end
    if not Utility.IsSuitableToCastSpell(myHero) then return end
    if NPC.GetUnitName(myHero) ~= Abaddon.npcName then return end
	
    if Menu.IsEnabled(optionAutoSave) then
        Abaddon.AutoSave(myHero)
    end

    if Menu.IsEnabled(optionKillSteal) then
        Abaddon.KillSteal(myHero)
    end
	
	if Menu.GetValue(Addethereal) == 1 then
	Abaddon.Ethereal(myHero)
	end
	

	myMana = NPC.GetMana(myHero)
	satanic = NPC.GetItem(myHero, "item_satanic")
    if satanic and Entity.GetHealth(myHero) < hp and Menu.IsEnabled(AddSatanic) and Ability.IsCastable(satanic, myMana) and Ability.IsReady(satanic) then
    Ability.CastNoTarget(satanic)
    return
    end
	
	if not Menu.IsEnabled(optionEnableScript) then return true end
	
		if Menu.IsKeyDown(PressComboKey) then	
		-- Skills
		local aphoticshield = NPC.GetAbility(myHero, "abaddon_aphotic_shield")
		local mistcoil = NPC.GetAbility(myHero, "abaddon_death_coil")  
	
		
		-- Items
		local shivas = NPC.GetItem(myHero, "item_shivas_guard", true)
        local mjolnir = NPC.GetItem(myHero, "item_mjollnir", true)
        local manta = NPC.GetItem(myHero, "item_manta", true)
        local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
        local MoM = NPC.GetItem(myHero, "item_mask_of_madness", true)
        local necronomicon1 = NPC.GetItem(myHero, "item_necronomicon", true)
        local necronomicon2 = NPC.GetItem(myHero, "item_necronomicon_2", true)
        local necronomicon3 = NPC.GetItem(myHero, "item_necronomicon_3", true)
        local discord = NPC.GetItem(myHero, "item_veil_of_discord", true)
		local lotus = NPC.GetItem(myHero, "item_lotus_orb", true)
		local BKB = NPC.GetItem(myHero, "item_black_king_bar", true)
		local blademail = NPC.GetItem(myHero, "item_blade_mail", true)
		local diffusal = NPC.GetItem(myHero, "item_diffusal_blade", true)
		local nullifier = NPC.GetItem(myHero, "item_nullifier", true)
		local medallion = NPC.GetItem(myHero, "item_medallion_of_courage", true)
		local solarCrest = NPC.GetItem(myHero, "item_solar_crest", true)
		local aghanimScepter = NPC.GetItem(myHero, "item_ultimate_scepter", true)
		local orchid = NPC.GetItem(myHero, "item_orchid", true)
		local bloodthorn = NPC.GetItem(myHero, "item_bloodthorn", true)
		local abyssalblade = NPC.GetItem(myHero, "item_abyssal_blade", true)
		local forceStaff = NPC.GetItem(myHero, "item_force_staff", true)
		local hurricanePike = NPC.GetItem(myHero, "item_hurricane_pike", true)
		local eul = NPC.GetItem(myHero, "item_cyclone", true)
		local Blink = NPC.GetItem(myHero, "item_blink", true)
 		local soulring = NPC.GetItem(myHero,"item_soul_ring", true) 
 		local pipe = NPC.GetItem(myHero,"item_pipe", true) 
		local Hex = NPC.GetItem(myHero,"item_sheepstick", true) 
    	local crimsonguard = NPC.GetItem(myHero,"item_crimson_guard", true) 
		local halberd = NPC.GetItem(myHero,"item_heavens_halberd", true)
		local ethereal = NPC.GetItem(myHero,"item_ethereal_blade", true)
		local urna = NPC.GetItem(myHero,"item_urn_of_shadows", true)
		local spiritvessel = NPC.GetItem(myHero,"item_spirit_vessel", true)
		
		local myMana = NPC.GetMana(myHero)
		local enemyTarget = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		
		if enemyTarget and NPC.HasModifier(enemyTarget, "modifier_item_ultimate_scepter") and Ability.IsReady(NPC.GetAbility(enemyTarget, "antimage_spell_shield")) then
			

			if diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
				Ability.CastTarget(diffusal, enemyTarget) 
			end
			
			return 
		end
		
		if enemyTarget and NPC.IsLinkensProtected(enemyTarget) then
			if forceStaff and Ability.IsReady(forceStaff) and Ability.IsCastable(forceStaff, myMana) then
				Ability.CastTarget(forceStaff, enemyTarget) 
			end
			
			if hurricanePike and Ability.IsReady(hurricanePike) and Ability.IsCastable(hurricanePike, myMana) then
				Ability.CastTarget(hurricanePike, enemyTarget) 
			end
			
			if eul and Ability.IsReady(eul) and Ability.IsCastable(eul, myMana) then
				Ability.CastTarget(eul, enemyTarget) 
			end
			
			if diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
				Ability.CastTarget(diffusal, enemyTarget) 
			end
			
			if abyssalblade and Ability.IsReady(abyssalblade) and Ability.IsCastable(abyssalblade, myMana) then
				Ability.CastTarget(abyssalblade, enemyTarget) 
			end
			
			if orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) then
				Ability.CastTarget(orchid, enemyTarget) 
			end
		
			if bloodthorn and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) then
				Ability.CastTarget(bloodthorn, enemyTarget) 
			end
			
			return 
		end
		
		if Menu.IsEnabled (Addskill1) and aphoticshield and enemyTarget and Ability.IsReady(aphoticshield) and Ability.IsCastable(aphoticshield, myMana) then
			Ability.CastTarget(aphoticshield, myHero)
		end
		
		if Menu.IsEnabled(Addblink) and Blink and Ability.IsCastable(Blink, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),1200,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
		Ability.CastPosition(Blink,enemyAbsOrigin) 
		end 
		
		if Menu.IsEnabled (Addskill2) and mistcoil and enemyTarget and Ability.IsReady(mistcoil) and Ability.IsCastable(mistcoil, myMana) then
			Ability.CastTarget(mistcoil, enemyTarget)
		end
		
		if Menu.IsEnabled (Addurna) and urna and enemyTarget and Ability.IsReady(urna) and Ability.IsCastable(urna, myMana) then
			Ability.CastTarget(urna, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addsoulring) and soulring and Ability.IsReady(soulring) and Ability.IsCastable(soulring, myMana) then
			Ability.CastNoTarget(soulring) 
		end
			
       if Menu.IsEnabled (Addspirit) and spiritvessel and enemyTarget and Ability.IsReady(spiritvessel) and Ability.IsCastable(spiritvessel, myMana) then
			Ability.CastTarget(spiritvessel, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addpipe) and pipe and Ability.IsReady(pipe) and Ability.IsCastable(pipe, myMana) then
			Ability.CastNoTarget(pipe) 
		end
		
		if Menu.IsEnabled (Addskythe) and Hex and enemyTarget and Ability.IsReady(Hex) and Ability.IsCastable(Hex, myMana) then
			Ability.CastTarget(Hex, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addcrimpson) and crimsonguard and Ability.IsReady(crimsonguard) and Ability.IsCastable(crimsonguard, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),800,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
			Ability.CastNoTarget(crimsonguard) 
		end	
		
		if Menu.IsEnabled (Addhalebard) and halberd and enemyTarget and Ability.IsReady(halberd) and Ability.IsCastable(halberd, myMana) then
			Ability.CastTarget(halberd, enemyTarget) 	
		end		
		
		if Menu.IsEnabled(AddBKB) and BKB and Ability.IsReady(BKB) and Ability.IsCastable(BKB, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),800,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
			Ability.CastNoTarget(BKB) 
		end 
		
		if Menu.IsEnabled(Addshivas) and shivas and enemyTarget and Ability.IsReady(shivas) and Ability.IsCastable(shivas, myMana) and  enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),800,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
			Ability.CastNoTarget(shivas) 
		end
		
		if Menu.IsEnabled(Addmjollnir) and enemyTarget and mjolnir and Ability.IsReady(mjolnir) and Ability.IsCastable(mjolnir, myMana) and  enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),800,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
			Ability.CastTarget(mjolnir, myHero) 
		end

		if Menu.IsEnabled(Addatos) and enemyTarget and atos and Ability.IsReady(atos) and Ability.IsCastable(atos, myMana) then
			Ability.CastTarget(atos, enemyTarget) 
		end

		if Menu.IsEnabled(Addnecronomicon) and enemyTarget and necronomicon1 and Ability.IsReady(necronomicon1) and Ability.IsCastable(necronomicon1, myMana) then
			Ability.CastNoTarget(necronomicon1) 
		end

		if Menu.IsEnabled(Addnecronomicon) and enemyTarget and necronomicon2 and Ability.IsReady(necronomicon2) and Ability.IsCastable(necronomicon2, myMana) then
			Ability.CastNoTarget(necronomicon2) 
		end

		if Menu.IsEnabled(Addnecronomicon) and enemyTarget and necronomicon3 and Ability.IsReady(necronomicon3) and Ability.IsCastable(necronomicon3, myMana) then
			Ability.CastNoTarget(necronomicon3) 
		end

		if Menu.IsEnabled(Addveilofdiscord) and discord and Ability.IsCastable(discord, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),1200,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
		Ability.CastPosition(discord,enemyAbsOrigin) 
		end

		if Menu.IsEnabled(Addmanta) and enemyTarget and manta and Ability.IsReady(manta) and Ability.IsCastable(manta, myMana) then
			Ability.CastNoTarget(manta) 
		end

		if Menu.IsEnabled(Addlotusorb) and enemyTarget and lotus and Ability.IsReady(lotus) and Ability.IsCastable(lotus, myMana) then
			Ability.CastTarget(lotus, myHero) 
		end
		
		if Menu.IsEnabled(Addabyssalblade) and enemyTarget and abyssalblade and Ability.IsReady(abyssalblade) and Ability.IsCastable(abyssalblade, myMana) then
			Ability.CastTarget(abyssalblade, enemyTarget) 
		end
		
		if Menu.IsEnabled(Adddiffusalblade) and enemyTarget and diffusal and Ability.IsReady(diffusal) and Ability.IsCastable(diffusal, myMana) then
			Ability.CastTarget(diffusal, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addblademail) and enemyTarget and blademail and Ability.IsReady(blademail) and Ability.IsCastable(blademail, myMana) and enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),800,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
			Ability.CastNoTarget(blademail) 
		end
		
		if Menu.IsEnabled(Addmedallion) and enemyTarget and medallion and Ability.IsReady(medallion) and Ability.IsCastable(medallion, myMana) then
			Ability.CastTarget(medallion, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addsolarcrest) and enemyTarget and solarCrest and Ability.IsReady(solarCrest) and Ability.IsCastable(solarCrest, myMana) then
			Ability.CastTarget(solarCrest, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addorchid) and enemyTarget and orchid and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) then
			Ability.CastTarget(orchid, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addbloodthorn) and enemyTarget and bloodthorn and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) then
			Ability.CastTarget(bloodthorn, enemyTarget) 
		end
		
		if Menu.IsEnabled(Addnullifier) and enemyTarget and nullifier and Ability.IsReady(nullifier) and Ability.IsCastable(nullifier, myMana) then
			Ability.CastTarget(nullifier, enemyTarget) 
		end
		
		if Menu.IsEnabled(AddMoM) and enemyTarget and MoM and Ability.IsReady(MoM) and Ability.IsCastable(MoM, myMana) then
			Ability.CastNoTarget(MoM) 
		end
		
		if Menu.GetValue(Addethereal) == 0 and  enemyTarget and ethereal and Ability.IsReady(ethereal) and Ability.IsCastable(ethereal, myMana) then
			Ability.CastTarget(ethereal, enemyTarget) 
		end
		
		if enemyTarget ~= nil and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(enemyTarget),1300,0) then 
		local enemyAbsOrigin = Entity.GetAbsOrigin(enemyTarget)
		Player.AttackTarget(Players.GetLocal(), myHero, enemyTarget)
		return 
		end
	end
end

function Abaddon.OnDraw()
	if not Menu.IsEnabled(optionAwareness) then return end

    local myHero = Heroes.GetLocal()
    if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_abaddon" then return end

    local coil_damage = 0
    local coil = NPC.GetAbility(myHero, "abaddon_death_coil")
    if coil and Ability.IsCastable(coil, NPC.GetMana(myHero)) then
        coil_damage = 50 + 50 * Ability.GetLevel(coil)
    end

    for i = 1, Heroes.Count() do
        local enemy = Heroes.Get(i)
        if not NPC.IsIllusion(enemy) and not Entity.IsSameTeam(myHero, enemy) and not Entity.IsDormant(enemy) and Entity.IsAlive(enemy) then
            
            local enemyHp = Entity.GetHealth(enemy)
            local physical_damage = NPC.GetTrueDamage(myHero) * NPC.GetArmorDamageMultiplier(enemy) 
            local magical_damage = coil_damage * NPC.GetMagicalArmorDamageMultiplier(enemy)
            local enemyHpLeft = enemyHp - magical_damage
            local hitsLeft = math.ceil(enemyHpLeft / math.max(physical_damage, 1))
            
            -- draw
            local pos = Entity.GetAbsOrigin(enemy)
            local x, y, visible = Renderer.WorldToScreen(pos)

              -- red : can kill; green : cant kill
            if enemyHpLeft <= 0 then
                Renderer.SetDrawColor(255, 0, 0, 255)
                Renderer.DrawTextCentered(font, x, y, "Kill", 1)
            else
                Renderer.SetDrawColor(0, 255, 0, 255)
                Renderer.DrawTextCentered(font, x, y, hitsLeft, 1)
            end
        end
	end
end

function Abaddon.AutoSave(myHero)
    local shield = NPC.GetAbility(myHero, "abaddon_aphotic_shield")
    if not shield or not Ability.IsCastable(shield, NPC.GetMana(myHero)) then return end

    if Utility.NeedToBeSaved(myHero) and Utility.CanCastSpellOn(myHero) then
        Ability.CastTarget(shield, myHero)
        return
    end

    local range = 500
    local allies = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_FRIEND)
    for i, ally in ipairs(allies) do
	    if Utility.NeedToBeSaved(ally) and Utility.CanCastSpellOn(ally) then
	        Ability.CastTarget(shield, ally)
	        return
	    end
    end
end

function Abaddon.KillSteal(myHero)
    local coil = NPC.GetAbility(myHero, "abaddon_death_coil")
    if not coil or not Ability.IsCastable(coil, NPC.GetMana(myHero)) then return end
    local damage = 50 + 50 * Ability.GetLevel(coil)

    local range = 800
    local enemies = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
    if not enemies or #enemies <= 0 then return end

    for i, enemy in ipairs(enemies) do
    	local true_damage = damage * NPC.GetMagicalArmorDamageMultiplier(enemy)
	    if Entity.GetHealth(enemy) <= true_damage and Utility.CanCastSpellOn(enemy) then
	        Ability.CastTarget(coil, enemy)
	        return
	    end
    end
end

function Abaddon.Ethereal(myHero)
    local Ethereal = NPC.GetItem(myHero,"item_ethereal_blade")
    if not Ethereal or not Ability.IsCastable(Ethereal, NPC.GetMana(myHero)) then return     end
    local damage = Hero.GetStrengthTotal(myHero) * 2 + 75
    local range = 800
    local enemies = NPC.GetHeroesInRadius(myHero, range, Enum.TeamType.TEAM_ENEMY)
    if not enemies or #enemies <= 0 then return     end

    for i, enemy in ipairs(enemies) do
		local enemyHPregen = NPC.GetHealthRegen (enemy) * 3.5
    	local true_damage = damage * NPC.GetMagicalArmorDamageMultiplier(enemy)
	    if Entity.GetHealth(enemy) <= true_damage and Utility.CanCastSpellOn(enemy) then
	        Ability.CastTarget(Ethereal, enemy)
	        return
	    end
    end
end

return Abaddon
