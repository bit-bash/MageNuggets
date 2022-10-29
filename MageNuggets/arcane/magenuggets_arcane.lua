function MageNuggetsMB_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
      local name, _, _, _, _, _, _ = GetSpellInfo(79683);
      local mbCooldown = 0;
      local expirationTime = nil;

      for i = 1, 50 do
        local spellName, _, mbCount, _, duration, expireTime = UnitBuff("player", i);
        if (spellName == name) then
          expirationTime = expireTime;
        end
      end

      if(expirationTime ~= nil) then
        mbCooldown = RoundOne(expirationTime - GetTime());
      end

      if(mbCount == nil)then
        mbCount = 0;
      end

      if (mbCooldown <= 0) and (previewMnFrames == false) then
        MageNugMBProcFrame:Hide()
        MageNugMBProcFrame_ProcBar:SetValue(14)
      end

      MageNugMBProcFrame_CountText:SetText(mbCount);
      MageNugMBProcFrame_ProcBar:SetValue(mbCooldown)
      MageNugMBProcFrameText2:SetText(mbCooldown)
      local position = (MageNugMBProcFrame_ProcBar:GetValue() / 20 * 120);
      MageNugMBProcFrame_ProcBarSpark:SetPoint("BOTTOMLEFT",MageNugMBProcFrame_ProcBar,"BOTTOMLEFT",position - 10,-6);
      self.TimeSinceLastUpdate = 0;
    end
end


-- Arcane Charge Counter
local abTimeoutCounter = 0;
local soundPlayed = false;
function MageNuggetsAB_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        local name, _, _, castTime, _, _, _, _, _ = GetSpellInfo(30451);

        local arcanePowerCharges = Enum.PowerType.ArcaneCharges;
        local stackCount = UnitPower("player", arcanePowerCharges);
        MNabCast_FrameText:SetText(RoundThree(castTime * 0.001))
        MageNugAB_FrameText:SetText("|cffFF00FF"..stackCount)
        abTimeoutCounter = abTimeoutCounter + 1;

        if(stackCount > 0) then
          abTimeoutCounter = 0;
        end

        if(stackCount == 0) then
          soundPlayed = false;
        end

        if (MageNuggets.ABSoundToggle == true) and (stackCount == 4) and (soundPlayed == false) then
          soundPlayed = true;
          PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNuggets.ABSound2);
        end

        if (abTimeoutCounter > 200) then
          abTimeoutCounter = 0;
          MageNugAB_Frame:Hide();
        end
    self.TimeSinceLastUpdate = 0;
    end
end
