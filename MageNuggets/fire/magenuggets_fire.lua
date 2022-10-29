
local mnFireblastHideCounter = 0;
local combustCounter = 0;
function MageNuggetsFireblast_OnUpdate(self, elapsed) -- ignite
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local currentFbCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(108853);
      local fbCooldown = RoundOne(cooldownStart + cooldownDuration - GetTime());
      local currentPfCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(194466);
      local pfCooldown = RoundOne(cooldownStart + cooldownDuration - GetTime());
      local combustStart, combustDuration, combustEnable = GetSpellCooldown(190319);
      local combustCooldown = RoundOne(combustStart + combustDuration - GetTime());

      if(combustCooldown == nil) then
        mnDressFireblastMonitor(currentFbCharges, fbCooldown, currentPfCharges, pfCooldown, "");
      else
        mnDressFireblastMonitor(currentFbCharges, fbCooldown, currentPfCharges, pfCooldown, combustCooldown);
      end

      MageNugIgnite_FrameCombustionTexture:SetAlpha(1)
      if(combustCooldown <= 10) and (combustCooldown > 0) then
        combustCounter = combustCounter + 1;
        if(combustCounter >= 5) then
          combustCounter = 0;
          MageNugIgnite_FrameCombustionTexture:SetAlpha(0.2)
        end
      end

      if(currentFbCharges == 2) then

        mnFireblastHideCounter = mnFireblastHideCounter + 1;
        if(mnFireblastHideCounter > 250) then
          mnFireblastHideCounter = 0;
          MageNugIgnite_Frame:Hide();
        end

        if(currentFbCharges == 2) and (MageNuggets.FireNuggetNotifyBorderToggle == true)then
          MageNugIgnite_TextFrameTexture:SetTexture('Interface\\UNITPOWERBARALT\\Fire_Circular_Frame');
        else
          MageNugIgnite_TextFrameTexture:SetTexture('');
        end

      else
        MageNugIgnite_TextFrameTexture:SetTexture('');
        mnFireblastBorderColorTick = 0;
        mnFireblastHideCounter = 0;
      end
    self.TimeSinceLastUpdate = 0;
    end
end
--
function mnDressFireblastMonitor(fbCharges, fbTimerValue, pfCharges, pfTimerValue, combustCooldown)
  if(fbTimerValue > 13) or (fbTimerValue < 0) then
    MageNugIgnite_TextFrameFlameBlastText2:SetText("");
  else
    MageNugIgnite_TextFrameFlameBlastText2:SetText(fbTimerValue);
  end
  MageNugIgnite_TextFrameFlameBlastText:SetText(fbCharges);

  if(pfTimerValue > 45) or (pfTimerValue < 0) then
    MageNugIgnite_TextFramePheonixFlamesText2:SetText("");
  else
    MageNugIgnite_TextFramePheonixFlamesText2:SetText(pfTimerValue);
  end
  MageNugIgnite_TextFramePheonixFlamesText:SetText(pfCharges);

  if(combustCooldown > 120) or (combustCooldown < 0) then
    MageNugIgnite_TextFrameCombustionText:SetText("");
  else
    MageNugIgnite_TextFrameCombustionText:SetText(combustCooldown);
  end
end
--
function MageNuggetsHS_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local name, _, _, _, _, _, _ = GetSpellInfo(48108);
      local hsCooldown = 0;
      local expirationTime = nil;

      for i = 1, 50 do
        local spellName, _, _, _, duration, expireTime = UnitBuff("player", i);
        if (spellName == name) then
          expirationTime = expireTime;
        end
      end

      if(expirationTime ~= nil) then
        hsCooldown = RoundOne(expirationTime - GetTime());
      end

      if(hsCooldown <= 0) and (previewMnFrames == false) then
        MageNugProcFrame:Hide();
        MageNugProcFrame_ProcBar:SetValue(15);
      end

      MageNugProcFrame_ProcBar:SetValue(hsCooldown)
      MageNugProcFrameText2:SetText(hsCooldown)
      local position = (MageNugProcFrame_ProcBar:GetValue() / 14 * 120);
      MageNugProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
      self.TimeSinceLastUpdate = 0;
    end
end

function MageNuggetsHU_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local name, _, _, _, _, _, _ = GetSpellInfo(48107);
      local huCooldown = 0;
      local expirationTime = nil;

      for i = 1, 50 do
        local spellName, _, _, _, duration, expireTime = UnitBuff("player", i);
        if (spellName == name) then
          expirationTime = expireTime;
        end
      end

      if(expirationTime ~= nil) then
        huCooldown = RoundOne(expirationTime - GetTime());
      end

      if (huCooldown <= 0) and (previewMnFrames == false) then
        MageNugProcHUFrame:Hide();
        MageNugProcHUFrame_ProcBar:SetValue(8);
      end

      MageNugProcHUFrame_ProcBar:SetValue(huCooldown)
      MageNugProcHUFrameText2:SetText(huCooldown)
      local position = (MageNugProcHUFrame_ProcBar:GetValue() / 8 * 120);
      MageNugProcHUFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugProcHUFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
      self.TimeSinceLastUpdate = 0;
    end
end
