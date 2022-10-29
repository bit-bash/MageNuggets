local magenugVer = "7.1.0"

MageNuggets = {
    ssMonitorToggle = true;
    mageProcToggle = true;
    camZoomTogg = true;
    mirrorImageToggle = true;
    procMonitorToggle = true;
    arcaneBlastToggle = true;
    abCastTimeToggle = true;
    minimapToggle = true;
    polyToggle = true;
    ssMonitorSize = 3;
    mgCombatTog = false;
    procMonitorSize = 3;
    arcaneBlastSize=3;
    lockFrames = false;
    consoleTextEnabled = true;
    slowfallMsg = "Slowfall Cast On You";
    slowfallMsg2 = "Slowfall Cast On You";
    slowfallMsg3 = "Slowfall Cast On You";
    innervatThanks = "Thanks For The Innervate";
    innervatThanks2 = "Thanks For The Innervate";
    powerinfThanks = "Thanks For Power Infusion";
    painSupNotify = "Pain Suppression Cast On You";
    gspiritNotify = "Guardian Spirit Cast On You";
    MinimapPos = 45;
    miSound2 = "mirror.mp3";
    miSoundToggle = true;
    procSound2 = "proc.mp3";
    polySound2 = "sheep.mp3";
    ABSound2 = "impact.mp3";
    hsSound2 = "hotstreak.mp3";
    impactSound2 = "impact.mp3";
    fofSound2 = "fof.mp3";
    brainfreezeSound2 = "brainfreeze.mp3";
    cauterizeSound2 = "toasty.mp3";
    timewarpSound2 = "timewarp.mp3";
    cauterizeSoundToggle = true;
    timewarpSoundToggle = true;
    procSoundToggle = true;
    polySoundToggle = true;
    ABSoundToggle = true;
    hsSoundToggle = true;
    impactSoundToggle = true;
    fofSoundToggle = true;
    brainfreezeSoundToggle = true;
    toolTips = true;
    clickthru = false;
    polyFrameSize = 3;
    msgToggle = true;
    moonkinTog = false;
    moonkinSize = 3;
    moonkinCombat = false;
    treantSoundTog = true;
    treantSound2 = "mirror.mp3";
    moonkinProcTog = true;
    innervatNotify = "Innervate Cast On You!";
    igniteTog = true;
    moonkinProcSize = 3;
    starfallCooldown = true;
    blinkCooldown = true;
    treantCooldown = true;
    moonkinMin = false;
    moonkinAnchorTog = true;
    cauterizeToggle = true;
    moonkinBoxTog = true;
    symbiosisnToggle = true;
    symbiosistyToggle = true;
    innertyToggle = true;
    painSupToggle = true;
    gspiritToggle = true;
    cautSize = 3;
    simpleUiToggle = false;
    bombMouseOverMacro = false;
    novaMonitorToggle = true;
    fireNuggetSize = 3;
    fireNuggetBorder = 1;
    fireNugSimpleUiToggle = false;
    FireNuggetNotifyBorderToggle = true;
}

function MageNuggetOptions_Start(self)
    self:RegisterEvent("ADDON_LOADED")
    loadMageNuggetsOptionsFrames();
    SlashCmdList['MAGENUGGETS_SLASHCMD'] = MageNuggets_SlashCommandHandler
    SLASH_MAGENUGGETS_SLASHCMD1 = "/magenuggets"
end

function MageNuggetsOptions_OnEvent(this, event, ...)
    local argin1, argin2, argin3, argin4, _, argin6 = ...
    if (event == "ADDON_LOADED") then
        if(argin1 == "MageNuggets") then
           loadMageNuggetOptionsVariables_OnLoadEvent();
           mageNuggetsSoundOptionsOnLoad();
        end
    end
end

function MageNuggets_SlashCommandHandler(msg)
    if (msg == "options") then
	    InterfaceOptionsFrame_OpenToCategory("Mage Nuggets");
    elseif (msg == "ports") then
        MageNugz_Minimap_OnClick();
    else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff------------|cff00BFFF".."Mage".." |cff00FF00".."Nuggets".."|cffffffff "..magenugVer.."--------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/magenuggets".." ".."options (Shows Option Menu)")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff".."/magenuggets".." ".."ports (Shows Portal Menu)")
    end
end

function loadMageNuggetsOptionsFrames()
    local MageNugOptions = CreateFrame("FRAME", "MageNugOptions", InterfaceOptionsFrame)
    MageNugOptions.name = "Mage Nuggets"
    InterfaceOptions_AddCategory(MageNugOptions)
    MageNugOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local fireNuggetOptions = CreateFrame("FRAME", "fireNuggetOptions");
    fireNuggetOptions.name = "Fire Nugget";
    fireNuggetOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(fireNuggetOptions);
    fireNuggetOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local msgOptions = CreateFrame("FRAME", "msgOptions");
    msgOptions.name = "Messages";
    msgOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(msgOptions);
    msgOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local soundOptions = CreateFrame("FRAME", "soundOptions");
    soundOptions.name = "Sounds";
    soundOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(soundOptions);
    soundOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local priestOptions = CreateFrame("FRAME", "priestOptions");
    priestOptions.name = "Priest";
    priestOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(priestOptions);
    priestOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local moonkinOptions = CreateFrame("FRAME", "moonkinOptions");
    moonkinOptions.name = "Moonkin";
    moonkinOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(moonkinOptions);
    moonkinOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

    local mnOptions = CreateFrame("FRAME", "mnOptions");
    mnOptions.name = "Options";
    mnOptions.parent = "Mage Nuggets";
    InterfaceOptions_AddCategory(mnOptions);
    mnOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)

end

