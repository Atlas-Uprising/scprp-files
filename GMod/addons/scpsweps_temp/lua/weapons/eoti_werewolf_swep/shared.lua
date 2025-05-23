if( SERVER ) then
	AddCSLuaFile("shared.lua")
	util.AddNetworkString("ATLAS.4000.GetLocation")
end

SWEP.Base				= "weapon_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel		= "models/weapons/c_arms_citizen.mdl" 
SWEP.WorldModel		= ""	
SWEP.ViewModelFOV 	= 50
SWEP.ViewModelFlip 	= false
SWEP.DrawCrosshair	= false 

SWEP.Weight				= 1			 
SWEP.AutoSwitchTo		= true		 
SWEP.AutoSwitchFrom		= false	
SWEP.CSMuzzleFlashes	= false	 		 
	
SWEP.Primary 				= {}	
SWEP.Primary.Damage			= 50					 			  
SWEP.Primary.ClipSize		= -1		
SWEP.Primary.Delay			= 0.5	  
SWEP.Primary.DefaultClip	= 1		 
SWEP.Primary.Automatic		= true		 
SWEP.Primary.Ammo			= "none"	 

SWEP.Secondary 				= {}
SWEP.Secondary.ClipSize		= -1			
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Delay		= 2
SWEP.Secondary.Damage		= 0		 
SWEP.Secondary.Automatic	= false		 
SWEP.Secondary.Ammo			= "none"

SWEP.ReloadDelay	= 0
SWEP.AnimDelay		= 0
SWEP.AttackAnims	= { 
	"fists_left", 
	"fists_right"}

SWEP.PlayerModel	= nil
SWEP.WerewolfModel	= "models/player/stenli/lycan_werewolf.mdl"
SWEP.PlayerScale	= 1.0
SWEP.WerewolfScale	= 1.3 --Change the collision type of the werewolf

SWEP.HealthBonus	= 0
SWEP.HealAmount		= 30
SWEP.HealTimer		= 2
SWEP.HealId			= ""

SWEP.RunSpeed		= 500
SWEP.WalkSpeed		= 300
SWEP.SpeedModifier	= 1.4

SWEP.InfectChance	= 0.01
SWEP.InfectDuration	= 4 -- 5 x 12 = 60 seconds until infection turns to werewolfisms
SWEP.ToggleVFX		= true

SWEP.OldRunSpeed	= 0
SWEP.OldWalkSpeed	= 0
SWEP.OldOwner = false

