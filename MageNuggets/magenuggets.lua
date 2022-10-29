--Mage Nuggets by B-Buck (Bbuck of Eredar)

local magenugVer = "7.1.0"
local mirrorImageTime = 0;
local spellStealTog = 0;
local polyTimer = 0;
local moonfireTime = 0;
local insectTime = 0;
local starsurgeTime = 0;
local moonkinCombatText = 0;
local incombat = 0;
local mnplayerClass = " "
local mnenglishClass = " "
local sstimeleft = 0;
local cauterizeTime = 0;
local _, class _, class = UnitClass("player")
local mnplayerClass, mnenglishClass = UnitClass("player");

function mageNuggets_OnStart(self)
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    self:RegisterEvent("PLAYER_LOGOUT")
end

local MN_UpdateInterval = 0.25;
local previewFramesCounter = 0;
previewMnFrames = false;
function MageNuggets_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > MN_UpdateInterval) then

   if(previewFrames == true) then
     previewFramesCounter = previewFramesCounter + 1;
     if(previewFramesCounter > 300)then
       previewFramesCounter = 0;
       previewFrames = false;
     end
   end

    --SpellSteal
    if (spellStealTog >= 1) then
        spellStealTog = spellStealTog - 1;
    else
        if (MageNuggets.ssMonitorToggle == true) then
            if(mnenglishClass == 'MAGE')then
                local stealableBuffs, i = { }, 1;
                local buffName, a2, a3, a4, a5, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                while buffName do
                    if(isStealable == true) then
                        if(expirationTime ~= nil)then
                            sstimeleft = RoundZero(expirationTime - GetTime());
                            if (sstimeleft > 60) then
                                sstimeleft = "+60";
                            end
                        end

                        stealableBuffs[#stealableBuffs + 1] = buffName.."  "..sstimeleft.."s";
                    end
                    i = i + 1;
                    buffName, _, _, _, _, expirationTime, _, isStealable = UnitAura("target", i, "HELPFUL");
                end
                if (#stealableBuffs < 1) and (previewMnFrames == false)then
                    MNSpellSteal_Frame:Hide();
                else
                    MNSpellSteal_Frame:Show();
                    stealableBuffs = table.concat(stealableBuffs, "\n");
                    MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs);
                end
                local stealableBuffs2, i = { }, 1;
                local buffName2, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                while buffName2 do
                    if(isStealable2 == true) then
                        if(expirationTime2 ~= nil)then
                            sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                            if (sstimeleft2 > 60) then
                                 sstimeleft2 = "+60";
                           end
                        end
                        stealableBuffs2[#stealableBuffs2 + 1] = buffName2.."  "..sstimeleft2.."s";
                    end
                    i = i + 1;
                    buffName2, _, _, _, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                end
                if (#stealableBuffs2 < 1)  and (previewMnFrames == false) then
                    MNSpellStealFocus_Frame:Hide();
                else
                    MNSpellStealFocus_Frame:Show();
                  stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                    MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs2);
                end
            elseif(mnenglishClass == 'SHAMAN')then
                if(UnitCanAttack("player", "target"))then
                    local purgeableBuffs, i = { }, 1;
                    local buffName1, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    while buffName1 do
                        if(debuffType1 == "Magic") then
                            purgeableBuffs[#purgeableBuffs + 1] = buffName1;
                        end
                        i = i + 1;
                        buffName1, _, _, debuffType1, _, expirationTime1, _, _ = UnitAura("target", i, "HELPFUL");
                    end
                    if (#purgeableBuffs < 1) then
                        MNSpellSteal_Frame:Hide();
                    else
                        MNSpellSteal_Frame:Show();
                        purgeableBuffs = table.concat(purgeableBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..purgeableBuffs);
                    end
                else
                    MNSpellSteal_Frame:Hide();
                end
                local stealableBuffs2, i = { }, 1;
                local buffName2, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                while buffName2 do
                    if(debuffTypep == "Magic") then
                        if(expirationTime2 ~= nil)then
                            sstimeleft2 = RoundZero(expirationTime2 - GetTime());
                            if (sstimeleft2 > 60) then
                                 sstimeleft2 = "+60";
                           end
                        end
                        stealableBuffs2[#stealableBuffs2 + 1] = buffName2.."  "..sstimeleft2.."s";
                    end
                    i = i + 1;
                    buffName2, _, _, debuffTypep, _, expirationTime2, _, isStealable2 = UnitAura("focus", i, "HELPFUL");
                end
                if (#stealableBuffs2 < 1) then
                    MNSpellStealFocus_Frame:Hide();
                else
                    MNSpellStealFocus_Frame:Show();
                    stealableBuffs2 = table.concat(stealableBuffs2, "\n");
                    MNSpellStealFocus_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs2);
                end
            elseif(mnenglishClass == 'PRIEST')then
                if(UnitCanAttack("player", "target"))then
                    local dispelBuffs, i = { }, 1;
                    local buffName2, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                    while buffName2 do
                        if(debuffType2 == "Magic") then
                            dispelBuffs[#dispelBuffs + 1] = buffName2;
                        end
                        i = i + 1;
                        buffName2, _, _, debuffType2, _, expirationTime2, _, _ = UnitAura("target", i, "HELPFUL");
                    end
                    if (#dispelBuffs < 1) then
                        MNSpellSteal_Frame:Hide();
                    else
                        MNSpellSteal_Frame:Show();
                        dispelBuffs = table.concat(dispelBuffs, "\n");
                        MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..dispelBuffs);
                    end
                else
                    MNSpellSteal_Frame:Hide();
                end
            end
        end
    end
  self.TimeSinceLastUpdate = 0;
  end
end

--============================================================================--
--                                  On Update
--============================================================================--


function MageNuggetsMI_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (mirrorImageTime >= 0) then
            mirrorImageTime = mirrorImageTime - 1.0;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            if (mirrorImageTime <= 0) then
                MageNugMI_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

function MageNuggetsCauterize_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (cauterizeTime >= 0) then
            cauterizeTime = cauterizeTime - 1.0;
            MageNugCauterize_Frame_Text1:SetText(" "..cauterizeTime)
            MageNugCauterize_Frame_Bar:SetValue(cauterizeTime)
            if (cauterizeTime <= 0) then
                MageNugCauterize_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

function MageNuggetsPoly_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 1.0) then
        if (polyTimer >= 0) then
            polyTimer = RoundZero(polyTimer - 1.0);
            MageNugPolyFrameTimerText:SetText(polyTimer);
            MageNugPolyFrame_Bar:SetValue(polyTimer);
            if(polyTimer <= 0) then
                MageNugPolyFrame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end
end

local mnCombatTextSize = 0;
function MageNuggetsCombatText_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      mnCombatTextSize = mnCombatTextSize + 1;
      MageNugCombatText_Frame_Text:SetTextHeight(32);

      if(mnCombatTextSize > 10)then
        mnCombatTextSize = 0;
        MageNugCombatText_Frame_Text:SetText("")
      end

      self.TimeSinceLastUpdate = 0;
    end
end

--============================================================================--
--                                  On Event
--============================================================================--

function MageNuggets_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggets") then
            loadMageNuggetVariables_OnLoadEvent();
        end
    elseif (event == "ACTIVE_TALENT_GROUP_CHANGED") then
        MageNugIgnite_Frame:Hide();
        if(mnenglishClass == 'DRUID') then
            currentSpec = GetSpecialization();
            if(currentSpec ~= 1) then
                MageNugMoonkinOptionFrame_CheckButton:SetChecked(true);
                MageNuggets.moonkinTog = true;
                MageNugMoonkin_Frame:Hide()
                MNmoonFire_Frame:Hide()
                MNinsectSwarm_Frame:Hide()
                MNstarSurge_Frame:Hide()
            else
                if(MageNuggets.moonkinBoxTog == true)then
                    if(MageNuggets.moonkinTog == true) then
                        MageNugMoonkinToggle_Frame:Show();
                    end
                end
            end
        end
    elseif (event == "PLAYER_LOGOUT") then
        MageNugz_SaveFrame_Position();
    elseif (event == "PLAYER_REGEN_ENABLED") then
        incombat = 0;
        MageNugNova_Frame:Hide();
        if (MageNuggets.moonkinTog == false) then
            if (MageNuggets.moonkinCombat == true) then
                MageNugMoonkin_Frame:Hide();
                MNmoonFire_Frame:Hide();
                MNinsectSwarm_Frame:Hide();
                MNstarSurge_Frame:Hide();
            end
        end
    elseif (event == "PLAYER_REGEN_DISABLED") then
        incombat = 1;
        if(mnenglishClass == 'MAGE') and (MageNuggets.novaMonitorToggle == true) and (isNovaSpeced())then
            MageNugNova_Frame:Show();
        end

        if (MageNuggets.moonkinTog == false) then
            if (MageNuggets.moonkinCombat == true) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show()
                MNinsectSwarm_Frame:Show()
                MNstarSurge_Frame:Show()
            end
        end
    elseif (event == "PLAYER_ENTERING_WORLD") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
        MageNugz_SetFrame_Positions();
        MageNugz_SaveFrame_Position();
    elseif (event == "PLAYER_UPDATE_RESTING") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED")then
        local timestamp, event1, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName = CombatLogGetCurrentEventInfo()
        local arg, spellName, spellSchool, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = select(12, CombatLogGetCurrentEventInfo())

        -- DEBUGGING
        --if((sourceName == UnitName("player")) or (destName == UnitName("player"))) then
          --DEFAULT_CHAT_FRAME:AddMessage(arg.." "..event1.." "..spellName);
        --end

       if (event1 == "SPELL_DISPEL") and (sourceName == UnitName("player")) then
            if (MageNuggets.ssMonitorToggle == true) then
              mnCombatTextSize = 0;
              MageNugCombatText_Frame_Text:SetTextColor(0.1,0,1,1);
              MageNugCombatText_Frame_Text:SetText("Dispelled: "..GetSpellLink(arg5));
              if (MageNuggets.consoleTextEnabled == true) then
                  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Dispelled "..GetSpellLink(arg5).." From "..destName)
    	        end
            end
       elseif (event1 == "SPELL_AURA_APPLIED_DOSE") and (sourceName == UnitName("player")) then
         if(arg == 44544) then --Fingers of Frost
           if (MageNuggets.mageProcToggle == true) then
               mnCombatTextSize = 0;
               MageNugCombatText_Frame_Text:SetTextColor(1,1,1,1);
               MageNugCombatText_Frame_Text:SetText("FINGERS OF FROST");
           end
           if (MageNuggets.fofSoundToggle == true) then
              PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.fofSound2)
           end
         elseif(arg == 79683) then -- Arcane Missiles!
           if (MageNuggets.mageProcToggle == true) then
             mnCombatTextSize = 0;
             MageNugCombatText_Frame_Text:SetTextColor(0.6,0,0.6,1);
             MageNugCombatText_Frame_Text:SetText("ARCANE MISSILES!");
           end
           if (MageNuggets.procSoundToggle == true) then
             PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.procSound2)
           end
         end
       elseif (event1 == "SPELL_AURA_REFRESH") and (sourceName == UnitName("player")) then
            spellAuraRefresh(arg, sourceName, destName);
       elseif (event1 == "SPELL_AURA_REMOVED") and (sourceName == UnitName("player")) then
            spellAuraRemoved(arg, sourceName, destName);
       elseif (event1 == "SPELL_AURA_APPLIED") and (sourceName == UnitName("player")) then
            spellAuraAppliedSource(arg, sourceName, destName);
		   elseif (event1 == "SPELL_AURA_APPLIED") and (destName == UnitName("player")) then
            spellAuraAppliedDest(arg, sourceName, destName);
		   elseif (event1 == "SPELL_CAST_SUCCESS") and (sourceName == UnitName("player")) then
          if (((arg == 30451) or (arg == 1449) or (arg ==7268)) and (MageNuggets.arcaneBlastToggle == true)) then
            local currentMageSpec = GetSpecialization();
            if (currentMageSpec == 1) then
              MageNugAB_Frame:Show();
            end
          elseif(arg == 108853) then
            if(MageNuggets.igniteTog == true)then
              mnFireblastHideCounter = 0;
              local currentFbCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(108853)
              MageNugIgnite_TextFrameFlameBlastText:SetText(currentFbCharges);
              MageNugIgnite_TextFrameFlameBlastText2:SetText(11);
              MageNugIgnite_Frame:Show();
            end
          end
       elseif (event1 == "SPELL_STOLEN") and (sourceName == UnitName("player")) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.1,0,1,1);
            MageNugCombatText_Frame_Text:SetText("Stole: "..GetSpellLink(arg5));
            if (MageNuggets.consoleTextEnabled == true) then
               DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF".."Spell Stolen"..":"..GetSpellLink(arg5).."From "..destName)
    	    end
        end
     end
end


--============================================================================--
--                      Spell Aura Removed
--============================================================================--

function spellAuraRemoved(arg, sourceName, destName)
    if (arg == 48107) then -- heating up
        MageNugProcHUFrame:Hide();
    elseif(arg == 190446) then
        MageNugBFProcFrame:Hide()
    elseif(arg == 44544) then
        MageNugFoFProcFrame:Hide()
    elseif(arg == 79683) then
        MageNugMBProcFrame:Hide();
    elseif(arg == 48108) then
        MageNugProcFrame:Hide();
    elseif(arg == 87023) then
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.9,0,0,1);
            MageNugCombatText_Frame_Text:SetText("EXTINGUISHED");
        end
        if (MageNuggets.cauterizeToggle == true) then
            MageNugCauterizeFrame:Hide();
        end
    end

    if (MageNuggets.polyToggle == true) then
        if (arg == 9484) then -- shackle
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Shackle Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Shackle Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 115078) then --paralysis
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Paralysis Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Paralysis Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 2637) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Hibernate Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Hibernate Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 76780) then -- bind elemental
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Bind Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Bind Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 51514) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Hex Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Hex Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 28272) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Pig) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 118) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Sheep) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 28271) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Turtle) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 61721) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Rabbit) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 61305) then
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Black Cat) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 126819) then --porcupine
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Porcupine) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        elseif (arg == 161354) then --monkey
            MageNugPolyFrame:Hide();
            polyTimer = 0;
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.2,1,1);
            MageNugCombatText_Frame_Text:SetText("Polymorph Broken");
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Polymorph(Monkey) Broken On"..":|cffFFFFFF "..destName);
            end
            if (MageNuggets.polySoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.polySound2)
            end
        end
    end
