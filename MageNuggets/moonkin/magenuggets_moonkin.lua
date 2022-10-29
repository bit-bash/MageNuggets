----------------------------------------------------------------------------------------
--                              Moonkin                                               --
----------------------------------------------------------------------------------------

function MageNuggetsMoonkin_OnUpdate(self, elapsed)
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        barpower = UnitPower("player", 8);
        local stackCount = "";
        local i = 1;
        local empowered = false;
        local buffName, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
        while buffName do
            if(spellId == 164545) or (spellId == 164547) then
                empowered = true;
                stackCount = count;
            end
            i = i + 1;
            buffName, rank, _, count, _, _, expirationTime, _, _, _, spellId = UnitAura("player", i, "HELPFUL");
        end

        if(empowered == false or stackCount < 1)then
            MageNugMoonkin_Frame_Text2:SetText("")
        else
            MageNugMoonkin_Frame_Text2:SetText(stackCount)
        end

        if(barpower < 0) then
            MageNugMoonkin_Frame_Texture:SetTexture("Interface\\Icons\\spell_arcane_starfire");
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(0, 0, 1)
            if(barpower < 0) then
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFLunar "..(barpower * -1));
            else
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFLunar "..barpower);
            end
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(0, 0, 0.8)
            MageNugMoonkin_Frame_Bar:SetValue(barpower * -1);
        else
            MageNugMoonkin_Frame_Texture:SetTexture("Interface\\Icons\\spell_nature_wrathv2");
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(1, 0.5, 0)
            if(barpower < 0) then
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFSolar "..(barpower * -1));
            else
                MageNugMoonkin_Frame_Text:SetText("|cffFFFFFFSolar "..barpower);
            end
            MageNugMoonkin_Frame_Bar:SetStatusBarColor(1, 0.5, 0)
            MageNugMoonkin_Frame_Bar:SetValue(barpower);
        end
    self.TimeSinceLastUpdate = 0;
    end
end


function MageNugMoonSize()
    local tempInt = MageNugMoonkinOptionFrame_Slider:GetValue()

    if not MageNugMoonkinOptionFrame_Slider._onsetting then
        MageNugMoonkinOptionFrame_Slider._onsetting = true
        MageNugMoonkinOptionFrame_Slider:SetValue(MageNugMoonkinOptionFrame_Slider:GetValue())
        tempInt = MageNugMoonkinOptionFrame_Slider:GetValue()
        MageNugMoonkinOptionFrame_Slider._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugMoonkin_Frame:SetScale(0.7);
        MNmoonFire_Frame:SetScale(0.7);
        MNinsectSwarm_Frame:SetScale(0.7);
        MNstarSurge_Frame:SetScale(0.7);
        MageNuggets.moonkinSize = 0;
    elseif (tempInt == 1) then
       MageNugMoonkin_Frame:SetScale(0.8);
       MNmoonFire_Frame:SetScale(0.8);
       MNinsectSwarm_Frame:SetScale(0.8);
       MNstarSurge_Frame:SetScale(0.8);
       MageNuggets.moonkinSize = 1;
    elseif (tempInt == 2) then
        MageNugMoonkin_Frame:SetScale(0.9);
        MNmoonFire_Frame:SetScale(0.9);
        MNinsectSwarm_Frame:SetScale(0.9);
        MNstarSurge_Frame:SetScale(0.9);
        MageNuggets.moonkinSize = 2;
    elseif (tempInt == 3) then
        MageNugMoonkin_Frame:SetScale(1.0);
        MNmoonFire_Frame:SetScale(1.0);
        MNinsectSwarm_Frame:SetScale(1.0);
        MNstarSurge_Frame:SetScale(1.0);
        MageNuggets.moonkinSize = 3;
    elseif (tempInt == 4) then
        MageNugMoonkin_Frame:SetScale(1.1);
        MNmoonFire_Frame:SetScale(1.1);
        MNinsectSwarm_Frame:SetScale(1.1);
        MNstarSurge_Frame:SetScale(1.1);
        MageNuggets.moonkinSize = 4;
    elseif (tempInt == 5) then
        MageNugMoonkin_Frame:SetScale(1.2);
        MNmoonFire_Frame:SetScale(1.2);
        MNinsectSwarm_Frame:SetScale(1.2);
        MNstarSurge_Frame:SetScale(1.2);
        MageNuggets.moonkinSize = 5;
    elseif (tempInt == 6) then
        MageNugMoonkin_Frame:SetScale(1.4);
        MNmoonFire_Frame:SetScale(1.4);
        MNinsectSwarm_Frame:SetScale(1.4);
        MNstarSurge_Frame:SetScale(1.4);
        MageNuggets.moonkinSize =  6;
    elseif (tempInt == 7) then
        MageNugMoonkin_Frame:SetScale(1.7);
        MNmoonFire_Frame:SetScale(1.7);
        MNinsectSwarm_Frame:SetScale(1.7);
        MNstarSurge_Frame:SetScale(1.7);
        MageNuggets.moonkinSize =  7;
    elseif (tempInt == 8) then
        MageNugMoonkin_Frame:SetScale(2.0);
        MNmoonFire_Frame:SetScale(2.0);
        MNinsectSwarm_Frame:SetScale(2.0);
        MNstarSurge_Frame:SetScale(2.0);
        MageNuggets.moonkinSize =  8;
    elseif (tempInt == 9) then
        MageNugMoonkin_Frame:SetScale(2.2);
        MNmoonFire_Frame:SetScale(2.2);
        MNinsectSwarm_Frame:SetScale(2.2);
        MNstarSurge_Frame:SetScale(2.2);
        MageNuggets.moonkinSize =  9;
    elseif (tempInt == 10) then
        MNmoonFire_Frame:SetScale(2.7);
        MNinsectSwarm_Frame:SetScale(2.7);
        MNstarSurge_Frame:SetScale(2.7);
        MageNugMoonkin_Frame:SetScale(2.7);
        MageNuggets.moonkinSize =  10;
    end