function loadMageNuggetOptionsVariables_OnLoadEvent()
    if(MageNuggets.bombMouseOverMacro == nil) then
        MageNuggets.bombMouseOverMacro = false;
    end
    if(MageNuggets.bombMouseOverMacro == true) then
    --    MageNugOption2Frame_MinimapCheckButton:SetChecked(true);
    else
      --  MageNugOption2Frame_MinimapCheckButton:SetChecked(false);
    end
    if (MageNuggets.minimapToggle == nil) then
        MageNuggets.minimapToggle = true;
    end
    if (MageNuggets.minimapToggle == true) then
        MageNug_MinimapFrame:Show();
        MageNugOption2Frame_MinimapCheckButton:SetChecked(false);
    else
        MageNug_MinimapFrame:Hide();
        MageNugOption2Frame_MinimapCheckButton:SetChecked(true);
    end
    if (MageNuggets.ssMonitorToggle == true) then
        MageNugOptionsFrame_CheckButton2:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton2:SetChecked(true);
    end
    if(MageNuggets.abCastTimeToggle == true) then
        MageNugOptionsFrame_ABcastCheckButton:SetChecked(true);
    else
        MageNugOptionsFrame_ABcastCheckButton:SetChecked(false);
    end
    if (MageNuggets.mageProcToggle == true) or (MageNuggets.mageProcToggle == nil) then
        MageNugOptionsFrame_CheckButton3:SetChecked(false);
        MageNuggets.mageProcToggle = true;
    else
        MageNugOptionsFrame_CheckButton3:SetChecked(true);
    end
    if(MageNuggets.igniteTog == true) or (MageNuggets.igniteTog == nil) then
        MageNugFireNugOptionFrame_IgniteCheckButton:SetChecked(true);
        MageNuggets.igniteTog = true;
    else
        MageNugFireNugOptionFrame_IgniteCheckButton:GetChecked(false);
    end
    if (MageNuggets.mirrorImageToggle == true) then
        MageNugOptionsFrame_CheckButton6:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton6:SetChecked(true);
    end
    if(MageNuggets.abCastTimeToggle == nil) then
        MageNuggets.abCastTimeToggle = true;
    end
    if (MageNuggets.arcaneBlastToggle == true) then
        MageNugOptionsFrame_CheckButton13:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton13:SetChecked(true);
    end
    if (MageNuggets.polyToggle == true) then
        MageNugOptionsFrame_CheckButton14:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton14:SetChecked(true);
    end

    if (MageNuggets.novaMonitorToggle == nil) then
        MageNuggets.novaMonitorToggle = true;
    end
    if (MageNuggets.novaMonitorToggle == true) then
        MageNugOptionsFrame_CheckButtonNova:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButtonNova:SetChecked(true);
    end

    if(MageNuggets.mgCombatTog == nil) then
        MageNuggets.mgCombatTog = false;
    end
    if (MageNuggets.procMonitorToggle == nil) then
        MageNuggets.procMonitorToggle = true;
    end
    if (MageNuggets.procMonitorToggle == true) then
        MageNugOptionsFrame_CheckButton11:SetChecked(false);
    else
        MageNugOptionsFrame_CheckButton11:SetChecked(true);
    end
    if (MageNuggets.ssMonitorSize == nil) then
        MageNugOptionsFrame_Slider2:SetValue(3)
    else
        MageNugOptionsFrame_Slider2:SetValue(MageNuggets.ssMonitorSize)
    end

    if (MageNuggets.polyFrameSize == nil) then
        MageNugOptionsFrame_Slider1:SetValue(3)
    else
        MageNugOptionsFrame_Slider1:SetValue(MageNuggets.polyFrameSize)
    end

    if (MageNuggets.cautSize == nil) then
        MageNugOptionsFrame_Slider5:SetValue(3)
    else
        MageNugOptionsFrame_Slider5:SetValue(MageNuggets.cautSize)
    end
    if (MageNuggets.arcaneBlastSize == nil) then
        MageNugOptionsFrame_Slider3:SetValue(3)
    else
        MageNugOptionsFrame_Slider3:SetValue(MageNuggets.arcaneBlastSize)
    end
    if (MageNuggets.procMonitorSize == nil) then
        MageNugOptionsFrame_Slider4:SetValue(3)
    else
        MageNugOptionsFrame_Slider4:SetValue(MageNuggets.procMonitorSize)
    end
    -----Messages Options----
    if (MageNuggets.msgToggle == nil) then
        MageNuggets.msgToggle = true;
    end
    if (MageNuggets.msgToggle == true) then
        MageNugMsgOptionFrame_CheckButton:SetChecked(true);
    else
        MageNugMsgOptionFrame_CheckButton:SetChecked(false);
    end
    if (MageNuggets.innertyToggle == nil) then
        MageNuggets.innertyToggle = true;
    end
    if (MageNuggets.innertyToggle == true) then
        MageNugMsgOptionFrame_CheckButton4:SetChecked(true);
    else
        MageNugMsgOptionFrame_CheckButton4:SetChecked(false);
    end
    if (MageNuggets.slowfallMsg == nil) or (MageNuggets.slowfallMsg == "") then
        SlowFallMsgEditBox:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox:SetText(MageNuggets.slowfallMsg)
    end
    if (MageNuggets.slowfallMsg2 == nil) or (MageNuggets.slowfallMsg2 == "") then
        SlowFallMsgEditBox2:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox2:SetText(MageNuggets.slowfallMsg2)
    end
    if (MageNuggets.slowfallMsg3 == nil) or (MageNuggets.slowfallMsg3 == "")then
        SlowFallMsgEditBox3:SetText("Slowfall Cast On You")
    else
        SlowFallMsgEditBox3:SetText(MageNuggets.slowfallMsg3)
    end
    if (MageNuggets.innervatThanks == nil) or (MageNuggets.innervatThanks == "") then
        InnervThankEditBox:SetText("Thanks For The Innervate")
    else
        InnervThankEditBox:SetText(MageNuggets.innervatThanks)
    end
    if (MageNuggets.innervatThanks2 == nil) or (MageNuggets.innervatThanks2 == "") then
        InnervThankEditBox2:SetText("Thanks For The Innervate")
    else
        InnervThankEditBox2:SetText(MageNuggets.innervatThanks2)
    end

    ----fire nugget options----
    if(MageNuggets.fireNuggetSize == nil)then
      MageNugFireNugOptionFrame_SizeSlider:SetValue(3);
    else
      MageNugFireNugOptionFrame_SizeSlider:SetValue(MageNuggets.fireNuggetSize);
    end
    if(MageNuggets.fireNuggetBorder == nil)then
      MageNugFireNugOptionFrame_BorderSlider:SetValue(1);
    else
      MageNugFireNugOptionFrame_BorderSlider:SetValue(MageNuggets.fireNuggetBorder);
    end
    if(MageNuggets.FireNuggetNotifyBorderToggle == nil)then
      MageNugFireNugOptionFrame_NotifyCheckButton:SetChecked(true);
    else
      MageNugFireNugOptionFrame_NotifyCheckButton:SetChecked(MageNuggets.FireNuggetNotifyBorderToggle);
    end
    if(MageNuggets.fireNugSimpleUiToggle == nil)then
      MageNugFireNugOptionFrame_SimpleUiCheckButton:SetChecked(false);
    else
      MageNugFireNugOptionFrame_SimpleUiCheckButton:SetChecked(MageNuggets.fireNugSimpleUiToggle);
    end
    MNFireNuggetSimpleUiToggle();
    --------Options 2--------
    MNcheckboxMiniMapFontString:SetText("Disable Minimap Button")
    MNcheckboxCameraFontString:SetText("Disable Maximum Camera Zoom Out")
    MNcheckboxConsoleTextFontString:SetText("Disable Console Text")
    MNcheckboxLockFramesFontString:SetText("Lock Frames")
    MNcheckboxTTFontString:SetText("Tool Tips")
    MNcheckboxClickThruFontString:SetText("Enable Frame Click Through")
    if (MageNuggets.MinimapPos == nil) then
        MageNuggets.MinimapPos = 45;
    end
    if (MageNuggets.camZoomTogg == true) then
        ConsoleExec("cameraDistanceMaxFactor 2.6");
        MageNugOption2Frame_CameraCheckButton:SetChecked(false);
    else
        MageNugOption2Frame_CameraCheckButton:SetChecked(true);
    end
    if (MageNuggets.lockFrames == nil) then
        MageNuggets.lockFrames = false;
    end
    if (MageNuggets.lockFrames == true) then
        MageNugOption2Frame_LockFramesCheckButton:SetChecked(true);
    else
        MageNugOption2Frame_LockFramesCheckButton:SetChecked(false);
    end
    if (MageNuggets.consoleTextEnabled == nil) then
        MageNuggets.consoleTextEnabled = true;
    end
    if (MageNuggets.consoleTextEnabled == true) then
        MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(false);
    else
        MageNugOption2Frame_ConsoleTextCheckButton:SetChecked(true);
    end
    if (MageNuggets.toolTips == nil) then
        MageNuggets.toolTips = true;
    end
    if (MageNuggets.toolTips == true) then
        MageNugOption2Frame_CheckButtonTT:SetChecked(true);
    else
        MageNugOption2Frame_CheckButtonTT:SetChecked(false);
    end
    if (MageNuggets.clickthru == nil) then
        MageNuggets.clickthru = false;
    end
    if (MageNuggets.clickthru == true) then
        MageNugOption2Frame_ClickThruCheckButton:SetChecked(true);
    else
        MageNugOption2Frame_ClickThruCheckButton:SetChecked(false);
    end
    if (MageNuggets.simpleUiToggle == nil) then
        MageNuggets.simpleUiToggle = false;
    end
    if (MageNuggets.simpleUiToggle == true) then
        MageNugOption2Frame_SimpleUICheckButton:SetChecked(true);
    else
        MageNugOption2Frame_SimpleUICheckButton:SetChecked(false);
    end
    MNsimpleUItoggle();

    if (MageNuggets.cauterizeToggle == true) or (MageNuggets.cauterizeToggle == nil) then
        CauterizeCheckButton:SetChecked(true);
        MageNuggets.cauterizeToggle = true;
    else
        CauterizeCheckButton:SetChecked(false);
    end

    --------Priest---------------

    if(MageNuggets.powerInfToggle == true) or (MageNuggets.powerInfToggle == nil)then
        MageNugPriestOptionFrame_CheckButton0:SetChecked(true);
        MageNuggets.powerInfToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton0:SetChecked(false);
        MageNuggets.powerInfToggle = false;
    end
    if (MageNuggets.powerinfNotify == nil) or (MageNuggets.powerinfNotify == "") then
        MageNugPriestOptionFrame_EditBox1:SetText("Power Infusion Cast On You")
    else
        MageNugPriestOptionFrame_EditBox1:SetText(MageNuggets.powerinfNotify)
    end
    if(MageNuggets.painSupToggle == true) or (MageNuggets.painSupToggle == nil)then
        MageNugPriestOptionFrame_CheckButton2:SetChecked(true);
        MageNuggets.painSupToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton2:SetChecked(false);
        MageNuggets.painSupToggle = false;
    end
    if (MageNuggets.painSupNotify == nil) or (MageNuggets.painSupNotify == "") then
        MageNugPriestOptionFrame_EditBox2:SetText("Pain Suppression Cast On You")
    else
        MageNugPriestOptionFrame_EditBox2:SetText(MageNuggets.painSupNotify)
    end
    if(MageNuggets.gspiritToggle == true) or (MageNuggets.gspiritToggle == nil)then
        MageNugPriestOptionFrame_CheckButton3:SetChecked(true);
        MageNuggets.gspiritToggle = true;
    else
        MageNugPriestOptionFrame_CheckButton3:SetChecked(false);
        MageNuggets.gspiritToggle = false;
    end
    if (MageNuggets.gspiritNotify == nil) or (MageNuggets.gspiritNotify == "") then
        MageNugPriestOptionFrame_EditBox3:SetText("Guardian Spirit Cast On You")
    else
        MageNugPriestOptionFrame_EditBox3:SetText(MageNuggets.gspiritNotify)
    end
    -----moonkin options--------
    if(MageNuggets.moonkinBoxTog == true) or (MageNuggets.moonkinBoxTog == nil)then
        MageNugMoonkinOptionFrame_CheckButton0:SetChecked(true);
        MageNuggets.moonkinBoxTog = true;
    else
        MageNugMoonkinOptionFrame_CheckButton0:SetChecked(false);
        MageNuggets.moonkinBoxTog = false;
    end
    if(MageNuggets.moonkinTog == nil) then
        MageNuggets.moonkinTog = false;
    end
    if (MageNuggets.moonkinTog == true) then
        MageNugMoonkinOptionFrame_CheckButton:SetChecked(true);
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    else
        MageNugMoonkinOptionFrame_CheckButton:SetChecked(false);
        if(MageNuggets.moonkinCombat == false) then
            MageNugMoonkin_Frame:Show();
            MNmoonFire_Frame:Show();
            MNinsectSwarm_Frame:Show();
            MNstarSurge_Frame:Show();
        end
    end
    if (MageNuggets.moonkinCombat == nil) then
        MageNuggets.moonkinCombat = false;
    end
    if (MageNuggets.moonkinCombat == true) then
        MageNugMoonkinOptionFrame_CheckButton1:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton1:SetChecked(false);
    end
    if (MageNuggets.moonkinMin == nil) then
        MageNuggets.moonkinMin = false;
    end
    if (MageNuggets.moonkinMin == true) then
        MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButtonMin:SetChecked(false);
    end
    if (MageNuggets.moonkinSize == nil) then
        MageNugMoonkinOptionFrame_Slider:SetValue(3)
    else
        MageNugMoonkinOptionFrame_Slider:SetValue(MageNuggets.moonkinSize)
    end
    if (MageNuggets.treantSoundTog == nil) then
        MageNuggets.treantSoundTog = true;
    end
    if (MageNuggets.treantSoundTog == true) then
        MageNugMoonkinOptionFrame_CheckButton2:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton2:SetChecked(false);
    end
    if (MageNuggets.treantSound2 == nil) or (MageNuggets.treantSound2 == "") then
        MageNugMoonkinOptionFrame_SoundEditBox:SetText("mirror.mp3")
    else
        MageNugMoonkinOptionFrame_SoundEditBox:SetText(MageNuggets.treantSound2)
    end
    if (MageNuggets.moonkinCombatText == nil)then
        MageNuggets.moonkinCombatText = true
    end
    if (MageNuggets.moonkinCombatText == true) then
        MageNugMoonkinOptionFrame_CheckButton3:SetChecked(true);
    else
        MageNugMoonkinOptionFrame_CheckButton3:SetChecked(false);
    end
    if (MageNuggets.innervatNotify == nil) or (MageNuggets.innervatNotify == "") then
        MageNugMoonkinOptionFrame_InnervateEditBox:SetText("Innervate Cast On You!")
    else
        MageNugMoonkinOptionFrame_InnervateEditBox:SetText(MageNuggets.innervatNotify)
    end
    if (MageNuggets.moonkinAnchorTog == nil) then
        MageNuggets.moonkinAnchorTog = true;
    end
    if(MageNuggets.moonkinAnchorTog == true)then
        MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(true)
    else
        MageNugMoonkinOptionFrame_CheckButtonAnchor:SetChecked(false)
    end
    soundPlayed = false;
    ------------------------------
    MageNugPolyFrame:Hide();
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide();
    MageNugAB_Frame:Hide();
    paralysisId, _, _, _, _, _, _, _, _ = GetSpellInfo(115078);
    shackleId, _, _, _, _, _, _, _, _ = GetSpellInfo(9484);
    iceBlockId, _, _, _, _, _, _, _, _ = GetSpellInfo(45438);
    livingBombId, _, _, _, _, _, _, _, _ = GetSpellInfo(44457);
    netherTempestId, _, _, _, _, _, _, _, _ = GetSpellInfo(114923);
    icyVeinsId, _, _, _, _, _, _, _, _ = GetSpellInfo(12472);
    polyPigId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polySheepId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyTurtleId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyRabbitId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    polyCatId, _, _, _, _, _, _, _, _ = GetSpellInfo(28272);
    frostboltId, _, _, _, _, _, _, _, _ = GetSpellInfo(42842);
    frostfireId, _, _, _, _, _, _, _, _ = GetSpellInfo(47610);
    conecoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(42931);
    blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(42945);
    judgementjustId, _, _, _, _, _, _, _, _ = GetSpellInfo(53696);
    infectedwoundsId, _, _, _, _, _, _, _, _ = GetSpellInfo(48485);
    thunderclapId, _, _, _, _, _, _, _, _ = GetSpellInfo(47502);
    deadlythrowId, _, _, _, _, _, _, _, _ = GetSpellInfo(48674);
    frostshockId, _, _, _, _, _, _, _, _ = GetSpellInfo(49236);
    chilledId, _, _, _, _, _, _, _, _ = GetSpellInfo(7321);
    mindflayId, _, _, _, _, _, _, _, _ = GetSpellInfo(48156);
    impactId, _, _, _, _, _, _, _, _ = GetSpellInfo(64343);

    MageNugz_MinimapButton_Move()
    MnClickThrough()
    MNmoonkinAnchorToggle()
    incombat = 0;

    if(MageNuggets_Frames.frostbomb_point == nil) then
        MageNuggets_Frames.frostbomb_point = "CENTER";
    end
    if(MageNuggets_Frames.frostbomb_relativePoint == nil) then
        MageNuggets_Frames.frostbomb_relativePoint = "CENTER";
    end
    if(MageNuggets_Frames.frostbomb_xOfs == nil) then
        MageNuggets_Frames.frostbomb_xOfs = 0;
    end
    if(MageNuggets_Frames.frostbomb_yOfs == nil) then
        MageNuggets_Frames.frostbomb_yOfs = 0;
    end

    if(MageNuggets_Frames.hu_point == nil) then
        MageNuggets_Frames.hu_point = "CENTER";
    end
    if(MageNuggets_Frames.hu_relativePoint == nil) then
        MageNuggets_Frames.hu_relativePoint = "CENTER";
    end
    if(MageNuggets_Frames.hu_xOfs == nil) then
        MageNuggets_Frames.hu_xOfs = 0;
    end
    if(MageNuggets_Frames.hu_yOfs == nil) then
        MageNuggets_Frames.hu_yOfs = 0;
    end