end

--============================================================================--
--                      Spell Aura Refresh
--============================================================================--
function spellAuraRefresh(arg, sourceName, destName)
    if(arg == 48108) then -- hot streak
        if(MageNuggets.procMonitorToggle == true) then
            MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!")
            MageNugProcFrame_ProcBar:SetValue(14)
            MageNugProcFrame:Show()
        end
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.10,0,1);
            MageNugCombatText_Frame_Text:SetText("HOT STREAK!");
        end
        if (MageNuggets.hsSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.hsSound2)
        end
    end

    if (MageNuggets.polyToggle == true) then
        if (arg == 115078) then -- Paralysis
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 115078, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Paralysis "..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
                MageNugPolyFrame:Show();
            else
                polyTimer = 40;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Paralysis "..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 9484) then -- shackle
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 9484, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Shackle "..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Shackle "..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 2637) then -- hibernate
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 2637, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                MageNugPolyFrame:Show();
            else
                polyTimer = 40;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 51514) then -- hex
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 51514, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hex"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                MageNugPolyFrame:Show();
            else
                polyTimer = 60;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hex"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 28272) then -- pig
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 28272, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 61305) then -- cat
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 61305, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 61721) then -- rabbit
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 61721, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 28271) then -- turtle
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 28271, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 126819) then -- porcupine
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 126819, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 161354) then -- monkey
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 161354, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 118)  then  --sheep
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 118, "PLAYER|HARMFUL");
            if(polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                MageNugPolyFrame:Show();
            end
        end
    end
end
--============================================================================--
--                      Spell Aura Applied Dest
--============================================================================--

function spellAuraAppliedDest(arg, sourceName, destName)
    if(arg == 80353) then -- Time Warp
        if (MageNuggets.timewarpSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.timewarpSound2) --lawl
        end
        if sourceName ~= UnitName("player") then
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Time Warp used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("Time Warp! - "..sourceName);
        end
    elseif(arg == 102351) then -- drums of rage
        if sourceName ~= UnitName("player") then
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Drums of Rage used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("Drums of Rage! - "..sourceName);
        end
    elseif (arg == 2825) then --bloodlust
        if sourceName ~= UnitName("player") then
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Blood Lust used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("BLOOD LUST! - "..sourceName);
        end
    elseif (arg == 32182) then
        if sourceName ~= UnitName("player") then
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Heroism used by"..":|cff0000FF "..sourceName);
            end
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0,1);
            MageNugCombatText_Frame_Text:SetText("HEROISM! - "..sourceName);
        end
    end