SWEP.HitSound	= {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"}
SWEP.MissSound 	= {
	"weapons/iceaxe/iceaxe_swing1.wav",
	"npc/vort/claw_swing1.wav",
	"npc/vort/claw_swing2.wav"}
SWEP.FleshSound	= {
	"physics/flesh/flesh_squishy_impact_hard1.wav",
	"physics/flesh/flesh_squishy_impact_hard2.wav",
	"physics/flesh/flesh_squishy_impact_hard3.wav",
	"physics/flesh/flesh_squishy_impact_hard4.wav"}
SWEP.RoarSound = {
	"npc/ichthyosaur/attack_growl1.wav",
	"npc/ichthyosaur/attack_growl2.wav",
	"npc/ichthyosaur/attack_growl3.wav"
}
SWEP.AttackSound = {
	"npc/antlion_guard/angry1.wav",
	"npc/antlion_guard/angry2.wav",
	"npc/antlion_guard/angry3.wav"}
SWEP.SwingSound	= {
	"npc/zombie/claw_miss1.wav",
	"npc/zombie/claw_miss2.wav"}
SWEP.LeapSound = Sound("eoti/were/leaproar.wav")

if ( CLIENT ) then
	SWEP.PrintName	= "SCP 4000-W"	 
	SWEP.Category	= "Atlas Uprising - Temp SCP Sweps"
	SWEP.Author		= "War"
	SWEP.Purpose	= "\nDamage: "..SWEP.Primary.Damage.." ("..(SWEP.Primary.Damage/SWEP.Primary.Delay).." DPS)\n\nReload: Transform Human/Were\nHold E: Toggle Bloodvision\nRight-Click: Leap"
	SWEP.Slot		= 0					 
	SWEP.SlotPos	= 1
	SWEP.DrawAmmo	= false
end

function SWEP:Initialize()
	self:SetHoldType( "normal" )
	local owner = self.Owner
	if CLIENT and !file.Exists( self.WerewolfModel , "MOD" ) then 
		self.WerewolfModel = Model( "models/player/zombie_fast.mdl" )
	else self.WerewolfModel = Model( self.WerewolfModel ) end
end

function SWEP:Equip(owner)
	self.OldRunSpeed = owner:GetRunSpeed()
	self.OldWalkSpeed = owner:GetWalkSpeed()
	self.OldOwner = owner
	self:RegeneratingHealth(owner)
	timer.Simple(0.5, function()
		if !IsValid(self) then return end
		owner:SetActiveWeapon(self)
	end)
	if owner:Team() ~= TEAM_SCP_4000 then
		net.Start("ATLAS.4000.GetLocation")
		net.Send(owner)
	end
end

function SWEP:Deploy()
	if CLIENT then 
		chat.AddText(
		Color( 0, 200, 0 ), "SCP-4000-W(Controls):")
		chat.AddText(
		Color( 255, 100, 0 ), "[Reload or Mouse2] ",
		Color( 255, 255, 0 ), "Transform",
		Color( 255, 100, 0 ), " [Hold E] ",
		Color( 255, 255, 0 ), "Toggle Bloodvision",
		Color( 255, 100, 0 ), " [Mouse1/2] ",
		Color( 255, 255, 0 ), "Attack/Leap")
	end
end

function SWEP:Holster()
	local owner = self.Owner
	if owner != nil then
		self:MorphToHuman()
	end
	return true
end

if SERVER then
	function SWEP:OnRemove()
		self:RemoveSelf()
		return true
	end
end

function SWEP:OnDrop()
	self:RemoveSelf()
	return true
end

function SWEP:RemoveSelf()
	local owner = self.Owner
	if owner != nil then
		self:MorphToHuman(true)
	end
	
	if !SERVER then return end
	if timer.Exists(self.HealId) then timer.Remove( self.HealId ) return end
	self:Remove()
end

function SWEP:Reload()
	if self.ReloadDelay > CurTime() then return end
	if self.PlayerModel == nil then return end
	self.ReloadDelay = CurTime() + 4
	self.Weapon:SetNextPrimaryFire( CurTime() + 2.5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 2.5 )

	if game.MaxPlayers() < 2 then self.AnimDelay = CurTime() + 4
	else self.AnimDelay = SysTime() + 4 end
	
	local owner = self.Owner
	if !owner:IsValid() then return end
	if !owner:Alive() then return end
	
	if owner:GetModel() != self.WerewolfModel 
	then self:MorphToWerewolf()
	else self:MorphToHuman()
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	
	if game.MaxPlayers() < 2 then self.AnimDelay = CurTime() + 0.45
	else self.AnimDelay = SysTime() + 0.4 end
	
	local owner = self.Owner
	if !owner:IsValid() then return end
	if !owner:Alive() then return end
	if owner:GetModel() == self.PlayerModel then 
		self:Reload()
		return 
	end
	
	if SERVER then
		owner:SetVelocity(Vector(0,0,250))
		timer.Simple(0.15, function() 
			owner:SetVelocity(owner:GetAimVector() * 300)
		end)
    end
	
	self.Owner:EmitSound(self.LeapSound, 350, math.random(75,85))
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if game.MaxPlayers() < 2 then self.AnimDelay = CurTime() + self.Primary.Delay
	else self.AnimDelay = SysTime() + self.Primary.Delay end
	
	local owner = self.Owner
	if !owner:IsValid() then return end
	if !owner:Alive() then return end
	if owner:GetModel() == self.PlayerModel then return end
	
	self:PrimaryAttackWerewolf(owner)
end

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

function SWEP:MorphToWerewolf()
	local owner = self.Owner
	if self.PlayerModel == nil then return end
	if owner:GetModel() == self.WerewolfModel then return end
	owner:SetModelScale( self.WerewolfScale, 3 )
	owner:SetModel( self.WerewolfModel )
	
	if self.WerewolfScale > 1 then owner:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR ) 
	else owner:SetCollisionGroup( COLLISION_GROUP_NONE ) end
	
	self:Roar( owner )

	if !owner:IsValid() then return end
	if !owner:Alive() then return end
	self:SetHoldType( "knife" )
	self:SendWeaponAnim(ACT_HL2MP_IDLE_KNIFE)
	
	self.Owner:EmitSound("eoti_idlegrowlloop", 350, math.random(23,40))

	self.ToggleVFX = true
	
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_draw" ) )
end