end

function mageNuggetsSoundOptionsOnLoad()
    if (MageNuggets.miSound2 == nil) or (MageNuggets.miSound2 == "") or (MageNuggets.miSound2 == "mirror.ogg") then
        MageNugSoundOptionFrame_MISoundEditBox:SetText("mirror.mp3")
    else
        MageNugSoundOptionFrame_MISoundEditBox:SetText(MageNuggets.miSound2)
    end
    if (MageNuggets.procSound2 == nil) or (MageNuggets.procSound2 == "") or (MageNuggets.procSound2 == "proc.ogg") then
        MageNugSoundOptionFrame_ProcSoundEditBox:SetText("proc.mp3")
    else
        MageNugSoundOptionFrame_ProcSoundEditBox:SetText(MageNuggets.procSound2)
    end
    if (MageNuggets.miSoundToggle == true) or (MageNuggets.miSoundToggle == nil) then
        MageNugSoundOptionFrame_MICheckButton:SetChecked(true);
        MageNuggets.miSoundToggle = true;
    else
        MageNugSoundOptionFrame_MICheckButton:SetChecked(false);
    end
    if (MageNuggets.procSoundToggle == true) or (MageNuggets.procSoundToggle == nil) then
        MageNugSoundOptionFrame_ProcCheckButton:SetChecked(true);
        MageNuggets.procSoundToggle = true;
    else
        MageNugSoundOptionFrame_ProcCheckButton:SetChecked(false);
    end
    if (MageNuggets.polySound2 == nil) or (MageNuggets.polySound2 == "") or (MageNuggets.polySound2 == "sheep.ogg") then
        MageNugSoundOptionFrame_PolySoundEditBox:SetText("sheep.mp3")
    else
        MageNugSoundOptionFrame_PolySoundEditBox:SetText(MageNuggets.polySound2)
    end
    if (MageNuggets.polySoundToggle == true) or (MageNuggets.polySoundToggle == nil) then
        MageNugSoundOptionFrame_PolyCheckButton:SetChecked(true);
        MageNuggets.polySoundToggle = true;
    else
        MageNugSoundOptionFrame_PolyCheckButton:SetChecked(false);
    end

    if (MageNuggets.ABSound2 == nil) or (MageNuggets.ABSound2 == "") or (MageNuggets.ABSound2 == "impact.ogg") then
        MageNugSoundOptionFrame_ABSoundEditBox:SetText("impact.mp3")
    else
        MageNugSoundOptionFrame_ABSoundEditBox:SetText(MageNuggets.ABSound2)
    end
    if (MageNuggets.ABSoundToggle == true) or (MageNuggets.ABSoundToggle == nil) then
        MageNugSoundOptionFrame_ABCheckButton:SetChecked(true);
        MageNuggets.ABSoundToggle = true;
    else
        MageNugSoundOptionFrame_ABCheckButton:SetChecked(false);
    end

    if (MageNuggets.hsSound2 == nil) or (MageNuggets.hsSound2 == "") or (MageNuggets.hsSound2 == "hotstreak.ogg") then
        MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText("hotstreak.mp3")
    else
        MageNugSoundOptionFrame_HotStreakSoundEditBox:SetText(MageNuggets.hsSound2)
    end
    if (MageNuggets.hsSoundToggle == true) or (MageNuggets.hsSoundToggle == nil) then
        MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(true);
        MageNuggets.hsSoundToggle = true;
    else
        MageNugSoundOptionFrame_HotStreakCheckButton:SetChecked(false);
    end
    if (MageNuggets.impactSound2 == nil) or (MageNuggets.impactSound2 == "") or (MageNuggets.impactSound2 == "impact.ogg") then
        MageNugSoundOptionFrame_ImpactSoundEditBox:SetText("impact.mp3")
    else
        MageNugSoundOptionFrame_ImpactSoundEditBox:SetText(MageNuggets.impactSound2)
    end
    if (MageNuggets.impactSoundToggle == true) or (MageNuggets.impactSoundToggle == nil) then
        MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(true);
        MageNuggets.impactSoundToggle = true;
    else
        MageNugSoundOptionFrame_ImpactCheckButton:SetChecked(false);
    end
    if (MageNuggets.fofSound2 == nil) or (MageNuggets.fofSound2 == "") or (MageNuggets.fofSound2 == "fof.ogg") then
        MageNugSoundOptionFrame_FoFSoundEditBox:SetText("fof.mp3")
    else
        MageNugSoundOptionFrame_FoFSoundEditBox:SetText(MageNuggets.fofSound2)
    end
    if (MageNuggets.fofSoundToggle == true) or (MageNuggets.fofSoundToggle == nil) then
        MageNugSoundOptionFrame_FoFCheckButton:SetChecked(true);
        MageNuggets.fofSoundToggle = true;
    else
        MageNugSoundOptionFrame_FoFCheckButton:SetChecked(false);
    end
    if (MageNuggets.brainfreezeSound2 == nil) or (MageNuggets.brainfreezeSound2 == "") or (MageNuggets.brainfreezeSound2 == "brainfreeze.ogg") then
        MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText("brainfreeze.mp3")
    else
        MageNugSoundOptionFrame_BrainFreezeSoundEditBox:SetText(MageNuggets.brainfreezeSound2)
    end
    if (MageNuggets.brainfreezeSoundToggle == true) or (MageNuggets.brainfreezeSoundToggle == nil) then
        MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(true);
        MageNuggets.brainfreezeSoundToggle = true;
    else
        MageNugSoundOptionFrame_BrainFreezeCheckButton:SetChecked(false);
    end
    if (MageNuggets.cauterizeSound2 == nil) or (MageNuggets.cauterizeSound2 == "") or (MageNuggets.cauterizeSound2 == "toasty.ogg") then
        MageNugSoundOptionFrame_CauterizeSoundEditBox:SetText("toasty.mp3")
    else
        MageNugSoundOptionFrame_CauterizeSoundEditBox:SetText(MageNuggets.cauterizeSound2)
    end
    if (MageNuggets.cauterizeSoundToggle == true) or (MageNuggets.cauterizeSoundToggle == nil) then
        MageNugSoundOptionFrame_CauterizeCheckButton:SetChecked(true);
        MageNuggets.cauterizeSoundToggle = true;
    else
        MageNugSoundOptionFrame_CauterizeCheckButton:SetChecked(false);
    end
    if (MageNuggets.timewarpSound2 == nil) or (MageNuggets.timewarpSound2 == "") or (MageNuggets.timewarpSound2 == "timewarp.ogg") then
        MageNugSoundOptionFrame_TimeWarpSoundEditBox:SetText("timewarp.mp3")
    else
        MageNugSoundOptionFrame_TimeWarpSoundEditBox:SetText(MageNuggets.timewarpSound2)
    end
    if (MageNuggets.timewarpSoundToggle == true) or (MageNuggets.timewarpSoundToggle == nil) then
        MageNugSoundOptionFrame_TimeWarpCheckButton:SetChecked(true);
        MageNuggets.timewarpSoundToggle = true;
    else
        MageNugSoundOptionFrame_TimeWarpCheckButton:SetChecked(false);
    end