end

function MNmoonkinCombatToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton1:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinCombat = true;
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    else
        MageNuggets.moonkinCombat = false;
        MageNugMoonkin_Frame:Show();
        MNmoonFire_Frame:Show();
        MNinsectSwarm_Frame:Show();
        MNstarSurge_Frame:Show();
    end

end

function MNmoonkinToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    else
        MageNuggets.moonkinTog = false;
        if (MageNuggets.moonkinCombat == false) then
            MageNugMoonkin_Frame:Show();
            MNmoonFire_Frame:Show();
            MNinsectSwarm_Frame:Show();
            MNstarSurge_Frame:Show();
        end
    end
end

function TreantSoundToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton2:GetChecked();
    if (isChecked == true) then
        MageNuggets.treantSoundTog = true;
    else
        MageNuggets.treantSoundTog = false;
    end
end

function MNmoonkinCombatTextToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton3:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinCombatText = true;
    else
        MageNuggets.moonkinCombatText = false;
    end
end

function MNmoonkinAnchorToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButtonAnchor:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinAnchorTog = true;
        MNmoonFire_Frame:EnableMouse(false);
        MNmoonFire_Frame:ClearAllPoints();
        MNmoonFire_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", -2, 16);
        MNinsectSwarm_Frame:EnableMouse(false);
        MNinsectSwarm_Frame:ClearAllPoints();
        MNinsectSwarm_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 24, 16);
        MNstarSurge_Frame:ClearAllPoints();
        MNstarSurge_Frame:EnableMouse(false);
        MNstarSurge_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 50, 16);
    else
        MageNuggets.moonkinAnchorTog = false;
        MNmoonFire_Frame:EnableMouse(true);
        MNinsectSwarm_Frame:EnableMouse(true);
        MNstarSurge_Frame:EnableMouse(true);
    end
end

function MNmoonkinminimalToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButtonMin:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinMin = true;
        MageNugMoonkin_Frame_Texture:Hide();
    else
        MageNuggets.moonkinMin = false;
        MageNugMoonkin_Frame_Texture:Show();
    end
end

function MNmoonkinBoxToggle()
    local isChecked = MageNugMoonkinOptionFrame_CheckButton0:GetChecked();
    if (isChecked == true) then
        MageNuggets.moonkinBoxTog = true;
    else
        MageNuggets.moonkinBoxTog = false;
    end
end


function MNmoonFire_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        moonfireTime = 0;
        local i = 1;
        local buffName, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        while buffName do
            if(spellId == 164812) then
                moonfireTime = RoundOne(expirationTime - GetTime());
            end
            i = i + 1;
            buffName, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        end
        if(moonfireTime <= 0.5) then
            MNmoonFire_FrameText:SetText(" ")
            MNmoonFire_Frame:SetAlpha(1);
        else
            MNmoonFire_FrameText:SetText(moonfireTime);
            MNmoonFire_Frame:SetAlpha(0.5);
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNinsectSwarm_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        insectTime = 0;
        local i = 1;
        local buffName, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        while buffName do
            if(spellId == 164815) then
                insectTime = RoundOne(expirationTime - GetTime());
            end
            i = i + 1;
            buffName, icon, count, _, duration, expirationTime, unitCaster, _, _, spellId  = UnitAura("target", i, "PLAYER|HARMFUL");
        end
        if(insectTime <= 0.5) then
            MNinsectSwarm_FrameText:SetText(" ")
            MNinsectSwarm_Frame:SetAlpha(1);
         else
            MNinsectSwarm_FrameText:SetText(insectTime);
            MNinsectSwarm_Frame:SetAlpha(0.5);
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNstarSurge_OnUpdate(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        local ssstart, ssduration, ssenabled = GetSpellCooldown(78674);
        starsurgeTime = RoundOne(ssstart + ssduration - GetTime())
        if (starsurgeTime > 1.5) then
            MNstarSurge_FrameText:SetText(starsurgeTime)
            MNstarSurge_Frame:SetAlpha(0.5);
        elseif (starsurgeTime > 1.0) then
            MNstarSurge_FrameText:SetText("gcd")
        else
            MNstarSurge_FrameText:SetText(" ")
            MNstarSurge_Frame:SetAlpha(1);
        end
        self.TimeSinceLastUpdate = 0;
    end
end

function MNanchorMoonkinFrames()
    MNmoonFire_Frame:ClearAllPoints();
    MNmoonFire_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", -2, 16);
    MNinsectSwarm_Frame:ClearAllPoints();
    MNinsectSwarm_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 24, 16);
    MNstarSurge_Frame:ClearAllPoints();
    MNstarSurge_Frame:SetPoint("CENTER", MageNugMoonkin_Frame, "CENTER", 50, 16);
end