function SWEP:MorphToHuman(ignoreModel)
	local owner = self.Owner
	if !IsValid(owner) or !IsValid(self) then return end
	if owner:GetModel() == self.PlayerModel then return end
	owner:SetModelScale( self.PlayerScale, 3 )
	if self.PlayerModel != nil and not ignoreModel then owner:SetModel( self.PlayerModel ) end
	self:Roar( owner )

	if self.PlayerScale > 1 then owner:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR ) 
	else owner:SetCollisionGroup( COLLISION_GROUP_NONE ) end

	--owner:SetRunSpeed(self.WalkSpeed)
	--owner:SetWalkSpeed(self.RunSpeed)



	if !owner:IsValid() then return end
	if !owner:Alive() then return end
	self:SetHoldType( "normal" )
	self:SendWeaponAnim(ACT_HL2MP_IDLE_KNIFE)
	
	owner:StopSound("eoti_idlegrowlloop")
	
	self.ToggleVFX = false
	
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then 
	    vm:ResetSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
    	vm:ResetSequence( vm:LookupSequence( "fists_holster" ) )
	end
end

function SWEP:Roar(owner)
	timer.Simple(0.15, function()
		if !owner:IsValid() then return end
		if !owner:Alive() then return end
		if SERVER and not CLIENT then 
			owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)
			owner:EmitSound(table.Random({
				"npc/ichthyosaur/attack_growl1.wav",
				"npc/ichthyosaur/attack_growl2.wav",
				"npc/ichthyosaur/attack_growl3.wav"
			}), 100,math.random(75,95))
		end
	end)
end

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

function SWEP:RegeneratingHealth(owner)
	local hp, maxhp
	
	self.HealId  = math.random(165, 73623)
	self.HealId = "EOTI_WEREWOLF_SWEP_"..self.HealId..owner:Name()
	
	timer.Create(self.HealId , self.HealTimer, 0, function() 
		if !SERVER
		or !self:IsValid() 
		or !timer.Exists( self.HealId )
		then return end
		
		hp = owner:Health()
		maxhp = (owner:GetMaxHealth())
		if maxhp < hp then return end
		owner:SetHealth(math.Clamp( hp + self.HealAmount, 0, maxhp ))
	end)
end