end

--
function MNsimpleUItoggle()
    local isChecked = MageNugOption2Frame_SimpleUICheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.simpleUiToggle = true;
        MageNugProcFrameTextureBorder:SetTexture();
        MageNugBFProcFrameTextureBorder:SetTexture();
        MageNugProcHUFrameTextureBorder:SetTexture();
        MageNugCauterizeFrameTextureBorder:SetTexture();
        MageNugPolyFrameTextureBorder:SetTexture();
        MageNugFoFProcFrameTextureBorder:SetTexture();
        MageNugMBProcFrameTextureBorder:SetTexture();
    else
        MageNuggets.simpleUiToggle = false;
        MageNugProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugBFProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Water_Horizontal_Frame");
        MageNugProcHUFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugCauterizeFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Fire_Horizontal_Frame");
        MageNugPolyFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Horizontal_Frame");
        MageNugFoFProcFrameTextureBorder:SetTexture("Interface\\UNITPOWERBARALT\\Ice_Horizontal_Frame");
        MageNugMBProcFrameTextureBorder:SetTexture("Interface\\GMChatFrame\\UI-GMStatusFrame-Pulse");
    end
end
--
function MNMinimapButtonToggle()
    local mini = MageNugOption2Frame_MinimapCheckButton:GetChecked();
    if (mini == true) then
        MageNuggets.minimapToggle = false;
        MageNug_MinimapFrame:Hide();
    else
        MageNuggets.minimapToggle = true;
        MageNug_MinimapFrame:Show();
    end
end
--
function MNNovaToggle() -- ice nova supernova
    local mini = MageNugOptionsFrame_CheckButtonNova:GetChecked();
    if (mini == true) then
        MageNuggets.novaMonitorToggle = false;
        MageNugNova_Frame:Hide();
    else
        MageNuggets.novaMonitorToggle = true;
    end
end
--
function HideSSMonitorToggle() -- Spellsteal Monitor Toggle
    local stealMonitorChecked = MageNugOptionsFrame_CheckButton2:GetChecked();
    if (stealMonitorChecked == true) then
	    MageNuggets.ssMonitorToggle = false;
    else
        MageNuggets.ssMonitorToggle = true;
    end
end

function MNmessagesToggle() --slowfall notify Toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton:GetChecked();
    if (msgTog == true) then
	    MageNuggets.msgToggle = true;
    else
        MageNuggets.msgToggle = false;
    end
end

function MNpainSupNotifyToggle() -- pain suppression notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton2:GetChecked();
    if (msgTog == true) then
	    MageNuggets.painSupToggle = true;
    else
        MageNuggets.painSupToggle = false;
    end
end

function MNgspiritNotifyToggle() -- g spirit notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton3:GetChecked();
    if (msgTog == true) then
	    MageNuggets.gspiritToggle = true;
    else
        MageNuggets.gspiritToggle = false;
    end
end


function MNpowerInfNotifyToggle() -- power inf notify toggle
    local msgTog = MageNugPriestOptionFrame_CheckButton0:GetChecked();
    if (msgTog == true) then
	    MageNuggets.powerInfToggle = true;
    else
        MageNuggets.powerInfToggle = false;
    end
end

function MNfocusMagicNotifyToggle() -- Focus magic notify toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton2:GetChecked();
    if (msgTog == true) then
	    MageNuggets.symbiosisnToggle = true;
    else
        MageNuggets.symbiosisnToggle = false;
    end
end

function MNfocusMagicThanksToggle() -- Focus magic thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton3:GetChecked();
    if (msgTog == true) then
	    MageNuggets.symbiosistyToggle = true;
    else
        MageNuggets.symbiosistyToggle = false;
    end
end

function MNinnervateThanksToggle() -- innervate thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton4:GetChecked();
    if (msgTog == true) then
	    MageNuggets.innertyToggle = true;
    else
        MageNuggets.innertyToggle = false;
    end
end
function MNpowerInfusionTyToggle() -- Power infusion thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton5:GetChecked();
    if (msgTog == true) then
	    MageNuggets.pityToggle = true;
    else
        MageNuggets.pityToggle = false;
    end
end
function MNdarkIntentTyToggle() -- dark intent thanks toggle
    local msgTog = MageNugMsgOptionFrame_CheckButton6:GetChecked();
    if (msgTog == true) then
	    MageNuggets.dityToggle = true;
    else
        MageNuggets.dityToggle = false;
    end
end

function MNCauterizeToggle()
    local isChecked = CauterizeCheckButton:GetChecked();
    if (isChecked == true) then
	    MageNuggets.cauterizeToggle = true;
    else
        MageNuggets.cauterizeToggle = false;
    end
end

function MageProcNoteToggle() -- Mage Proc Notification Toggle
    local cNotifyChecked = MageNugOptionsFrame_CheckButton3:GetChecked();
    if (cNotifyChecked == true) then
	    MageNuggets.mageProcToggle = false;
    else
        MageNuggets.mageProcToggle = true;
    end
end

function cameraZoomToggle() -- Camera Zoom Out Toggle
    local camZoomChecked = MageNugOption2Frame_CameraCheckButton:GetChecked();
    if (camZoomChecked == true) then
        ConsoleExec("cameraDistanceMax 15");
        MageNuggets.camZoomTogg = false;
    else
        ConsoleExec("cameraDistanceMax 50");
        MageNuggets.camZoomTogg = true;
    end
end

function MirrorImageSoundToggle() -- Mirror Image Sound Toggle
    local miChecked = MageNugSoundOptionFrame_MICheckButton:GetChecked();
    if (miChecked == true) then
        MageNuggets.miSoundToggle = true;
    else
        MageNuggets.miSoundToggle = false;
    end
end

function ProcSoundToggle() -- Proc Sound Toggle
    local procChecked = MageNugSoundOptionFrame_ProcCheckButton:GetChecked();
    if (procChecked == true) then
        MageNuggets.procSoundToggle = true;
    else
        MageNuggets.procSoundToggle = false;
    end
end

function PolySoundToggle() -- Poly Sound Toggle
    local isChecked = MageNugSoundOptionFrame_PolyCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.polySoundToggle = true;
    else
        MageNuggets.polySoundToggle = false;
    end
end

function BlastStackSoundToggle() -- Arcane Blast \ Stack Sound Toggle
    local isChecked = MageNugSoundOptionFrame_ABCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.ABSoundToggle = true;
    else
        MageNuggets.ABSoundToggle = false;
    end
end

function HotStreakSoundToggle() -- HS Sound Toggle
    local isChecked = MageNugSoundOptionFrame_HotStreakCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.hsSoundToggle = true;
    else
        MageNuggets.hsSoundToggle = false;
    end
end

function CauterizeSoundToggle() -- Cauterize Sound Toggle
    local isChecked = MageNugSoundOptionFrame_CauterizeCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.cauterizeSoundToggle = true;
    else
        MageNuggets.cauterizeSoundToggle = false;
    end
end

function TimeWarpSoundToggle() -- time warp Sound Toggle
    local isChecked = MageNugSoundOptionFrame_TimeWarpCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.timewarpSoundToggle = true;
    else
        MageNuggets.timewarpSoundToggle = false;
    end
end

function ImpactSoundToggle() -- Impact Sound Toggle
    local isChecked = MageNugSoundOptionFrame_ImpactCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.impactSoundToggle = true;
    else
        MageNuggets.impactSoundToggle = false;
    end
end

function FoFSoundToggle() -- FoF Sound Toggle
    local isChecked = MageNugSoundOptionFrame_FoFCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.fofSoundToggle = true;
    else
        MageNuggets.fofSoundToggle = false;
    end
end

function BrainFreezeSoundToggle() --Brain Freeze Sound Toggle
    local isChecked = MageNugSoundOptionFrame_BrainFreezeCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.brainfreezeSoundToggle = true;
    else
        MageNuggets.brainfreezeSoundToggle = false;
    end
end

function MirrorImagToggle() -- Mirror Image Timer Toggle
    local mirrorChecked = MageNugOptionsFrame_CheckButton6:GetChecked();
    if (mirrorChecked == true) then
        MageNuggets.mirrorImageToggle = false;
    else
        MageNuggets.mirrorImageToggle = true;
    end
end


function MNabCastTimeToggle() -- AB Cast Time Toggle
    local abcChecked = MageNugOptionsFrame_ABcastCheckButton:GetChecked();
    if (abcChecked == true) then
        MageNuggets.abCastTimeToggle = true;
        MNabCast_Frame:Show();
    else
        MageNuggets.abCastTimeToggle = false;
        MNabCast_Frame:Hide();
    end
end

function MageProcMonitorToggle()
    local mpChecked = MageNugOptionsFrame_CheckButton11:GetChecked();
    if (mpChecked == true) then
        MageNuggets.procMonitorToggle = false;
    else
        MageNuggets.procMonitorToggle = true;
    end
end

function MNArcaneBlastToggle()
    local abChecked = MageNugOptionsFrame_CheckButton13:GetChecked();
    if (abChecked == true) then
        MageNuggets.arcaneBlastToggle = false;
    else
        MageNuggets.arcaneBlastToggle = true;
    end
end

