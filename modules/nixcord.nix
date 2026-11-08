{ lib, inputs, pkgs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    # discord.enable = true;
    # discord.vencord.enable = true;
    discord.equicord.enable = true;

    # Equicord's QuickCSS
    quickCss = "@import url('https://raw.githubusercontent.com/Krammeth/css-snippets/refs/heads/main/PopoutsRevamped.css');\n@import url(https://davart154.github.io/Themes/Snippets/Simplified%20Panel%20Area/SimplifiedPanelArea.css);\n\n/* reduce context menu padding */\n.layer_da8173 > .menu_c1e9c4 {\n    min-width: 0;\n    width: 171px !important;\n    .scroller_c1e9c4 {\n        /* border margin */\n        margin: -4px;\n    }\n    .separator_c1e9c4 {\n        /* separator margin */\n        margin: 1px 8px !important;\n    }\n    .wrapper_f563df {\n        /* reactions margin */\n        padding: 0px !important;\n        margin: 1px;\n    }\n    .item_c1e9c4 {\n        /* min-height is 32px as default, change value for desired look */\n        min-height: 0;\n        /* padding is 4px 8px as default, change value for desired look */\n        padding: 4px 8px;\n    }\n    .icon_f563df {\n        /* reactions size */\n        width: 18px;\n    }\n    .button_f563df {\n        /* reactions border size */\n        width: 36px;\n        height: 36px;\n        border-radius: 4px;\n    }\n    .icon_c1e9c4 {\n        /* icons size */\n        width: 18px;\n        height: 18px;\n    }\n    .iconContainer_c1e9c4 {\n        display: flex;\n        justify-content: center;\n        align-items: center;\n    }\n}\n\n";

    # Extensions configuration
    config = {
      useQuickCss = true;
      plugins = {
        accountPanelServerProfile.enable = true;
        altKrispSwitch.enable = true;
        alwaysExpandProfiles.enable = true;
        alwaysExpandRoles.enable = true;
        alwaysTrust.enable = true;
        betterBanReasons.enable = true;
        betterBlockedUsers.enable = true;
        betterCommands.enable = true;
        betterGifPicker.enable = true;
        betterInvites.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        blurNsfw.enable = true;
        bypassPinPrompt.enable = true;
        callTimer = {
          enable = true;
          allCallTimers = true;
          showWithoutHover = true;
          showRoleColor = true;
          trackSelf = true;
          showSeconds = true;
        };
        characterCounter.enable = true;
        cleanChannelName.enable = true;
        clearUrls.enable = true;
        clientTheme = {
          color = "202a46";
        };
        consoleJanitor.enable = true;
        consoleShortcuts.enable = true;
        copyFileContents.enable = true;
        copyUserUrls.enable = true;
        crashHandler.enable = true;
        customIdle = {
          enable = true;
          idleTimeout = 20.144404332129962;
          remainInIdle = false;
        };
        customTimestamps.enable = true;
        decodeBase64.enable = true;
        decor.enable = true;
        disableCallIdle.enable = true;
        disableDeepLinks.enable = true;
        equiTweaks = {
          enable = true;
          disableAdoptTagPrompt = true;
          disableHolidayNotifications = true;
          restoreFileDownloadButton = true;
          showAllBadges = true;
        };
        experiments.enable = true;
        expressionManager.enable = true;
        f8Break.enable = true;
        fakeNitro.enable = true;
        fastDeleteChannels.enable = true;
        findReply.enable = true;
        fixFileExtensions.enable = true;
        fixImagesQuality.enable = true;
        forceOwnerCrown.enable = true;
        friendCodes.enable = true;
        friendInvites.enable = true;
        friendshipRanks.enable = true;
        gameActivityToggle.enable = true;
        gitHubRepos.enable = true;
        globalBadges.enable = true;
        hideMedia.enable = true;
        homeTyping.enable = true;
        fixSpotifyEmbeds = {
          enable = true;
          volume = 10.0;
        };
        spotifyCrack = {
          enable = true;
        };
        ignoreCalls.enable = true;
        iLoveSpam.enable = true;
        imageZoom = {
          enable = true;
          size = 140.0;
          zoom = 2.8;
        };
        iRememberYou.enable = true;
        lastActive.enable = true;
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLinkEmbeds.enable = true;
        messageLogger.enable = true;
        messageLoggerEnhanced = {
          enable = true;
          imageCacheDir = "savedImages";
          logsDir = "";
        };
        moreCommands.enable = true;
        moreUserTags = {
          enable = true;
          tagSettings = {
            webhook = { };
            owner = { };
            administrator = { };
            moderatorStaff = { };
            moderator = { };
            voiceModerator = { };
            chatModerator = { };
          };
        };
        musicControls = {
          showSpotifyControls = true;
        };
        mutualGroupDms.enable = true;
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        noOnboardingDelay.enable = true;
        noPendingCount.enable = true;
        noProfileThemes.enable = true;
        noReplyMention.enable = true;
        normalizeMessageLinks.enable = true;
        notificationTitle.enable = true;
        notificationVolume = {
          enable = true;
          notificationVolume = 50.0;
        };
        noTypingAnimation.enable = true;
        noUnblockToJump.enable = true;
        onePingPerDm.enable = true;
        openInApp.enable = true;
        pauseInvitesForever.enable = true;
        permissionFreeWill.enable = true;
        permissionsViewer.enable = true;
        pinDms = {
          enable = true;
          userBasedCategoryList = {
            "749997239644061717" = [ ];
          };
        };
        pinIcon.enable = true;
        platformIndicators.enable = true;
        previewMessage.enable = true;
        quickMention.enable = true;
        relationshipNotifier.enable = true;
        reverseImageSearch.enable = true;
        searchFix.enable = true;
        sendTimestamps.enable = true;
        serverInfo.enable = true;
        serverListIndicators.enable = true;
        showAllMessageButtons.enable = true;
        showConnections.enable = true;
        showHiddenThings.enable = true;
        showMeYourName = {
          enable = true;
          memberList = false;
          includedNames = "{friend, nick} [{display}] (@{user})";
        };
        showTimeoutDuration.enable = true;
        silentMessageToggle.enable = true;
        sortFriends.enable = true;
        streamerModeOnStream.enable = true;
        themeLibrary = {
          enable = true;
          hideWarningCard = true;
        };
        title = {
          enable = true;
          title = "Discord";
        };
        typingTweaks.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        voiceChatDoubleClick.enable = true;
        voiceChatUtilities.enable = true;
        voiceDownload.enable = true;
        voiceMessages.enable = true;
        webContextMenus = {
          enable = true;
          addBack = true;
        };
        webKeybinds.enable = true;
        webScreenShareFixes.enable = true;
        whoReacted.enable = true;
        whosWatching.enable = true;
        youtubeAdblock.enable = true;
      };
    };

    # Extra configuration
    extraConfig = {
      plugins = {
        AllCallTimers = {
          enable = true;
          format = "stopwatch";
        };
        Anammox = {
          enable = true;
          dms = true;
          serverBoost = true;
          billing = true;
          gift = true;
          emojiList = true;
          quests = false;
        };
        AutoJump = {
          enable = true;
          autoJumping = false;
        };
        BetterNotesBox = {
          enable = true;
          hide = true;
          noSpellCheck = true;
        };
        characterCounter = {
          position = false;
        };
        customTimestamps = {
          sameDayFormat = "HH:mm:ss";
          lastDayFormat = "[yesterday] HH:mm:ss";
          lastWeekFormat = "ddd DD.MM.YYYY HH:mm:ss";
          sameElseFormat = "ddd DD.MM.YYYY HH:mm:ss";
          cozyFormat = "[calendar]";
          tooltipFormat = "LLLL • [relative]";
        };
        gitHubRepos = {
          showInMiniProfile = true;
          showRepositoryTab = true;
        };
        globalBadges = {
          showReplugged = true;
          showBunny = true;
          showGooseMod = true;
          showBetterDiscord = true;
          showVendroidEnhanced = true;
          showRevenge = true;
          showReCord = true;
          showModStyle = "none";
        };
        imageZoom = {
          showMetadata = true;
        };
        pinDms = {
          disableCreateDMButton = true;
        };
        remixRevived = {
          remixTag = true;
        };
        RPCStats = {
          assetURL = "";
          RPCTitle = "RPCStats";
          statDisplay = 0;
          lastFMApiKey = "";
          lastFMUsername = "";
          albumCoverImage = true;
          lastFMStatFormat = "Top album this week: \"$album - $artist\"";
        };
        showMeYourName = {
          voiceChannelList = false;
          emojiReactions = false;
          preferFriend = false;
          mode = "user-nick";
          displayNames = false;
          inReplies = false;
          showGradient = false;
          userProfilePopout = false;
        };
        SpotifyLyrics = {
          LyricsPosition = "below";
          LyricsConversion = "None";
          ShowMusicNoteOnNoLyrics = true;
          LyricDelay = 0;
          LyricsProvider = "Spotify";
        };
        VencordRPC = {
          enable = true;
          userAvatarAsSmallImage = false;
          exposeDmsUsername = false;
          type = 0;
          timestampMode = 0;
          secretStuff = "";
        };
      };
    };
  };
}