function SWEP:PrimaryAttackWerewolf(owner)
	local tr, trace, vm, anim
	
	--------------------------
	vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_idle_01" ) )
		
	anim = self.AttackAnims[ math.random( 1, 2 ) ]

	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
	
		vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( anim ) )
	end )
	
	owner:DoAnimationEvent(ACT_GMOD_GESTURE_RANGE_FRENZY)
	if SERVER then
		owner:EmitSound(table.Random(self.SwingSound))
		owner:EmitSound(table.Random(self.AttackSound), 60)
	end
	
	------------------------
	
	tr = {}
	tr.start = owner:GetShootPos()
	tr.endpos = owner:GetShootPos() + ( owner:GetAimVector() * 95 )
	tr.filter = owner
	tr.mask = MASK_SHOT
	trace = util.TraceLine( tr )

	if ( trace.Hit ) then

		if trace.Entity:IsPlayer() 
		or string.find(trace.Entity:GetClass(),"npc") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = owner:GetShootPos()
			bullet.Dir    = owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			owner:FireBullets(bullet) 
			self:Infection(trace.Entity)
			self.Weapon:EmitSound(table.Random(self.FleshSound),75)
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = owner:GetShootPos()
			bullet.Dir    = owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			owner:FireBullets(bullet) 	
			util.Decal("ManhackCut", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
			self.Weapon:EmitSound(table.Random(self.HitSound),75)
		end
	else
		self.Weapon:EmitSound(table.Random(self.MissSound),75)
	end
	
	timer.Simple( 0.06, function() owner:ViewPunch( Angle( -2, -2,  0 ) ) end )
	timer.Simple( 0.23, function() owner:ViewPunch( Angle(  3,  1,  0 ) ) end )
end

function SWEP:Infection(dmg)
	if !(math.random(0.01,1.00) >= self.InfectChance) then return end
	if !dmg:IsValid() then return end
	if !dmg:IsPlayer() then return end
	if !dmg:Alive() then return end
	if dmg:HasWeapon(self:GetClass()) then return end
	

	local id, step, cnt, rgb
	id = "WerewolfInfectionTimer_"..dmg:Name()
	step = math.floor(230/self.InfectDuration)
	if timer.Exists(id) then return end
	
	cnt = 0	
	dmg:SetRenderMode( RENDERMODE_TRANSALPHA )
	if SERVER then dmg:ChatPrint("You have contracted Lycanthropy, you will succumb in "..(self.InfectDuration*5).." seconds.") end
	dmg:EmitSound("eoti_idlegrowlloop", 350, math.random(23,40))
	
	timer.Create(id, self.InfectDuration * 5, 1, function() 
		if !dmg:IsValid()
		or !dmg:IsPlayer()
		or !dmg:Alive()
		or dmg:HasWeapon(self:GetClass())
		or !timer.Exists(id)
		then
			dmg:SetColor( Color(255,255,255) )
			dmg:SetRenderMode( RENDERMODE_NORMAL )
			dmg:StopSound("eoti_idlegrowlloop")
			timer.Remove(id)
			return false
		end
			
		rgb = 255 - (cnt * step)
		cnt = cnt + 1
		dmg:SetColor( Color(rgb,rgb,rgb) )
		
		if not SERVER and CLIENT then return end

		dmg:StopSound("eoti_idlegrowlloop")
		dmg:Give(self:GetClass())
		dmg:SetColor( Color(255,255,255) )
		dmg:SetRenderMode( RENDERMODE_NORMAL )
		timer.Remove(id)
		return true
	end)
end

function SWEP:Think()
	local t
	if game.MaxPlayers() < 2 then t = CurTime()
	else t = SysTime() end
	if self.AnimDelay > t then return true end
	
	local owner, primary
	owner = self.Owner
	primary = (self:GetNextPrimaryFire() - CurTime())
	
	if self.PlayerModel == nil then
		self.PlayerModel = ""..self.Owner:GetModel()
		self.PlayerScale = self.Owner:GetModelScale() or 1
		self.WerewolfScale = self.PlayerScale * 1.3
		self.WalkSpeed = owner:GetWalkSpeed()
		self.RunSpeed = owner:GetRunSpeed()
		return true
	elseif owner:KeyDown(IN_USE) then
		self.ToggleVFX = !self.ToggleVFX
		if CLIENT then surface.PlaySound("UI/buttonclick.wav") end
		self.AnimDelay = t + 0.5
		return true
	elseif owner:GetModel() == self.PlayerModel then
		owner:SetRunSpeed(self.RunSpeed)
		owner:SetWalkSpeed(self.WalkSpeed)
		self.AnimDelay = t + 0.45
		return true
	elseif owner:KeyDown(IN_FORWARD) and !owner:KeyDown(IN_DUCK) then
		owner:SetRunSpeed(math.Clamp(self.RunSpeed*self.SpeedModifier, 450, 1000))
		owner:SetWalkSpeed(math.Clamp(self.WalkSpeed*self.SpeedModifier, 375, 1000))
		owner:DoAnimationEvent(ACT_HL2MP_RUN_ZOMBIE_FAST)
		self.AnimDelay = t + 0.4
		return true
	elseif t + primary > t then 
		self.AnimDelay = primary + 0.05
		return true
	end
	self.AnimDelay = t + 0.5
end