function MNpolyToggle()
    local polyChecked = MageNugOptionsFrame_CheckButton14:GetChecked();
    if (polyChecked == true) then
        MageNuggets.polyToggle = false;
    else
        MageNuggets.polyToggle = true;
    end
end

function MnClickThrough()
    local clickChecked = MageNugOption2Frame_ClickThruCheckButton:GetChecked();
    if (clickChecked == true) then
        MageNuggets.clickthru = true;
        MNSpellStealFocus_Frame:EnableMouse(false);
        MageNugIgnite_Frame:EnableMouse(false)
        MageNugCauterize_Frame:EnableMouse(false);
        MageNugAB_Frame:EnableMouse(false)
        MNabCast_Frame:EnableMouse(false)
        MageNugProcFrame:EnableMouse(false)
        MageNugProcHUFrame:EnableMouse(false)
        MageNugPolyFrame:EnableMouse(false)
        MageNugBFProcFrame:EnableMouse(false)
        MageNugMBProcFrame:EnableMouse(false)
        MageNugFoFProcFrame:EnableMouse(false)
        MNSpellSteal_Frame:EnableMouse(false)
        MageNugMI_Frame:EnableMouse(false)
        MageNugMoonkin_Frame:EnableMouse(false)
        MNmoonFire_Frame:EnableMouse(false)
        MNinsectSwarm_Frame:EnableMouse(false)
        MNstarSurge_Frame:EnableMouse(false)
    else
        MageNuggets.clickthru = false;
        MNSpellStealFocus_Frame:EnableMouse(true);
        MageNugIgnite_Frame:EnableMouse(true)
        MageNugCauterize_Frame:EnableMouse(true);
        MageNugAB_Frame:EnableMouse(true)
        MNabCast_Frame:EnableMouse(true)
        MageNugProcFrame:EnableMouse(true)
        MageNugProcHUFrame:EnableMouse(true)
        MageNugPolyFrame:EnableMouse(true)
        MageNugBFProcFrame:EnableMouse(true)
        MageNugMBProcFrame:EnableMouse(true)
        MageNugFoFProcFrame:EnableMouse(true)
        MNSpellSteal_Frame:EnableMouse(true)
        MageNugMI_Frame:EnableMouse(true)
        MageNugMoonkin_Frame:EnableMouse(true)
        MNmoonFire_Frame:EnableMouse(true)
        MNinsectSwarm_Frame:EnableMouse(true)
        MNstarSurge_Frame:EnableMouse(true)
    end
end

function ShowConfigFrames() --Shows frames for 120 seconds
    previewMnFrames = true;
    if (MageNuggets.ssMonitorToggle == true) then
        spellStealTog = 120;
        MNSpellSteal_Frame:Show();
        MNSpellStealFocus_Frame:Show();
    end
    mirrorImageTime = 120;
    MageNugMI_Frame:Show();
    MageNugNova_Frame:Show();
    MageNugIgnite_Frame:Show();
    polyTimer = 120
    MageNugPolyFrameText:SetText("|cffFFFFFF".."Polymorph")
    MageNugPolyFrame:Show();
    mageImpProgMonTime = 120;
    MageNugBFProcFrameText:SetText("|cffFFFFFF".."BRAIN FREEZE!")
    MageNugBFProcFrame:Show();
    MageNugProcFrameText:SetText("|cffFF0000".."HOT STREAK!");
    MageNugProcFrame:Show();
    MageNugProcHUFrameText:SetText("|cffFFCC00".."HEATING UP!");
    MageNugProcHUFrame:Show();
    MageNugMBProcFrameText:SetText("|cffFF33FF".."ARCANE MISSILES!")
    MageNugMBProcFrame:Show();
    MageNugFoFProcFrameText:SetText("|cffFFFFFF".."Fingers Of Frost")
    MageNugFoFProcFrame:Show();
    cauterizeTime = 120;
    MageNugCauterize_Frame:Show();
    abProgMonTime = 120;
    MageNugAB_Frame:Show();
    clearcastTime = 120;
    MageNugCauterizeFrame:Show();
end

function HideConfigFrames()
    previewMnFrames = false;
    MageNugCauterize_Frame:Hide();
    MNSpellSteal_Frame:Hide();
    MNSpellStealFocus_Frame:Hide();
    MageNugMI_Frame:Hide();
    MageNugPolyFrame:Hide();
    MageNugIgnite_Frame:Hide();
    MageNugBFProcFrame:Hide();
    MageNugProcFrame:Hide();
    MageNugProcHUFrame:Hide();
    MageNugMBProcFrame:Hide();
    MageNugFoFProcFrame:Hide();
    MageNugAB_Frame:Hide();
    MageNugCauterizeFrame:Hide();
    MageNugNova_Frame:Hide();
end


function LockFramesToggle()
    local flChecked = MageNugOption2Frame_LockFramesCheckButton:GetChecked();
    if (flChecked == true) then
        MageNuggets.lockFrames = true;
    else
        MageNuggets.lockFrames = false;
    end
end

function ConsoleTextToggle()
    local ctChecked = MageNugOption2Frame_ConsoleTextCheckButton:GetChecked();
    if (ctChecked == true) then
        MageNuggets.consoleTextEnabled = false;
    else
        MageNuggets.consoleTextEnabled = true;
    end
end

function MNtoolTipToggle()
    local ttChecked = MageNugOption2Frame_CheckButtonTT:GetChecked();
    if (ttChecked == true) then
        MageNuggets.toolTips = true;
    else
        MageNuggets.toolTips = false;
    end
end


function MageNugArcaneBlastSize()
    local tempInt = MageNugOptionsFrame_Slider3:GetValue()

    if not MageNugOptionsFrame_Slider3._onsetting then
        MageNugOptionsFrame_Slider3._onsetting = true
        MageNugOptionsFrame_Slider3:SetValue(MageNugOptionsFrame_Slider3:GetValue())
        tempInt = MageNugOptionsFrame_Slider3:GetValue()
        MageNugOptionsFrame_Slider3._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugNova_Frame:SetScale(0.7);
        MageNugAB_Frame:SetScale(0.7);
        MageNuggets.arcaneBlastSize = 0;
    elseif (tempInt == 1) then
        MageNugNova_Frame:SetScale(0.8);
        MageNugAB_Frame:SetScale(0.8);
        MageNuggets.arcaneBlastSize = 1;
    elseif (tempInt == 2) then
        MageNugNova_Frame:SetScale(0.9);
        MageNugAB_Frame:SetScale(0.9);
        MageNuggets.arcaneBlastSize = 2;
    elseif (tempInt == 3) then
        MageNugNova_Frame:SetScale(1.0);
        MageNugAB_Frame:SetScale(1.0);
        MageNuggets.arcaneBlastSize = 3;
    elseif (tempInt == 4) then
        MageNugNova_Frame:SetScale(1.1);
        MageNugAB_Frame:SetScale(1.1);
        MageNuggets.arcaneBlastSize = 4;
    elseif (tempInt == 5) then
        MageNugNova_Frame:SetScale(1.2);
        MageNugAB_Frame:SetScale(1.2);
        MageNuggets.arcaneBlastSize = 5;
    elseif (tempInt == 6) then
        MageNugNova_Frame:SetScale(1.3);
        MageNugAB_Frame:SetScale(1.3);
        MageNuggets.arcaneBlastSize = 6;
    elseif (tempInt == 7) then
        MageNugNova_Frame:SetScale(1.5);
        MageNugAB_Frame:SetScale(1.5);
        MageNuggets.arcaneBlastSize = 7;
    elseif (tempInt == 8) then
        MageNugNova_Frame:SetScale(1.7);
        MageNugAB_Frame:SetScale(1.7);
        MageNuggets.arcaneBlastSize = 8;
    elseif (tempInt == 9) then
        MageNugNova_Frame:SetScale(1.9);
        MageNugAB_Frame:SetScale(1.9);
        MageNuggets.arcaneBlastSize = 9;
    elseif (tempInt == 10) then
        MageNugNova_Frame:SetScale(2.1);
        MageNugAB_Frame:SetScale(2.1);
        MageNuggets.arcaneBlastSize = 10;
    end
end
--
function updatePortalMenu(self, elapsed)
    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > 0.1) then
        local startTime, duration, enable = GetItemCooldown(6948);
        local hearthCooldown = startTime + duration - GetTime();
        if(hearthCooldown <= 0)then
            hearthCooldown = '';
            MageNugHordeFrameText3:SetText("");
            MageNugAlliFrameText3:SetText("");
        elseif(hearthCooldown > 60)then
            hearthCooldown = hearthCooldown / 60;
            MageNugHordeFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."m");
            MageNugAlliFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."m");
        else
            MageNugHordeFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."s");
            MageNugAlliFrameText3:SetText("|cffffffff"..RoundZero(hearthCooldown).."s");
        end


        local ghTime, ghDuration, ghenable = GetItemCooldown(110560);
        local garrisonHearthCooldown = RoundZero(ghTime + ghDuration - GetTime());
        if(garrisonHearthCooldown <= 0)then
            garrisonHearthCooldown = '';
            MageNugHordeFrameText4:SetText("");
            MageNugAlliFrameText4:SetText("");
        elseif(garrisonHearthCooldown > 60)then
            garrisonHearthCooldown = garrisonHearthCooldown / 60;
            MageNugHordeFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."m");
            MageNugAlliFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."m");
        else
            MageNugHordeFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."s");
            MageNugAlliFrameText4:SetText("|cffffffff"..RoundZero(garrisonHearthCooldown).."s");
        end

        self.TimeSinceLastUpdate = 0;
    end
