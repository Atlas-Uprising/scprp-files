local tab = {}
tab.name = "TAB_CUSTOMIZATION"
tab.id = 1
tab.text = "CUSTOMIZATION"
tab.switchToKey = "gm_showhelp"

local descriptionGrey = Color(167, 167, 167)

if CLIENT then
	function tab:processKey(b, p)
		if self:processSlotKeyPress(b, p) then
			return true
		end
		
		return nil
	end
	
	local emptyString = ""
	local hud16 = "CW_HUD32"
	local hud18 = "CW_HUD38"
	local hud20 = "CW_HUD40"
	local hud36 = "CW_HUD48"
	local hud24 = "CW_HUD48"

	local greyGradient = surface.GetTextureID("cw2/gui/greygrad")
	local gradient = surface.GetTextureID("cw2/gui/gradient")
	local bgQuad = surface.GetTextureID("cw2/gui/attachment_bg_quad")
	
	tab.bgColor = Color(30, 31, 45, 250)
	tab.activeColor = Color(244, 132, 132, 200)
	
	function tab:drawFunc()
		local bgR, bgG, bgB = tab.bgColor.r, tab.bgColor.g, tab.bgColor.b
		
		for k, v in pairs(self.Attachments) do
			local meetsReqs = false
			
			-- check whether the current attachment category matches requirements for attaching
			meetsReqs = self:isCategoryEligible(v.dependencies, v.exclusions)
			
			if meetsReqs then
				self.HUDColors.white.a = 255 * self.CustomizeMenuAlpha
				self.HUDColors.black.a = 255 * self.CustomizeMenuAlpha
				
				-- first index of 'offset' table is X, second is Y
				local x, y = v.offset[1], v.offset[2]
				
				-- draw header and header gradient
				surface.SetDrawColor(bgR, bgG, bgB, 255 * self.CustomizeMenuAlpha)
				
				surface.SetTexture(gradient)
				surface.DrawTexturedRect(x - 3, y - 20, 200, 55)
				
				local found = emptyString
				local name = v.atts[v.last]
				local curAtt = CustomizableWeaponry.registeredAttachmentsSKey[name]
				
				if v.last then
					if curAtt then
						if curAtt.colorType then
							found = CustomizableWeaponry.colorableParts.colorText[curAtt.colorType]
						else
							if curAtt.isGrenadeLauncher then
								found = CustomizableWeaponry.grenadeTypes.cycleText
							end
						end
					end
				end
				
				draw.ShadowText(v.keyText .. v.header .. found, hud36, x, y + 6, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				
				local curPos = 0
			
				for k2, v2 in ipairs(v.atts) do
					if self:isAttachmentEligible(v2) then -- todo: change this part to properly support callbacks and shit
						-- do another attachment eligibility check in here, because there might be some callbacks we want to call
						
						-- if the current attachment is the current iteration, draw stuff
						local foundAtt = CustomizableWeaponry.registeredAttachmentsSKey[v2]
						local baseXPos = x + curPos * 140
						
						if foundAtt then
							-- draw short display name along with it's icon
							draw.ShadowText(foundAtt.displayNameShort, hud16, baseXPos, y + 180, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							
							--surface.SetDrawColor(bgR, bgG, bgB, 200 * self.CustomizeMenuAlpha)
							--surface.DrawOutlinedRect(baseXPos - 3, y + 50 - 3, 120, 120)
							--surface.DrawOutlinedRect(baseXPos - 2, y + 50 - 2, 118, 118)
							surface.SetTexture(bgQuad)
							local clr
							
							-- give the outline a different color if it's the current attachment
							if v.last == k2 then
								clr = tab.activeColor
								--surface.SetDrawColor(acR, acG, acB, acA * self.CustomizeMenuAlpha)
							else
								clr = tab.bgColor
								--[[if self:canAttachSpecificAttachment(v2, self.Owner, nil, nil, nil, categoryData) then
									surface.SetDrawColor(bgR, bgG, bgB, 200 * self.CustomizeMenuAlpha)
								else
									surface.SetDrawColor(255, 175, 175, 150 * self.CustomizeMenuAlpha)
								end]]
							end
							
							--draw.RoundedBoxEx(16, baseXPos - 3, y + 50 - 6, 120, 120, tab.bgColor, true, true, true, true)
							--draw.RoundedBoxEx(16, baseXPos, y + 50 - 3, 120, 120, clr, true, true, true, true)
							surface.SetDrawColor(tab.bgColor)
							surface.DrawTexturedRect(baseXPos - 6, y + 50 - 9, 120, 120)
							
							local prevA = clr.a
							clr.a = clr.a * self.CustomizeMenuAlpha
							surface.SetDrawColor(clr)
							clr.a = prevA
							surface.DrawTexturedRect(baseXPos, y + 50 - 3, 120, 120)
							
							--surface.DrawRect(baseXPos - 1, y + 50 - 1, 116, 116)
							
							surface.SetDrawColor(255, 255, 255, 255 * self.CustomizeMenuAlpha)
							
							surface.SetTexture(foundAtt.displayIcon)
							surface.DrawTexturedRect(baseXPos + 1, y + 50 - 1, 116, 116)
							
							-- draw the reticle/beam color icon
							if foundAtt.colorType then
								local colorEntry = self.SightColors[foundAtt.name]
								
								if colorEntry then
									colorEntry = colorEntry.color
									
									if v.last == k2 then
										surface.SetTexture(bgQuad)
									
										local prevA = tab.bgColor.a
										tab.bgColor.a = tab.bgColor.a * self.CustomizeMenuAlpha
										
										surface.SetDrawColor(tab.bgColor)
										tab.bgColor.a = prevA
										surface.DrawTexturedRect(baseXPos + 1, y + 50, 38, 38)
										
										--draw.RoundedBoxEx(16, baseXPos + 1, y + 50, 38, 38, tab.bgColor, true, true, true, true)
										--[[surface.SetDrawColor(bgR, bgG, bgB, 255 * self.CustomizeMenuAlpha)
										surface.DrawOutlinedRect(baseXPos + 1, y + 50, 38, 38)
										
										surface.SetDrawColor(bgR, bgG, bgB, 230 * self.CustomizeMenuAlpha)
										surface.DrawRect(baseXPos + 2, y + 51, 36, 36)]]
									end
									
									surface.SetDrawColor(colorEntry.r, colorEntry.g, colorEntry.b, 255 * self.CustomizeMenuAlpha)
									surface.SetTexture(foundAtt._reticleIcon)
									surface.DrawTexturedRect(baseXPos + 3, y + 51, 35, 35)
								end
							end
							
							if v.last == k2 then
								-- adjust gradient size to description line amount
								found = emptyString
								
								if self.SightColors[foundAtt.name] then
									found = self.SightColors[foundAtt.name].display
								else
									if curAtt then
										found = CustomizableWeaponry.formAdditionalText(self, curAtt)
									end
								end
								
								local size = #foundAtt.description
								surface.SetDrawColor(bgR, bgG, bgB, 200 * self.CustomizeMenuAlpha)
								surface.SetTexture(gradient)
								surface.DrawTexturedRect(x - 3, y + 200 - 3, 300, size * 30 + 50)
								
								for k3, v3 in ipairs(foundAtt.description) do
									local isDescription = false
									if k3 == 1 and string.sub(v3.t, 1, 1) ~= "+" and string.sub(v3.t, 1, 1) ~= "-" then
										isDescription = true
									end
									draw.ShadowText(isDescription and "| " .. v3.t or v3.t, hud18, x + 5, y + 210 - 3 + k3 * 30 + 17, isDescription and descriptionGrey or v3.c, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
								end
								
								-- draw display name
								draw.ShadowText(foundAtt.displayName .. found, hud20, x, y + 218, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
							end
							
							curPos = curPos + 1
						else
							cam.IgnoreZ(false)
							cam.End3D2D()
							error("CW 2.0 - attempt to display non-existent weapon attachment '" .. v2 .. "' in category index '" .. k .. "' of weapon '" .. self:GetClass() .. "' AKA '" .. self.PrintName .. "'")
						end
					end
				end
			end
		end
		
		if self.Trivia then
			local text = self.Trivia.text
			
			if self.Trivia.textFormatFunc then
				text = self.Trivia:textFormatFunc(self)
			end
			
			if text then
				draw.ShadowText(text, hud36, self.Trivia.x, self.Trivia.y, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
	end
end

CustomizableWeaponry.interactionMenu:addTab(tab)