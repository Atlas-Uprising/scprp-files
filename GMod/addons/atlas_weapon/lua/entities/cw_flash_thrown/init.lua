AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MaxIntensityDistance = 384 -- if an entity is THIS close to the grenade upon explosion, the intensity of the flashbang will be maximum
ENT.FlashDistance = 1024 -- will decay over this much distance
ENT.FlashDuration = 2
ENT.Model = "models/weapons/w_eq_flashbang_thrown.mdl"

local phys, ef

function ENT:Initialize()
	self:SetModel(self.Model) 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end 

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	vel = physobj:GetVelocity()
	len = vel:Length()
	
	if len > 500 then -- let it roll
		physobj:SetVelocity(vel * 0.6) -- cheap as fuck, but it works
	end
	
	if len > 100 then
		CT = CurTime()
		
		if CT > self.NextImpact then
			self:EmitSound("weapons/smokegrenade/grenade_hit1.wav", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

local traceData = {}
traceData.mask = bit.bor(CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, CONTENTS_WATER)

function ENT:Fuse(t)
	t = t or 2.5
	
	timer.Simple(2.5, function()
		if self:IsValid() then
			local hitPos = self:GetPos()
			
			-- trace up to check for impacts
			traceData.start = hitPos
			local finishPos = traceData.start + Vector(0, 0, 32)
			
			traceData.endpos = finishPos
			traceData.filter = self
			
			local trace = util.TraceLine(traceData)
			local traceZ = trace.HitPos.z
			finishPos.z = traceZ
			
			self:EmitSound("weapons/flashbang/flashbang_explode2.wav", 85, 100)
			
			for key, obj in ipairs(player.GetAll()) do
				if obj:Alive() then
					local bone = obj:LookupBone("ValveBiped.Bip01_Head1")
					
					if bone then
						local headPos, headAng = obj:GetBonePosition(bone)
						local objDist = headPos:Distance(finishPos)
						
						if objDist <= self.FlashDistance then
							traceData.filter = obj
							
							local ourAimVec = self.Owner:GetAimVector()
							
							local direction = (finishPos - headPos):GetNormal()
							local dotToGeneralDirection = ourAimVec:DotProduct(direction)
							
							traceData.start = headPos
							
							traceData.endpos = traceData.start + direction * math.min(objDist, self.FlashDistance)
							
							local trace = util.TraceLine(traceData)
							local ent = trace.Entity
							
							if not IsValid(ent) or (not ent:IsValid() and not ent:IsWorld()) or ent == self then
								local isMaxIntensity = (objDist - self.MaxIntensityDistance) < 0
								local decay = self.FlashDistance - self.MaxIntensityDistance
								local intensity = 0
								
								if isMaxIntensity then
									intensity = 1
								else
									local decayDistance = objDist - self.MaxIntensityDistance
									intensity = 1 - decayDistance / decay
								end
								
								intensity = math.min((intensity + 0.25) * dotToGeneralDirection, 1)
								local duration = intensity * self.FlashDuration
								
								net.Start("CW_FLASHBANGED_NET")
									net.WriteFloat(intensity)
									net.WriteFloat(duration)
								net.Send(obj)
							end
						end
					end
				end
			end
			
			self:Remove()
		end
	end)
end