end
--
function loadMageNuggetVariables_OnLoadEvent()
     mnplayerClass, mnenglishClass = UnitClass("player");
    if((mnenglishClass == 'WARRIOR') or (mnenglishClass == 'MONK') or (mnenglishClass == 'DEMONHUNTER') or (mnenglishClass == 'ROGUE') or (mnenglishClass == 'DEATHKNIGHT') or (mnenglishClass == 'PALADIN') or (mnenglishClass == 'HUNTER')) then
        MageNuggets.ssMonitorToggle = false;
        MageNuggets.igniteTog = false;
        MageNuggets.mageProcToggle = false;
        MageNuggets.camZoomTogg = false;
        MageNuggets.mirrorImageToggle = false;
        MageNuggets.procMonitorToggle = false;
        MageNuggets.consoleTextEnabled = false;
        MageNuggets.arcaneBlastToggle = false;
        MageNuggets.minimapToggle = false;
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'WARLOCK') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggets.igniteTog = false;
        MageNuggets.ssMonitorToggle = false;
        MageNuggets.mageProcToggle = false;
        MageNuggets.mirrorImageToggle = false;
        MageNuggets.procMonitorToggle = false;
        MageNuggets.minimapToggle = false;
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'SHAMAN')then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggets.igniteTog = false;
        MageNuggets.mageProcToggle = false;
        MageNuggets.mirrorImageToggle = false;
        MageNuggets.procMonitorToggle = false;
        MageNuggets.minimapToggle = false;
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
        MNSpellSteal_FrameTitleText:SetText("|cffffffffPURGEABLE")
    end
    if(mnenglishClass == 'PRIEST') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggets.igniteTog = false;
        MNSpellSteal_FrameTitleText:SetText("|cff33ccffD I S P E L");
        MageNuggets.mageProcToggle = false;
        MageNuggets.mirrorImageToggle = false;
        MageNuggets.procMonitorToggle = false;
        MageNuggets.minimapToggle = false;
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide()
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
    end
    if(mnenglishClass == 'DRUID') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! Some Options Disabled (Class:"..UnitClass("Player")..")")
        MageNuggets.igniteTog = false;
        MageNuggets.ssMonitorToggle = false;
        MageNuggets.mirrorImageToggle = false;
        MageNuggets.minimapToggle = false;
        if(MageNuggets.moonkinCombat == true) then
            MageNugMoonkin_Frame:Hide();
            MNmoonFire_Frame:Hide();
            MNinsectSwarm_Frame:Hide();
            MNstarSurge_Frame:Hide();
        else
            if (MageNuggets.moonkinTog == false) or (MageNuggets.moonkinTog == nil) then
                MageNugMoonkin_Frame:Show();
                MNmoonFire_Frame:Show();
                MNinsectSwarm_Frame:Show();
                MNstarSurge_Frame:Show();
            end
        end
        if (MageNuggets.moonkinMin == true) then
            MageNugMoonkin_Frame_Texture:Hide();
        end
    end
    if(mnenglishClass == 'MAGE') then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF".."Mage".."|cff00FF00".."Nuggets".."|cffffffff "..magenugVer.." loaded! (Use: /magenuggets options)")
        MageNuggets.moonkinTog = true;
        MageNugMoonkin_Frame:Hide();
        MNmoonFire_Frame:Hide();
        MNinsectSwarm_Frame:Hide();
        MNstarSurge_Frame:Hide();
        MNSpellSteal_FrameTitleText:SetText("|cff33ccffS P E L L S T E A L");
        MNSpellStealFocus_FrameTitleText:SetText("|cff33ccffFOCUS SPELLSTEAL");
    end

    MageNugMoonkinToggle_FrameText:SetText("|cff00BFFF".."Mage".."|cff00FF00".." Nuggets")
    MageNugCauterizeFrame:Hide();
    if(MageNuggets.abCastTimeToggle == true) then
        MNabCast_Frame:Show();
    else
        MNabCast_Frame:Hide();
    end

end

----------------------------------------------------------------------------------------
--                              SAVE FRAMES                                           --
----------------------------------------------------------------------------------------
MageNuggets_Frames = {
    ignite_point = "CENTER";
    ignite_relativePoint = "CENTER";
    ignite_xOfs = 0;
    ignite_yOfs = 0;
    frostbomb_point = "CENTER";
    frostbomb_relativePoint = "CENTER";
    frostbomb_xOfs = 0;
    frostbomb_yOfs = 0;
    hs_point = "CENTER";
    hs_relativePoint = "CENTER";
    hs_xOfs = 0;
    hs_yOfs = 0;
    hu_point = "CENTER";
    hu_relativePoint = "CENTER";
    hu_xOfs = 0;
    hu_yOfs = 0;
    caut_point = "CENTER";
    caut_relativePoint = "CENTER";
    caut_xOfs = 0;
    caut_yOfs = 0;
    ab_point = "CENTER";
    ab_relativePoint = "CENTER";
    ab_xOfs = 0;
    ab_yOfs = 0;
    poly_point = "CENTER";
    poly_relativePoint = "CENTER";
    poly_xOfs = 0;
    poly_yOfs = 0;
    mb_point = "CENTER";
    mb_relativePoint = "CENTER";
    mb_xOfs = 0;
    mb_yOfs = 0;
    fof_point = "CENTER";
    fof_relativePoint = "CENTER";
    fof_xOfs = 0;
    fof_yOfs = 0;
    bf_point = "CENTER";
    bf_relativePoint = "CENTER";
    bf_xOfs = 0;
    bf_yOfs = 0;
    spellsteal_point = "CENTER";
    spellsteal_relativePoint = "CENTER";
    spellsteal_xOfs = 0;
    spellsteal_yOfs = 0;
    spellstealfocus_point = "CENTER";
    spellstealfocus_relativePoint = "CENTER";
    spellstealfocus_xOfs = 0;
    spellstealfocus_yOfs = 0;
    mi_point = "CENTER";
    mi_relativePoint = "CENTER";
    mi_xOfs = 0;
    mi_yOfs = 0;
    cautTimer_point = "CENTER";
    cautTimer_relativePoint = "CENTER";
    cautTimer_xOfs = 0;
    cautTimer_yOfs = 0;
}

function MageNugz_SaveFrame_Position()
    MageNuggets_Frames.ignite_point, _, MageNuggets_Frames.ignite_relativePoint, MageNuggets_Frames.ignite_xOfs, MageNuggets_Frames.ignite_yOfs = MageNugIgnite_Frame:GetPoint();
    MageNuggets_Frames.hs_point, _, MageNuggets_Frames.hs_relativePoint, MageNuggets_Frames.hs_xOfs, MageNuggets_Frames.hs_yOfs = MageNugProcFrame:GetPoint();
    MageNuggets_Frames.hu_point, _, MageNuggets_Frames.hu_relativePoint, MageNuggets_Frames.hu_xOfs, MageNuggets_Frames.hu_yOfs = MageNugProcHUFrame:GetPoint();
    MageNuggets_Frames.caut_point, _, MageNuggets_Frames.caut_relativePoint, MageNuggets_Frames.caut_xOfs, MageNuggets_Frames.caut_yOfs = MageNugCauterizeFrame:GetPoint();
    MageNuggets_Frames.ab_point, _, MageNuggets_Frames.ab_relativePoint, MageNuggets_Frames.ab_xOfs, MageNuggets_Frames.ab_yOfs = MageNugAB_Frame:GetPoint();
    MageNuggets_Frames.poly_point, _, MageNuggets_Frames.poly_relativePoint, MageNuggets_Frames.poly_xOfs, MageNuggets_Frames.poly_yOfs = MageNugPolyFrame:GetPoint();
    MageNuggets_Frames.mb_point, _, MageNuggets_Frames.mb_relativePoint, MageNuggets_Frames.mb_xOfs, MageNuggets_Frames.mb_yOfs = MageNugMBProcFrame:GetPoint();
    MageNuggets_Frames.fof_point, _, MageNuggets_Frames.fof_relativePoint, MageNuggets_Frames.fof_xOfs, MageNuggets_Frames.fof_yOfs = MageNugFoFProcFrame:GetPoint();
    MageNuggets_Frames.bf_point, _, MageNuggets_Frames.bf_relativePoint, MageNuggets_Frames.bf_xOfs, MageNuggets_Frames.bf_yOfs = MageNugBFProcFrame:GetPoint();
    MageNuggets_Frames.spellsteal_point, _, MageNuggets_Frames.spellsteal_relativePoint, MageNuggets_Frames.spellsteal_xOfs, MageNuggets_Frames.spellsteal_yOfs = MNSpellSteal_Frame:GetPoint();
    MageNuggets_Frames.spellstealfocus_point, _, MageNuggets_Frames.spellstealfocus_relativePoint, MageNuggets_Frames.spellstealfocus_xOfs, MageNuggets_Frames.spellstealfocus_yOfs = MNSpellStealFocus_Frame:GetPoint();
    MageNuggets_Frames.mi_point, _, MageNuggets_Frames.mi_relativePoint, MageNuggets_Frames.mi_xOfs, MageNuggets_Frames.mi_yOfs = MageNugMI_Frame:GetPoint();
    MageNuggets_Frames.cautTimer_point, _, MageNuggets_Frames.cautTimer_relativePoint, MageNuggets_Frames.cautTimer_xOfs, MageNuggets_Frames.cautTimer_yOfs = MageNugCauterize_Frame:GetPoint();
end


