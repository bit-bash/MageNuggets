function MageNuggetsFoF_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local name, _, _, _, _, _, _ = GetSpellInfo(44544);
      local fofCooldown = 0;
      local fofCount= 0;
      local expirationTime = nil;

      for i = 1, 50 do
        local spellName, _, count, _, duration, expireTime = UnitBuff("player", i);
        if (spellName == name) then
          expirationTime = expireTime;
          fofCount = count;
        end
      end

      if(expirationTime ~= nil) then
        fofCooldown = RoundOne(expirationTime - GetTime());
      end

      if(fofCount == nil)then
        fofCount = 0;
      end

      if (fofCooldown <= 0) and (previewMnFrames == false) then
        MageNugFoFProcFrame:Hide();
        MageNugFoFProcFrame_ProcBar:SetValue(14);
      end

      MageNugFoFProcFrameCountText:SetText("|cffffffff"..fofCount);
      MageNugFoFProcFrame_ProcBar:SetValue(fofCooldown);
      MageNugFoFProcFrameText2:SetText(fofCooldown);
      local position = (MageNugFoFProcFrame_ProcBar:GetValue() / 14 * 120);
      MageNugFoFProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugFoFProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
      self.TimeSinceLastUpdate = 0;
    end
end

function MageNuggetsBF_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local name, _, _, _, _, _, _ = GetSpellInfo(190446);
      local bfCooldown = 0;
      local bfCount = 0;
      local expirationTime = nil;

      for i = 1, 50 do
        local spellName, _, count, _, duration, expireTime = UnitBuff("player", i);
        if (spellName == name) then
          expirationTime = expireTime;
          bfCount = count;
        end
      end

      if(expirationTime ~= nil) then
        bfCooldown = RoundOne(expirationTime - GetTime());
      end

      if (bfCooldown <= 0) and (previewMnFrames == false) then
        MageNugBFProcFrame:Hide();
        MageNugBFProcFrame_ProcBar:SetValue(15);
      end

      MageNugBFProcFrame_ProcBar:SetValue(bfCooldown);
      MageNugBFProcFrameText2:SetText(bfCooldown);
      local position = (MageNugBFProcFrame_ProcBar:GetValue() / 14 * 120);
      MageNugBFProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugBFProcFrame_ProcBar,"BOTTOMLEFT",position - 10, -6);
      self.TimeSinceLastUpdate = 0;
    end
end

--============================================================================--
--                                  Nova Monitor
--============================================================================--
function isNovaSpeced()
    local specGroup = GetActiveSpecGroup();
    local talentID, name, texture, selected, available = GetTalentInfo(5,3,specGroup);
    return selected;
end

function getNovaTalentId()
    local specGroup = GetActiveSpecGroup();
    local talentID, name, texture, selected, available = GetTalentInfo(5,3,specGroup);
    return talentID;
end

function getNovaCooldown()
    local currentCharges, maxCharges, cooldownStart, cooldownDuration,novaId,cooldown;
    local talentId = getNovaTalentId();

    if(isNovaSpeced())then
        if(talentId == 21693)then -- ice nova
            MageNugNova_FrameTexture:SetTexture("Interface\\Icons\\spell_mage_icenova");
            novaId, _, _, _, _, _, _, _, _ = GetSpellInfo(157997);
            currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(157997)
            cooldown = RoundOne(cooldownStart + cooldownDuration - GetTime())
        elseif(talentId == 19301)then -- supernova
            MageNugNova_FrameTexture:SetTexture("Interface\\Icons\\spell_mage_supernova");
            novaId, _, _, _, _, _, _, _, _ = GetSpellInfo(157980);
            currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(157980)
            cooldown = RoundOne(cooldownStart + cooldownDuration - GetTime())
        elseif(talentId == 21692)then -- blast wave
            MageNugNova_FrameTexture:SetTexture("Interface\\Icons\\spell_holy_excorcism_02");
            novaId, _, _, _, _, _, _, _, _ = GetSpellInfo(157981);
            currentCharges, maxCharges, cooldownStart, cooldownDuration = GetSpellCharges(157981)
            cooldown = RoundOne(cooldownStart + cooldownDuration - GetTime())
        end
        MageNugNova_Frame_Text:SetText(currentCharges);
    end
    return cooldown;
end

function MNNova_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        local cooldown = getNovaCooldown();
        if(cooldown == nil) or (cooldown <= 0) or (cooldown > 25)then
            cooldown = "";
            MageNugNova_Frame_Text2:SetText("");
            MageNugNova_Frame_Bar:SetValue(25);
        else
            MageNugNova_Frame_Text2:SetText(cooldown);
            MageNugNova_Frame_Bar:SetValue(cooldown);
        end
        self.TimeSinceLastUpdate = 0;
    end
end