end

--============================================================================--
--                      Spell Aura Applied Source
--============================================================================--

function spellAuraAppliedSource(arg, sourceName, destName)
    if (arg == 48107) then -- heating up!
        if(MageNuggets.procMonitorToggle == true) then
            MageNugProcHUFrameText:SetText("|cffFFCC00".."HEATING UP!")
            MageNugProcHUFrame_ProcBar:SetValue(9.6)
            MageNugProcHUFrame:Show();
        end
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
            MageNugCombatText_Frame_Text:SetText("HEATING UP");
        end
        if (MageNuggets.impactSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.impactSound2)
        end
    elseif(arg == 80353) then -- time warp
        if (MageNuggets.timewarpSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.timewarpSound2) --lawl
        end
        if sourceName ~= UnitName("player") then
            if (MageNuggets.consoleTextEnabled == true) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000".."Time Warp used by"..":|cff0000FF "..sourceName);
            end
            if (MageNuggets.mageProcToggle == true) then
                mnCombatTextSize = 0;
                MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
                MageNugCombatText_Frame_Text:SetText("Time Warp! - "..sourceName);
            end
        end
    elseif (arg == 29166) then
        if (destName ~= UnitName("player")) then
            if (MageNuggets.msgToggle == true) then
                SendChatMessage(MageNuggets.innervatNotify, "WHISPER", nil, destName);
            end
        end
    elseif(arg == 93400) then -- Shooting Stars
        if (MageNuggets.moonkinCombatText == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.8,0,1);
            MageNugCombatText_Frame_Text:SetText("Shooting Stars - "..sourceName);
        end
        if (MageNuggets.procSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.procSound2)
        end
    elseif(arg == 79683) then -- Arcane Missiles!
        if(MageNuggets.procMonitorToggle == true) then
            MageNugMBProcFrameText:SetText("|cffFF33FF".."ARCANE MISSILES!");
            MageNugMBProcFrame_ProcBar:SetValue(20);
            MageNugMBProcFrame:Show();
        end
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.6,0,0.6,1);
            MageNugCombatText_Frame_Text:SetText("ARCANE MISSILES!");
        end
        if (MageNuggets.procSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.procSound2)
        end
    elseif(arg == 87023) then -- cauterize
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(0.9,0,0,1);
            MageNugCombatText_Frame_Text:SetText("!! CAUTERIZE !!");
        end
        if (MageNuggets.cauterizeToggle == true) then
            MageNugCauterizeFrame:Show();
            cauterizeTime = 120;
            MageNugCauterize_Frame:Show();
        end
        if (MageNuggets.cauterizeSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.cauterizeSound2)
        end
    elseif(arg == 48108) then --Hot Streak!
        if(MageNuggets.procMonitorToggle == true) then
            MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!");
            MageNugProcFrame_ProcBar:SetValue(14);
            MageNugProcFrame:Show();
        end
        if (MageNuggets.mageProcToggle == true) then
          mnCombatTextSize = 0;
          MageNugCombatText_Frame_Text:SetTextColor(1,0.10,0,1);
          MageNugCombatText_Frame_Text:SetText("HOT STREAK!");
        end
        if (MageNuggets.hsSoundToggle == true) then
            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.hsSound2);
        end
    elseif(arg == 190446) then --Brain Freeze
        if(MageNuggets.procMonitorToggle == true) then
            MageNugBFProcFrameText:SetText("|cffFFFFFF".."BRAIN FREEZE!");
            MageNugBFProcFrame_ProcBar:SetValue(14);
            MageNugBFProcFrame:Show();
        end
        if (MageNuggets.mageProcToggle == true) then
            mnCombatTextSize = 0;
            MageNugCombatText_Frame_Text:SetTextColor(1,0.1,0.1,1);
            MageNugCombatText_Frame_Text:SetText("BRAIN FREEZE");
        end
        if (MageNuggets.brainfreezeSoundToggle == true) then
          PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.brainfreezeSound2)
        end
    elseif(arg == 44544) then --Fingers of Frost
        if(MageNuggets.procMonitorToggle == true) then
            MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
            MageNugFoFProcFrame_ProcBar:SetValue(14)
            MageNugFoFProcFrame:Show()
        end
        if (MageNuggets.mageProcToggle == true) then
          mnCombatTextSize = 0;
          MageNugCombatText_Frame_Text:SetTextColor(1,1,1,1);
          MageNugCombatText_Frame_Text:SetText("FINGERS OF FROST");
        end
        if (MageNuggets.fofSoundToggle == true) then
          PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.fofSound2)
        end
    elseif (arg == 55342) then -- mirror image
        if (MageNuggets.mirrorImageToggle == true) then
            if (MageNuggets.miSoundToggle == true) then
                PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.miSound2)
            end
            mirrorImageTime = 40;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            MageNugMI_Frame:Show();
        end
    elseif (arg == 10060) then
        if (destName ~= UnitName("player")) then
            if (MageNuggets.powerInfToggle == true) then
                SendChatMessage(MageNuggets.powerinfNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 33206) then
        if (destName ~= UnitName("player")) then
            if (MageNuggets.painSupToggle == true) then
                SendChatMessage(MageNuggets.painSupNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 47788) then
        if (destName ~= UnitName("player")) then
            if (MageNuggets.gspiritToggle == true) then
                SendChatMessage(MageNuggets.gspiritNotify, "WHISPER", nil, destName);
            end
        end
    elseif (arg == 130) then
        if (destName ~= UnitName("player")) then
            if (MageNuggets.msgToggle == true) then
                local sfRandomNum = math.random(1,3)
                if(sfRandomNum == 1) then
                    SendChatMessage(MageNuggets.slowfallMsg, "WHISPER", nil, destName);
                end
                if(sfRandomNum == 2) then
                    SendChatMessage(MageNuggets.slowfallMsg2, "WHISPER", nil, destName);
                end
                if(sfRandomNum == 3) then
                    SendChatMessage(MageNuggets.slowfallMsg3, "WHISPER", nil, destName);
                end
            end
        end
    elseif (MageNuggets.polyToggle == true) then
        if (arg == 9484) then -- shackle
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 9484, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Shackle"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Shackle"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_slow");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 2637) then -- hibernate
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 2637, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                MageNugPolyFrame:Show();
            else
                polyTimer = 40;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Hibernate"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_nature_sleep");
                MageNugPolyFrame:Show();
            end

        elseif (arg == 76780) then -- bind elemental
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 76780, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Bind"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_bindelemental");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Bind"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_bindelemental");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 115078) then -- paralysis
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 115078, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Paralysis"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Paralysis"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_monk_paralysis");
                MageNugPolyFrame:Show();
            end

        elseif (arg == 51514) then -- HEX
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 51514, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."HEX"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                MageNugPolyFrame:Show();
            else
                polyTimer = 60;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."HEX"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\spell_shaman_hex");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 28272) then -- pig
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 28272, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphpig");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 61305) then -- cat
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 61305, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Achievement_halloween_cat_01");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 61721) then -- rabbit
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 61721, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_magic_polymorphrabbit");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 28271) then -- turtle
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 28271, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Ability_hunter_pet_turtle");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 126819) then -- porcupine
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 126819, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\inv_pet_porcupine");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 161354) then -- monkey
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 161354, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\ability_hunter_aspectofthemonkey");
                MageNugPolyFrame:Show();
            end
        elseif (arg == 118)  then  --sheep
            _, _, _, _, _, polyExpTime, unitCaster, _, _, _ = findUnitAura("target", 118, "PLAYER|HARMFUL");
            if (polyExpTime ~= nil) then
                polyTimer = RoundZero(polyExpTime - GetTime());
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                MageNugPolyFrame:Show();
            else
                polyTimer = 50;
                MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph"..":\n|cffFFFFFF "..destName);
                MageNugPolyFrameTimerText:SetText(polyTimer);
                MageNugPolyFrame_Bar:SetMinMaxValues(0,polyTimer);
                MageNugPolyFrame_Bar:SetValue(polyTimer);
                MageNugPolyFrameTexture:SetTexture("Interface\\Icons\\Spell_nature_polymorph");
                MageNugPolyFrame:Show();
            end
        end
    end
end

function findUnitAura(unit, spellId, filters)
  for i = 1, 50 do
    local name, icon, count, type, duration, expireTime, unitCaster, canSteal, nameplate, auraSpellId = UnitAura("target", i, filters);
    if (auraSpellId == nil) then
      return nil;
    end
    if spellId == auraSpellId then
      return name, icon, count, type, duration, expireTime, unitCaster, canSteal, nameplate, auraSpellId;
    end
  end
end

function RoundCrit(critNum)
    return math.floor(critNum*math.pow(10,2)+0.5) / math.pow(10,2)
end

function RoundThree(critNum)
    return math.floor(critNum*math.pow(10,3)+0.5) / math.pow(10,3)
end

function RoundOne(inputNum)
    return math.floor(inputNum*math.pow(10,1)+0.5) / math.pow(10,1)
end

function RoundZero(inputNum)
    return math.floor(inputNum*math.pow(10,0)+0.5) / math.pow(10,0)
end