function MageNugz_SetFrame_Positions()
    loadMageNuggetOptionsVariables_OnLoadEvent();
    MageNugIgnite_Frame:ClearAllPoints();
    MageNugIgnite_Frame:SetPoint(MageNuggets_Frames.ignite_point, "UIParent", MageNuggets_Frames.ignite_relativePoint, MageNuggets_Frames.ignite_xOfs, MageNuggets_Frames.ignite_yOfs);
    MageNugProcFrame:ClearAllPoints();
    MageNugProcFrame:SetPoint(MageNuggets_Frames.hs_point, "UIParent", MageNuggets_Frames.hs_relativePoint, MageNuggets_Frames.hs_xOfs, MageNuggets_Frames.hs_yOfs);
    MageNugProcHUFrame:ClearAllPoints();
    MageNugProcHUFrame:SetPoint(MageNuggets_Frames.hu_point, "UIParent", MageNuggets_Frames.hu_relativePoint, MageNuggets_Frames.hu_xOfs, MageNuggets_Frames.hu_yOfs);
    MageNugCauterizeFrame:ClearAllPoints();
    MageNugCauterizeFrame:SetPoint(MageNuggets_Frames.caut_point, "UIParent", MageNuggets_Frames.caut_relativePoint, MageNuggets_Frames.caut_xOfs, MageNuggets_Frames.caut_yOfs);
    MageNugAB_Frame:ClearAllPoints();
    MageNugAB_Frame:SetPoint(MageNuggets_Frames.ab_point, "UIParent", MageNuggets_Frames.ab_relativePoint, MageNuggets_Frames.ab_xOfs, MageNuggets_Frames.ab_yOfs);
    MageNugPolyFrame:ClearAllPoints();
    MageNugPolyFrame:SetPoint(MageNuggets_Frames.poly_point, "UIParent", MageNuggets_Frames.poly_relativePoint, MageNuggets_Frames.poly_xOfs, MageNuggets_Frames.poly_yOfs);
    MageNugMBProcFrame:ClearAllPoints();
    MageNugMBProcFrame:SetPoint(MageNuggets_Frames.mb_point, "UIParent", MageNuggets_Frames.mb_relativePoint, MageNuggets_Frames.mb_xOfs, MageNuggets_Frames.mb_yOfs);
    MageNugFoFProcFrame:ClearAllPoints();
    MageNugFoFProcFrame:SetPoint(MageNuggets_Frames.fof_point, "UIParent", MageNuggets_Frames.fof_relativePoint, MageNuggets_Frames.fof_xOfs, MageNuggets_Frames.fof_yOfs);
    MageNugBFProcFrame:ClearAllPoints();
    MageNugBFProcFrame:SetPoint(MageNuggets_Frames.bf_point, "UIParent", MageNuggets_Frames.bf_relativePoint, MageNuggets_Frames.bf_xOfs, MageNuggets_Frames.bf_yOfs);
    MNSpellSteal_Frame:ClearAllPoints();
    MNSpellSteal_Frame:SetPoint(MageNuggets_Frames.spellsteal_point, "UIParent", MageNuggets_Frames.spellsteal_relativePoint, MageNuggets_Frames.spellsteal_xOfs, MageNuggets_Frames.spellsteal_yOfs);
    MNSpellStealFocus_Frame:ClearAllPoints();
    MNSpellStealFocus_Frame:SetPoint(MageNuggets_Frames.spellstealfocus_point, "UIParent", MageNuggets_Frames.spellstealfocus_relativePoint, MageNuggets_Frames.spellstealfocus_xOfs, MageNuggets_Frames.spellstealfocus_yOfs);
    MNSpellSteal_Frame:ClearAllPoints();
    MNSpellSteal_Frame:SetPoint(MageNuggets_Frames.spellsteal_point, "UIParent", MageNuggets_Frames.spellsteal_relativePoint, MageNuggets_Frames.spellsteal_xOfs, MageNuggets_Frames.spellsteal_yOfs);
    MageNugMI_Frame:ClearAllPoints();
    MageNugMI_Frame:SetPoint(MageNuggets_Frames.mi_point, "UIParent", MageNuggets_Frames.mi_relativePoint, MageNuggets_Frames.mi_xOfs, MageNuggets_Frames.mi_yOfs);
    MageNugCauterize_Frame:ClearAllPoints();
    MageNugCauterize_Frame:SetPoint(MageNuggets_Frames.cautTimer_point, "UIParent", MageNuggets_Frames.cautTimer_relativePoint, MageNuggets_Frames.cautTimer_xOfs, MageNuggets_Frames.cautTimer_yOfs);
end

function CombatText_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."Checking this will disable all notifications sent to".." \n".."the chat console. This includes polymorph, evocation,".." \n".."spellsteal notifications and all other chat console notifications.")
  GameTooltip:Show()
end

function MNLockFrames(self)
    if (MageNuggets.lockFrames == false)then
       self:StartMoving(); self.isMoving = true;
    end
end

function MageNugz_MinimapButton_Move()
	MageNug_MinimapFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MageNuggets.MinimapPos)),(80*sin(MageNuggets.MinimapPos))-52)
end

function MageNugz_MinimapButton_DraggingFrame_OnUpdate()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
	xpos = xmin-xpos/UIParent:GetScale()+70
  ypos = ypos/UIParent:GetScale()-ymin-70
	MageNuggets.MinimapPos = math.deg(math.atan2(ypos,xpos))
  MageNugz_MinimapButton_Move()
end

function MageNugz_Minimap_OnClick()
    local englishFaction, localizedFaction = UnitFactionGroup("player")
    if (englishFaction == "Horde")then
        MageNugHordeFrame:Show();
    elseif (englishFaction == "Alliance") then
        MageNugAlliFrame:Show();
    end
end

function MNRecallFrames()
        MNSpellStealFocus_Frame:SetClampedToScreen(true);
        MageNugIgnite_Frame:SetClampedToScreen(true);
        MageNugCauterize_Frame:SetClampedToScreen(true);
        MageNugAB_Frame:SetClampedToScreen(true);
        MNabCast_Frame:SetClampedToScreen(true);
        MageNugProcFrame:SetClampedToScreen(true);
        MageNugPolyFrame:SetClampedToScreen(true);
        MageNugBFProcFrame:SetClampedToScreen(true);
        MageNugMBProcFrame:SetClampedToScreen(true);
        MageNugFoFProcFrame:SetClampedToScreen(true);
        MNSpellSteal_Frame:SetClampedToScreen(true);
        MageNugMI_Frame:SetClampedToScreen(true);
        MageNugMoonkin_Frame:SetClampedToScreen(true);
        MNmoonFire_Frame:SetClampedToScreen(true);
        MNinsectSwarm_Frame:SetClampedToScreen(true);
        MNstarSurge_Frame:SetClampedToScreen(true);
end


function  MageNugCauterizeSize() -- Cauterize Slider
    local tempInt = MageNugOptionsFrame_Slider5:GetValue()

    if not MageNugOptionsFrame_Slider5._onsetting then
        MageNugOptionsFrame_Slider5._onsetting = true
        MageNugOptionsFrame_Slider5:SetValue(MageNugOptionsFrame_Slider5:GetValue())
        tempInt = MageNugOptionsFrame_Slider5:GetValue()
        MageNugOptionsFrame_Slider5._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugCauterizeFrame:SetScale(0.7);
        MageNuggets.cautSize = 0;
    elseif (tempInt == 1) then
        MageNugCauterizeFrame:SetScale(0.8);
        MageNuggets.cautSize = 1;
    elseif (tempInt == 2) then
        MageNugCauterizeFrame:SetScale(0.9);
        MageNuggets.cautSize = 2;
    elseif (tempInt == 3) then
        MageNugCauterizeFrame:SetScale(1.0);
        MageNuggets.cautSize = 3;
    elseif (tempInt == 4) then
        MageNugCauterizeFrame:SetScale(1.2);
        MageNuggets.cautSize = 4;
    elseif (tempInt == 5) then
        MageNugCauterizeFrame:SetScale(1.4);
        MageNuggets.cautSize = 5;
    elseif (tempInt == 6) then
        MageNugCauterizeFrame:SetScale(1.6);
        MageNuggets.cautSize = 6;
    end
end



function  MageNugSSMonitorSize() -- SS Slider
    local tempInt = MageNugOptionsFrame_Slider2:GetValue()

    if not MageNugOptionsFrame_Slider2._onsetting then
        MageNugOptionsFrame_Slider2._onsetting = true
        MageNugOptionsFrame_Slider2:SetValue(MageNugOptionsFrame_Slider2:GetValue())
        tempInt = MageNugOptionsFrame_Slider2:GetValue()
        MageNugOptionsFrame_Slider2._onsetting = false
    else return end

    if (tempInt == 0) then
        MNSpellSteal_Frame:SetScale(0.7);
        MageNuggets.ssMonitorSize = 0;
    elseif (tempInt == 1) then
        MNSpellSteal_Frame:SetScale(0.8);
        MageNuggets.ssMonitorSize = 1;
    elseif (tempInt == 2) then
        MNSpellSteal_Frame:SetScale(0.9);
        MageNuggets.ssMonitorSize = 2;
    elseif (tempInt == 3) then
        MNSpellSteal_Frame:SetScale(1.0);
        MageNuggets.ssMonitorSize = 3;
    elseif (tempInt == 4) then
        MNSpellSteal_Frame:SetScale(1.1);
        MageNuggets.ssMonitorSize = 4;
    elseif (tempInt == 5) then
        MNSpellSteal_Frame:SetScale(1.2);
        MageNuggets.ssMonitorSize = 5;
    elseif (tempInt == 6) then
        MNSpellSteal_Frame:SetScale(1.3);
        MageNuggets.ssMonitorSize = 6;
    end
end

function  MageNugProcMonitorSize() --Proc Slider
    local tempInt = MageNugOptionsFrame_Slider4:GetValue()

    if not MageNugOptionsFrame_Slider4._onsetting then
        MageNugOptionsFrame_Slider4._onsetting = true
        MageNugOptionsFrame_Slider4:SetValue(MageNugOptionsFrame_Slider4:GetValue())
        tempInt = MageNugOptionsFrame_Slider4:GetValue()
        MageNugOptionsFrame_Slider4._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugProcFrame:SetScale(0.7);
        MageNugMBProcFrame:SetScale(0.7);
        MageNugFoFProcFrame:SetScale(0.7);
        MageNugBFProcFrame:SetScale(0.7);
        MageNuggets.procMonitorSize = 0;
    elseif (tempInt == 1) then
        MageNugProcFrame:SetScale(0.8);
        MageNugMBProcFrame:SetScale(0.8);
        MageNugFoFProcFrame:SetScale(0.8);
        MageNugBFProcFrame:SetScale(0.8);
        MageNuggets.procMonitorSize = 1;
    elseif (tempInt == 2) then
        MageNugProcFrame:SetScale(0.9);
        MageNugMBProcFrame:SetScale(0.9);
        MageNugFoFProcFrame:SetScale(0.9);
        MageNugBFProcFrame:SetScale(0.9);
        MageNuggets.procMonitorSize = 2;
    elseif (tempInt == 3) then
        MageNugProcFrame:SetScale(1.0);
        MageNugMBProcFrame:SetScale(1.0);
        MageNugFoFProcFrame:SetScale(1.0);
        MageNugBFProcFrame:SetScale(1.0);
        MageNuggets.procMonitorSize = 3;
    elseif (tempInt == 4) then
        MageNugProcFrame:SetScale(1.1);
        MageNugMBProcFrame:SetScale(1.1);
        MageNugFoFProcFrame:SetScale(1.1);
        MageNugBFProcFrame:SetScale(1.1);
        MageNuggets.procMonitorSize = 4;
    elseif (tempInt == 5) then
        MageNugProcFrame:SetScale(1.2);
        MageNugMBProcFrame:SetScale(1.2);
        MageNugFoFProcFrame:SetScale(1.2);
        MageNugBFProcFrame:SetScale(1.2);
        MageNuggets.procMonitorSize = 5;
    elseif (tempInt == 6) then
        MageNugProcFrame:SetScale(1.3);
        MageNugMBProcFrame:SetScale(1.3);
        MageNugFoFProcFrame:SetScale(1.3);
        MageNugBFProcFrame:SetScale(1.3);
        MageNuggets.procMonitorSize = 6;
    end
