<h1 align="center"><img src="https://github.com/pizzaboxer/bloxstrap/raw/main/Images/Bloxstrap.png" width="28"/> FastFlags Collective</h1>

<h3 align="center">https://discord.gg/Q5JKyzuNRC</h3>

<h6 align="center">https://discord.gg/fastflags</h6>

##### [3/23/2024]
* **113 Currently Listed**

## How to Use:
1. **Open the [Bloxstrap Menu](https://github.com/pizzaboxer/bloxstrap).**
2. **Navigate to `Fast Flags` >> `Fast Flags Editor` >> `Import Json`.**
3. **Paste in the JSON.**
4. **Save and you're good to go!**
<img src="/assets/tutorial.gif" width="750"/>

 # List Navigation
* **[Rendering](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#rendering)**
* **[Graphical](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#graphical-settings)**
* **[UI](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#user-interface)**
* **[Textures](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#textures)**
* **[Physics](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#physics)**
* **[Other FFlags](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#other-fflags)**
* **[Links](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#links)**

<img src="assets/images/bitdancer.png" width="888"/>

### 

<h3 align="center">══════⊹⊱≼≽⊰⊹══════</h3>

### FPS Unlocker in Roblox Menu Settings
```json
{ "FFlagGameBasicSettingsFramerateCap": "True", "DFIntTaskSchedulerTargetFps": "0" }
```

<h1 align="center">Rendering API</h1>

### Metal
###### MacOS Only
```json
{ "FFlagDebugGraphicsPreferMetal": "True" }
```
### Vulkan
```json
{ "FFlagDebugGraphicsDisableDirect3D11": "True", "FFlagDebugGraphicsPreferVulkan": "True" }
```
### OpenGL
```json
{ "FFlagDebugGraphicsDisableDirect3D11": "True", "FFlagDebugGraphicsPreferOpenGL": "True" }
```
### Direct X 10
```json
{ "FFlagDebugGraphicsPreferD3D11FL10": "True" }
```
### Direct X 11
```json
{ "FFlagDebugGraphicsPreferD3D11": "True" }
```

<h1 align="center">Graphical Settings <sup>& other stuff</sup></h1>

### Draws a circle under avatars
```json
{ "FFlagDebugAvatarChatVisualization": "True", "FFlagEnableInGameMenuChromeABTest2": "False" }
```
### Performance Mode
```json
{"DFFlagDebugPerfMode": "True"}
```
### Smoother Terrain
```json
{ "FFlagDebugRenderingSetDeterministic": "True" }
```
### Graphics Quality Level
```json
{ "FIntRomarkStartWithGraphicQualityLevel": "1" }
```
### Low Quallity Terrain Textures
###### 4 for less quality 16, 32, 64 for higher quality
```json
{ "FIntTerrainArraySliceSize": "4" }
```
### Disable Shadows
```json
{ "FIntRenderShadowIntensity": "0" }
```
### Preserve rendering quality with display setting
```json
{ "DFFlagDisableDPIScale": "True" }
```
### Low Graphics Quality w/ Max Render Distance/FRM Quality Levels
###### Explanation: 1-6 Are low graphics, Above 6 are high graphics. Like the 1-21 graphics slider
```json
{ "DFIntDebugFRMQualityLevelOverride": "1" }
```

<h4 align="center">FRM Levels</h4>

```
Low

1 = 3
2 = 2
3 = 6

High

4 = 7
5 = 11
6 = 14
7 = 15 
8 = 17
9 = 18
10 = 21
```

### Low Render Distance
###### [FRM](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#frm-levels)
```json
{ "DFIntDebugRestrictGCDistance": "1" }
```
### Disable Wind
```json
{ "FFlagGlobalWindRendering": "False", "FFlagGlobalWindActivated": "False" }
```
### Limits light updates
```json
{ "FIntRenderLocalLightUpdatesMax": "8", "FIntRenderLocalLightUpdatesMin": "6" }
```
### Disables fade in and fade out animation every light update
###### changes fade in ms!!
```json
{ "FIntRenderLocalLightFadeInMs": "0" }
```
### Makes avatars shiny 
###### [everything goes black on <3] ***[DFIntDebugFRMQualityLevelOverride is there to set your graphics to 10, You can change it to anything above 3: [Click here to view](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#frm-levels) ]***
```json
{ "DFIntRenderClampRoughnessMax": "-640000000", "DFIntDebugFRMQualityLevelOverride": "6" }
```
### Disable PostFX
```json
{ "FFlagDisablePostFx": "True" }
```
### Pause Voxelizer/Disable Baked Shadows
```json
{ "DFFlagDebugPauseVoxelizer": "True" }
```
### Gray Sky
###### Only works with games with default sky
```json
{ "FFlagDebugSkyGray": "True" }
```
### Disable Player Shadows
```json
{ "FIntRenderShadowIntensity": "0" }
```
### Force LOD on Meshes
```json
{ "DFIntCSGLevelOfDetailSwitchingDistance": "0", "DFIntCSGLevelOfDetailSwitchingDistanceL12": "0", "DFIntCSGLevelOfDetailSwitchingDistanceL23": "0", "DFIntCSGLevelOfDetailSwitchingDistanceL34": "0" }
```
### Lighting Attenuation
```json
{ "FFlagNewLightAttenuation": "True" }
```
### Enable GPULightCulling
###### Combine with [Lighting Attenuation](https://github.com/FastFlags/FastFlags-Collective/?tab=readme-ov-file#lighting-attenuation) for better vision
```json
{ "FFlagFastGPULightCulling3": "True" }
```
### Frame Buffer
###### Explnation: 0 makes white screen 1-3 makes other players have laggy movement, 4 is stable has better performance than 10 and less input lag
```json
{ "DFIntMaxFrameBufferSize": "4" }
```
### High Quality Textures 
###### *[1-3]*
```json
{ "DFFlagTextureQualityOverrideEnabled": "True", "DFIntTextureQualityOverride": "3" }
```
### Lower Quality Textures 
###### *[1-3]*
```json
{ "DFIntPerformanceControlTextureQualityBestUtility": "-1" }
```
### No player textures
```json
{ "DFIntTextureCompositorActiveJobs": "0" }
```
### Remove Grass
```json
{ "FIntFRMMinGrassDistance": "0", "FIntFRMMaxGrassDistance": "0", "FIntRenderGrassDetailStrands": "0", "FIntRenderGrassHeightScaler": "0" }
```
### Force MSAA 
###### *[0, 1, 2, 4, 8]*
```json
{ "FIntDebugForceMSAASamples": "4" }
```
### ShadowMap Bias 
###### ***[Future & ShadowMap]***
```json
{ "FIntRenderShadowmapBias": "75" }
```
### Enables Network Debug Tracker menu
##### Instructions: CTRL+F8
```json
{ "DFFlagDebugEnableInterpolationVisualizer": "True" }
```
### Humanoid Outline
##### Draws an outline around every part and every humanoid
```json
{ "DFFlagDebugDrawBroadPhaseAABBs": "True" }
```
### Buggy ZPlane Camera *<sup>a.k.a xray</sup>*
```json
{ "FIntCameraFarZPlane": "1" }
```
<h1 align="center">User Interface</h1>

### GUI Hiding Toggles
```json
{ "FFlagUserShowGuiHideToggles": "True", "GuiHidingApiSupport2": "True" }
```
### Darker Dark Theme
```json
{ "FFlagLuaAppUseUIBloxColorPalettes1":"True", "FFlagUIBloxUseNewThemeColorPalettes":"True" }
```
### Subscriptions Page
```json
{ "FFlagLuaAppDevSubsEnabled":"True" }
```
### No Transparency V4 Menu **(2023)**
```json
{ "FStringInGameMenuModernizationStickyBarForcedUserIds": "UserID" }
```
### Revert Old Report Menu
```json
{ "FStringReportAbuseMenuRoactForcedUserIds": "UserID_HERE", "FFlagEnableReportAbuseMenuRoactABTest2": "False", "FFlagEnableReportAbuseMenuRoact2": "False", "FFlagEnableReportAbuseMenuLayerOnV3": "False" }
```

### Custom MicroProfile Scale
```json
{ "DFIntMicroProfilerDpiScaleOverride": "100" }
```
### Hides gui
```json
{ "FFlagDebugAdornsDisabled": "True" }
```
### Dont Render UI
```json
{ "FFlagDebugDontRenderUI": "True" }
```
### Enable Audio Controller
```json
{ "FFlagTrackerLodControllerDebugUI": "True" }
```
### Disable Autocomplete
```json
{ "FFlagEnableCommandAutocomplete": "False" }
```
### Chrome UI TopBar
```json
{ "FFlagEnableInGameMenuChrome": "True", "FFlagEnableReportAbuseMenuRoactABTest2": "True", "FFlagChromeBetaFeature": "True", "FFlagEnableReportAbuseMenuRoactABTest2": "True" }
```
### Pin Chat on Chrome UI
```json
{ "FFlagEnableChromePinnedChat": "True" }
```
### Chrome UI Topbar Removal
```json
{ "FFlagChromeBetaFeature": "False", "FFlagEnableChromePinnedChat": "False", "FFlagEnableInGameMenuChrome": "False", "FFlagEnableInGameMenuChromeABTest2": "False", "FFlagEnableInGameMenuChromeSignalAPI": "False", "FFlagPlayerListChromePushdown": "False", "FFlagEnableReportAbuseMenuRoactABTest2": "False" }
```
### Disable Bubble Chat
```json
{ "FFlagEnableBubbleChatFromChatService": "False" }
```
### Disable Selfview
```json
{ "FFlagCoreGuiTypeSelfViewPresent": "False" }
```
### Remove VC Beta Badge
```json
{ "FFlagVoiceBetaBadge": "False", "FFlagTopBarUseNewBadge": "False", "FFlagEnableBetaBadgeLearnMore": "False", "FFlagBetaBadgeLearnMoreLinkFormview": "False", "FFlagControlBetaBadgeWithGuac": "False", "FStringVoiceBetaBadgeLearnMoreLink": "null" }
```
### Hide guis
###### ***Instructions: Replace "ID" with any group ID that you are in.***
```json
{ "DFIntCanHideGuiGroupId": "ID_HERE" }
```
### Disable Fullscreen Title Bar
```json
{ "FIntFullscreenTitleBarTriggerDelayMillis": "3600000" }
```
### Set Custom Font Size
```json
{ "FIntFontSizePadding": "1" }
```

<h1 align="center">Textures</h1>

### Fix Textures
```json
{ "FFlagMSRefactor5": "False" }
```
### No Textures
```json
{
    "FStringPartTexturePackTable2022": "{\"glass\":{\"ids\":[\"rbxassetid://9873284556\",\"rbxassetid://9438453972\"],\"color\":[254,254,254,7]}}",
    "FStringPartTexturePackTablePre2022": "{\"glass\":{\"ids\":[\"rbxassetid://7547304948\",\"rbxassetid://7546645118\"],\"color\":[254,254,254,7]}}",
    "FStringTerrainMaterialTable2022": "",
    "FStringTerrainMaterialTablePre2022": ""
}
```
<h1 align="center">Physics</h1>


### arsenal fly glitch

![image](https://github.com/FastFlags/FastFlags-Collective/assets/159259392/ee3bfafa-5c6f-4cf5-92ed-bf6bbc597e77)

### real hitbox for real
```json
{
    "FFlagHumanoidParallelFixTickleFloor2_PlaceFilter": "True;2573981315;6317172524;4999654929;189707",
    "FFlagFixMemoryPriorizationCrash": "True",
    "FIntUGCValidationTorsoThresholdFront": "100",
    "FIntUGCValidationTorsoThresholdSide": "100",
    "FIntUGCValidationTorsoThresholdBack": "100",
    "FIntUGCValidationLeftArmThresholdBack": "23",
    "FIntUGCValidationLeftArmThresholdFront": "25",
    "FIntUGCValidationLeftArmThresholdSide": "40",
    "FIntUGCValidationLeftLegThresholdBack": "40",
    "FIntUGCValidationLeftLegThresholdFront": "40",
    "FIntUGCValidationLeftLegThresholdSide": "36",
    "FIntUGCValidationRightArmThresholdBack": "23",
    "FIntUGCValidationRightArmThresholdFront": "25",
    "FIntUGCValidationRightArmThresholdSide": "40",
    "FIntUGCValidationRightLegThresholdBack": "40",
    "FIntUGCValidationRightLegThresholdFront": "40",
    "FIntUGCValidationRightLegThresholdSide": "38"
}
```

### Remap animations from r6 to r15 rig 
```json
{ "FFlagRemapAnimationR6ToR15Rig": "True" }
```
### Disables PGS Solver
###### Projected Gauss-Seidel physics, or PGS physics, is a more reliable but more costly physics solver released in summer of 2015. The solver has a lot less "give" than spring physics, in terms of parts won't want to go into each other at all, making joints less flexible. This allows for parts to have less of a tendency to go through each other. As of October 21, 2015, the joints called glue joints are supported in the system, and will not break under pressure. The solver takes more processing power to work over spring physics, which will cause games to act slower. This solver runs at 240 Hz.
```json
{ "FFlagSimDefaultPGSSolver": "False" }
```
### rc car
###### https://www.roblox.com/bundles/63/Mage-Animation-Package
```json
{ "DFIntHipHeightClamp": "-48" }
```
### No Animations
```json
{ "DFIntReplicatorAnimationTrackLimitPerAnimator": "-1" }
```
### Stick unanchored parts to you
##### - = up, + = down
```json
{ "DFIntSolidFloorPercentForceApplication": "-1000", "DFIntNonSolidFloorPercentForceApplication": "-5000" }
```
### Max Raycast Distance
###### Raycasting is the use of intersection tests to solve problems in ROBLOX. The most common use of raycasting is to determine the first object intersected by a ray. This is done by casting a virtual ray from a certain point in a direction and determining the first surface it intersected with.
###### Break legs collision from 2 to -inf, kinda break camera on values over 3 noclip cam on 3
```json
{ "DFIntRaycastMaxDistance": "3" }
```
### Possible Super Jump
```json
{ "DFIntNewRunningBaseGravityReductionFactorHundredth": "1500" }
```
<!--
### Change DataSender Rate
###### a.k.a dos not let you load games
```json
{ "DFIntDataSenderRate": "-1" }
```
 -->
### Fake Lag
```json
{ "DFIntS2PhysicsSenderRate": "1" }
```
### Disable Touch Events
```json
{ "DFIntTouchSenderMaxBandwidthBps": "-1" }
```
### Invisible 1
```json
{ "DFIntS2PhysicsSenderRate": "-30" }
```
### Invisible 2
###### Sets your position to 0,0,0 for the server
```json
{ "DFIntGameNetPVHeaderTranslationZeroCutoffExponent": "10" }
```
### Invisible 3
```json
{ "DFIntPhysicsSenderMaxBandwidthBps": "1", "DFIntPhysicsSenderMaxBandwidthBpsScaling": "0" }
```
### Warp & Physics FPS cap
```json
{ "DFIntMaxMissedWorldStepsRemembered": "1" }
```
```json
{ "DFIntMaxMissedWorldStepsRemembered": "1000" }
```
### Noclip
###### adjust the value so u dont fall through the ground
```json
{ "DFFlagAssemblyExtentsExpansionStudHundredth": "-50" }
```
### Hip Height
###### Very controllable bounce, only works with negative values, 0 allows you to hover
```json
{ "DFIntMaxAltitudePDStickHipHeightPercent": "-200" }
```
### Wallglide
```json
{ "DFIntUnstickForceAttackInTenths": "-4" }
```

<h1 align="center">other fflags</h1>

### Disable In-game Advertisements
```json
{ "FFlagAdServiceEnabled": "False" }
```

### Disable Telemetry 
```json
{ "FFlagDebugDisableTelemetryEphemeralCounter": "True", "FFlagDebugDisableTelemetryEphemeralStat": "True", "FFlagDebugDisableTelemetryEventIngest": "True", "FFlagDebugDisableTelemetryPoint": "True", "FFlagDebugDisableTelemetryV2Counter": "True", "FFlagDebugDisableTelemetryV2Event": "True", "FFlagDebugDisableTelemetryV2Stat": "True" }
```
### Adjust Scroll Speed
```json
{ "FIntScrollWheelDeltaAmount": "140" }
```
### Surf the web inside of Roblox
###### Click the Beta badge or the 13+ badge to open the webview browser.
```json
{ "FFlagTopBarUseNewBadge": "True", "FStringTopBarBadgeLearnMoreLink": "https://google.com/", "FStringVoiceBetaBadgeLearnMoreLink": "https://google.com/" }
```
### Sounds use physical velocity and become distorted
###### <2017
```json
{ "FFlagSoundsUsePhysicalVelocity": "True" }
```
### Shows the state of a flag
```json
{ "FStringDebugShowFlagState": "FLAG_HERE" }
```
###### e.g
```json
{ "FStringDebugShowFlagState": "DFIntTaskSchedulerTargetFps, ChannelName" }
```
### MTU 
```json
{ "DFIntConnectionMTUSize": "MTU_HERE" }
```
### No Internet Disconnect 
###### *[You will still be kicked but the message wont show.]*
```json
{ "DFFlagDebugDisableTimeoutDisconnect": "True" }
```
### Quick Game Launch 
###### *[BUGGY]*
```json
{ "FFlagEnableQuickGameLaunch": "True" }
```
### Allows you to change voice chat distance 
###### default: [Min 7 Max 80]
```json
{ "DFIntVoiceChatRollOffMinDistance": "7", "DFIntVoiceChatRollOffMaxDistance": "80" }
```
### Disable In-Game Purchases
```json
{ "DFFlagOrder66": "True" }
```
### Disable Chat
```json
{ "FFlagDebugForceChatDisabled": "True" }
```
### Limit audios that are being played
```json
{ "DFIntMaxLoadableAudioChannelCount": "1" }
```
### Adds an UI in game, which highlights any part player touches (like ground, Meshes etc.). It's a non-functioning UI too. Also adds a blue circle to your humanoid.
```json
{ "FFlagDebugHumanoidRendering": "True" }
```
### Custom Disconnect Message
```json
{ "FFlagReconnectDisabled": "True", "FStringReconnectDisabledReason": "You're stupid and I hate you" }
```
### Display FPS
```json
{ "FFlagDebugDisplayFPS": "True" }
```
### Verified Badge
###### clientsided, no one else can see the badge
```json
{ "FStringWhitelistVerifiedUserId": "UserID_HERE" }
```
### Verified Badge on everyone
###### clientsided, no one else can see the badges
```json
{ "FFlagOverridePlayerVerifiedBadge": "True" }
```
### Applies cool colors to stuff
```json
{ "FFlagDebugDisplayUnthemedInstances": "True" }
```
### Show Outlined Chunks
```json
{ "FFlagDebugLightGridShowChunks": "True" }
```
### Remove Disconnect Blur/Loading Blur
```json
{ "FIntRobloxGuiBlurIntensity": "0" }
```
### Disable Dynamic Heads Animations
###### https://roblox.fandom.com/wiki/Dynamic_Head
```json
{ "DFIntAnimationLodFacsDistanceMin": "0", "DFIntAnimationLodFacsDistanceMax": "0", "DFIntAnimationLodFacsVisibilityDenominator": "0" }
```
### failsafehumanoid
###### gray avatars
```json
{ "FFlagFailsafeHumanoid_3": "True" }
```
### Automatically unmutes your mic on join (VC)
```json
{ "FFlagDebugDefaultChannelStartMuted": "False" }
```
### Overlay that shows what you type 
```json
{ "FFlagDebugTextBoxServiceShowOverlay": "True" }
```
### opt-out Experience Language
###### Removes the Experience Language option in settings
```json
{ "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0" }
```
### Disable New Chat Translation Settings
```json
{ "FFlagChatTranslationSettingEnabled3 ": "False" }
```
### Lets you change the zoom out limit
```json
{ "FIntCameraMaxZoomDistance": "9999" }
```
### Limits number of animations being played
```json
{ "DFIntMaxActiveAnimationTracks": "0" }
```
### Prevents Remote Events from running
```json
{ "DFIntRemoteEventSingleInvocationSizeLimit": "1" }
```
### Mess with voice chat volume
###### default 1000
```json
{ "DFIntVoiceChatVolumeThousandths": "100000" }
```
### Removes the head roll limit
```json
{ "DFIntAvatarFaceChatHeadRollLimitDegrees": "360" }
```
### VR Controller transparency
```json
{ "FIntVRTouchControllerTransparency": "0" }
```
### No sounds
```json
{ "FFlagDebugRomarkMockingAudioDevices": "True" }
```
### Max zoom distance
###### only works in some games that haven't changed the roblox default
```json
{ "FIntCameraMaxZoomDistance": "100000000" }
```
### Localhost
```json
{ "FFlagDebugLocalRccServerConnection": "100000000" }
```

<h1 align="center">Links</h1>

### [Make Your Own Custom Roblox Textures](https://github.com/GoingCrazyDude/roblox-custom-textures/blob/main/README.md) *[Github Repo Link]*
### [MEGA FLAG LIST](https://discord.com/channels/1099468797410283540/1139962301991104582/1170417533355036712) *[Bloxstrap Server]*
### [Bloxstrap](https://github.com/pizzaboxer/bloxstrap) *[Github Repo Link]*
### [NVIDIA Shaders Guide](https://github.com/catb0x/Roblox-Shaders-Guide) *[Github Repo Link]*
### [EnableAnselForRoblox](https://github.com/DED0026/EnableAnselForRoblox) *[Github Repo Link]*
### [potato fflags](https://github.com/catb0x/Roblox-Potato-FFlags) *[Github Repo Link]*
### [Fake Roblox Player Internal Patcher](https://github.com/vsvpp/Roblox-Player-Internal-Patcher/releases/download/window/cutestrap.exe) *[Download Link]*
### [Bindable Lag Switch](https://github.com/Hermivore8151/Bindable-LagSwitch) *[Download Link]*
### [RCOOL](https://github.com/vsvpp/RCOOL/) *[Github Repo Link]*

<h4 align="center">‧⁺̣˚̣̣*̣̩⋆̩·̩̩୨˚̣̣̣̣͙୧·̩̩⋆̩*̣̩˚̣̣⁺̣‧ You've reached the bottom of the list! ‧⁺̣˚̣̣*̣̩⋆̩·̩̩୨˚̣̣̣̣͙୧·̩̩⋆̩*̣̩˚̣̣⁺̣‧୨</h4>

# List Information
* Creation Date: 9:46 PM 08/25/2023 
* Github Publish Date: 12/26/2023
* Maintained by [dan](https://discord.com/users/457151128665194527), [variable](https://discord.com/users/848525666622373890), [popbob](https://discord.com/users/702054592262701127), [hermivore](https://discord.com/users/559811983512305693) & [kit](https://discord.com/users/761909750006022195)

[.](https://open.spotify.com/track/5dIkvSrG129dvaQ3xb0M9R)

###### creds to bloxstrap & rgc

<h3 align="center">FastFlags 2024®<sup>eal</sup></h3>