end

function MageNugPolyFrameSize()
    local tempInt = MageNugOptionsFrame_Slider1:GetValue()

    if not MageNugOptionsFrame_Slider1._onsetting then
        MageNugOptionsFrame_Slider1._onsetting = true
        MageNugOptionsFrame_Slider1:SetValue(MageNugOptionsFrame_Slider1:GetValue())
        tempInt = MageNugOptionsFrame_Slider1:GetValue()
        MageNugOptionsFrame_Slider1._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugPolyFrame:SetScale(0.7);
        MageNuggets.polyFrameSize = 0;
    elseif (tempInt == 1) then
        MageNugPolyFrame:SetScale(0.8);
        MageNuggets.polyFrameSize = 1;
    elseif (tempInt == 2) then
        MageNugPolyFrame:SetScale(0.9);
        MageNuggets.polyFrameSize = 2;
    elseif (tempInt == 3) then
        MageNugPolyFrame:SetScale(1.0);
        MageNuggets.polyFrameSize = 3;
    elseif (tempInt == 4) then
        MageNugPolyFrame:SetScale(1.2);
        MageNuggets.polyFrameSize = 4;
    elseif (tempInt == 5) then
        MageNugPolyFrame:SetScale(1.4);
        MageNuggets.polyFrameSize = 5;
    elseif (tempInt == 6) then
        MageNugPolyFrame:SetScale(1.6);
        MageNuggets.polyFrameSize = 6;
    end
end



function Tab2_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF".."Messages are picked at random.")
  GameTooltip:Show()
end

function Monitors_OnEnter()
  if (MageNuggets.toolTips == true) then
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can disable or resize this".." \n".."monitor in options.")
    GameTooltip:Show()
    end
end

function SPMonitor_OnEnter()
    if (MageNuggets.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."You can customize or disable this".." \n".."monitor in options.")
        GameTooltip:Show()
    end
end

function MNcooldownOnEnter()
     if (MageNuggets.toolTips == true) then
        GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
        GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."See Mage Nuggets Options -> Cooldowns")
        GameTooltip:Show()
    end
end

-------------------------------------------------------------------------------
---------------------------------Fire Nuggets----------------------------------
-------------------------------------------------------------------------------

function MNFireNuggetSimpleUiToggle()
  local isChecked = MageNugFireNugOptionFrame_SimpleUiCheckButton:GetChecked();
  if (isChecked == true) then
    MageNugIgnite_FrameTexture:SetTexture('')
    MageNugIgnite_FrameTexture2:SetTexture('')
    MageNugIgnite_FrameTexture3:SetTexture('')
    MageNugIgnite_FrameCombustionTexture:SetPoint("CENTER",-37,0);
    MageNugIgnite_FrameCombustionTexture:SetSize(35,35);
    MageNugIgnite_FramePhenonixFlamesTexture:SetPoint("CENTER",37,0);
    MageNugIgnite_FramePhenonixFlamesTexture:SetSize(35,35);
    MageNuggets.fireNugSimpleUiToggle = true;
  else
    MageNugIgnite_FrameCombustionTexture:SetPoint("CENTER",-40,0);
    MageNugIgnite_FrameCombustionTexture:SetSize(28,28);
    MageNugIgnite_FramePhenonixFlamesTexture:SetPoint("CENTER",40,0);
    MageNugIgnite_FramePhenonixFlamesTexture:SetSize(28,28);
    MageNuggets.fireNugSimpleUiToggle = false;
  end
end

function MNigniteToggle()
    local isChecked = MageNugFireNugOptionFrame_IgniteCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.igniteTog = true;
    else
        MageNuggets.igniteTog = false;
    end
end

function MNFireNuggetNotifyBorderToggle()
    local isChecked = MageNugFireNugOptionFrame_NotifyCheckButton:GetChecked();
    if (isChecked == true) then
        MageNuggets.FireNuggetNotifyBorderToggle = true;
    else
        MageNuggets.FireNuggetNotifyBorderToggle = false;
    end
end


function MageNugFireNugSize()
    local tempInt = MageNugFireNugOptionFrame_SizeSlider:GetValue()
    if not MageNugFireNugOptionFrame_SizeSlider._onsetting then
        MageNugFireNugOptionFrame_SizeSlider._onsetting = true
        MageNugFireNugOptionFrame_SizeSlider:SetValue(MageNugFireNugOptionFrame_SizeSlider:GetValue())
        tempInt = MageNugFireNugOptionFrame_SizeSlider:GetValue()
        MageNugFireNugOptionFrame_SizeSlider._onsetting = false
    else return end

    if (tempInt == 0) then
        MageNugIgnite_Frame:SetScale(0.7);
        MageNuggets.fireNuggetSize = 0;
    elseif (tempInt == 1) then
        MageNugIgnite_Frame:SetScale(0.8);
        MageNuggets.fireNuggetSize = 1;
    elseif (tempInt == 2) then
        MageNugIgnite_Frame:SetScale(0.9);
        MageNuggets.fireNuggetSize = 2;
    elseif (tempInt == 3) then
        MageNugIgnite_Frame:SetScale(1.0);
        MageNuggets.fireNuggetSize = 3;
    elseif (tempInt == 4) then
        MageNugIgnite_Frame:SetScale(1.1);
        MageNuggets.fireNuggetSize = 4;
    elseif (tempInt == 5) then
        MageNugIgnite_Frame:SetScale(1.2);
        MageNuggets.fireNuggetSize = 5;
    elseif (tempInt == 6) then
        MageNugIgnite_Frame:SetScale(1.3);
        MageNuggets.fireNuggetSize = 6;
    elseif (tempInt == 7) then
        MageNugIgnite_Frame:SetScale(1.5);
        MageNuggets.fireNuggetSize = 7;
    elseif (tempInt == 8) then
        MageNugIgnite_Frame:SetScale(1.7);
        MageNuggets.fireNuggetSize = 8;
    elseif (tempInt == 9) then
        MageNugIgnite_Frame:SetScale(1.9);
        MageNuggets.fireNuggetSize = 9;
    elseif (tempInt == 10) then
        MageNugIgnite_Frame:SetScale(2.1);
        MageNuggets.fireNuggetSize = 10;
    elseif (tempInt == 11) then
        MageNugIgnite_Frame:SetScale(2.5);
        MageNuggets.fireNuggetSize = 10;
    end
end

function MageNugFireNugBorder()
    local tempInt = MageNugFireNugOptionFrame_BorderSlider:GetValue()

    if not MageNugFireNugOptionFrame_BorderSlider._onsetting then
        MageNugFireNugOptionFrame_BorderSlider._onsetting = true
        MageNugFireNugOptionFrame_BorderSlider:SetValue(MageNugFireNugOptionFrame_BorderSlider:GetValue())
        tempInt = MageNugFireNugOptionFrame_BorderSlider:GetValue()
        MageNugFireNugOptionFrame_BorderSlider._onsetting = false
    else return end

    if (tempInt == 0) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Generic1Player_Circular_Frame")
      MageNuggets.fireNuggetBorder = 0;
    elseif (tempInt == 1) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Atramedes_Circular_Frame")
      MageNuggets.fireNuggetBorder = 1;
    elseif (tempInt == 2) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Horde_Circular_Frame")
      MageNuggets.fireNuggetBorder = 2;
    elseif (tempInt == 3) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Alliance_Circular_Frame")
      MageNuggets.fireNuggetBorder = 3;
    elseif (tempInt == 4) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Mechanical_Circular_Frame")
      MageNuggets.fireNuggetBorder = 4;
    elseif (tempInt == 5) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\MetalBronze_Circular_Frame")
      MageNuggets.fireNuggetBorder = 5;
    elseif (tempInt == 6) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\MetalEternium_Circular_Frame")
      MageNuggets.fireNuggetBorder = 6;
    elseif (tempInt == 7) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\StoneTan_Circular_Frame")
      MageNuggets.fireNuggetBorder = 7;
    elseif (tempInt == 8) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\WoodBoards_Circular_Frame")
      MageNuggets.fireNuggetBorder = 8;
    elseif (tempInt == 9) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame")
      MageNuggets.fireNuggetBorder = 9;
    elseif (tempInt == 10) then
      MageNugIgnite_FrameTexture:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNugIgnite_FrameTexture2:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNugIgnite_FrameTexture3:SetTexture("Interface\\UNITPOWERBARALT\\Meat_Circular_Frame")
      MageNuggets.fireNuggetBorder = 10;
    elseif (tempInt == 11) then
      MageNugIgnite_FrameTexture:SetTexture("")
      MageNugIgnite_FrameTexture2:SetTexture("")
      MageNugIgnite_FrameTexture3:SetTexture("")
      MageNuggets.fireNuggetBorder = 11;
    end
end

function MNFireBuggetBorderSliderTooltip()
  if(MageNuggets.fireNugSimpleUiToggle == true) then
    GameTooltip:SetOwner(MageNugFireNugOptionFrame_BorderSlider)
    GameTooltip:SetText("|cff00BFFF".."Mage".." |cff00CD00".."Nuggets"..":|cffFFFFFF ".."Please disable Simple UI to change the border.")
    GameTooltip:Show()
  end
end
