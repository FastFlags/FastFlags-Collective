<h1 align="center"><img src="https://i.imgur.com/O5jfEFH.png" width="28"/> setfflag</h1>

<h3 align="center">https://discord.gg/Q5JKyzuNRC</h3>

<h6 align="center">https://discord.gg/fastflags</h6>

## How to Use:
### BUY KRAMPUS FROM [BloxProducts](https://bloxproducts.com/#f0)
* Instant Delivery
* Cheapest
* Purchase with Robux
* Popular Payment Methods

##### I bought krampus from here. It was instantly delivered to my spam (not even a minute)

<h3 align="center">══════⊹⊱≼≽⊰⊹══════</h3>

<h1 align="center">Graphical Settings <sup>& other stuff</sup></h1>

### Preserve rendering quality with display setting
```lua
setfflag("DisableDPIScale", "True")
```
### FRM Quality Levels
```lua
setfflag("DebugFRMQualityLevelOverride", "1")
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
###### [FRM](https://github.com/devstacking/Epic-Fast-Flags-List?tab=readme-ov-file#frm-levels)
```lua
setfflag("DebugRestrictGCDistance", "1")
```
### Makes avatars shiny 
```lua
setfflag("RenderClampRoughnessMax", "-640000000")
```
### Frame Buffer
###### Explnation, 0 makes white screen 1-3 makes other players have laggy movement, 4 is stable has better performance than 10 and less input lag
```lua
setfflag("MaxFrameBufferSize", "4")
```
### Lower Quality Textures 
###### *[1-3]*
```lua
setfflag("PerformanceControlTextureQualityBestUtility", "-1")
```
### Enables Network Debug Tracker menu
##### Instructions, CTRL+F8
```lua
setfflag("DebugEnableInterpolationVisualizer", "True")
```
### Humanoid Outline
##### Draws an outline around every part and every humanoid
```lua
setfflag("DebugDrawBroadPhaseAABBs", "True")
```
<h1 align="center">User Interface</h1>

### Custom MicroProfile Scale
```lua
setfflag("MicroProfilerDpiScaleOverride", "100")
```
### Hide guis
###### ***Instructions, Replace "ID" with any group ID that you are in.***
```lua
setfflag("CanHideGuiGroupId", "ID_HERE")
```

<h1 align="center">Physics</h1>

### No Animations
```lua
setfflag("ReplicatorAnimationTrackLimitPerAnimator", "-1")
```
### Stick unanchored parts to you
##### - = up, + = down
```lua
```lua
setfflag("SolidFloorPercentForceApplication", "-1000")
setfflag("VoiceChatRollOffMaxDistance", "-5000")
```
### Max Raycast Distance
###### Break legs collision from 2 to -inf, kinda break camera on values over 3 noclip cam on 3
```lua
setfflag("RaycastMaxDistance", "3")
```
### Possible Super Jump
```lua
setfflag("NewRunningBaseGravityReductionFactorHundredth", "1500")
```
### Change DataSender Rate
```lua
setfflag("DataSenderRate", "-1")
```
### Fake Lag
```lua
setfflag("S2PhysicsSenderRate", "1")
```
### Invisible
```lua
setfflag("S2PhysicsSenderRate", "-30")
```
### Invisible 
###### Sets your position to 0,0,0 for the server
```lua
setfflag("GameNetPVHeaderTranslationZeroCutoffExponent", "10")
```
### Clientsided Invisible
```lua
setfflag("FIntParallelDynamicPartsFastClusterBatchSize", "1")
```
### Warp & Physics FPS cap
```lua
setfflag("MaxMissedWorldStepsRemembered", "1")
```
```lua
setfflag("MaxMissedWorldStepsRemembered", "1000")
```
### Noclip
###### adjust the value so u dont fall through the ground
```lua
setfflag("AssemblyExtentsExpansionStudHundredth", "-50")
```
### Hip Height
###### Very controllable bounce, only works with negative values, 0 allows you to hover
```lua
setfflag("MaxAltitudePDStickHipHeightPercent", "-200")
```

<h1 align="center">other fflags</h1>

### MTU 
```lua
setfflag("ConnectionMTUSize", "MTU_HERE")
```
### No Internet Disconnect 
###### *[You will still be kicked but the message wont show.]*
```lua
setfflag("DebugDisableTimeoutDisconnect", "True")
```
### Allows you to change voice chat distance 
###### default, [Min 7 Max 80]
```lua
setfflag("VoiceChatRollOffMinDistance", "7")
setfflag("VoiceChatRollOffMaxDistance", "80")
```
### Limit audios that are being played
```lua
setfflag("MaxLoadableAudioChannelCount", "1")
```
### Disable Dynamic Heads Animations
```lua
setfflag("EnableDynamicHeadByDefault", "False")
```
### Limits number of animations being played
```lua
setfflag("MaxActiveAnimationTracks", "0")
```
### Prevents Remote Events from running
```lua
setfflag("RemoteEventSingleInvocationSizeLimit", "1")
```
### Show Flag State
```lua
setfflag("DebugShowFlagState", "FLAGHERE")
```
### Max zoom distance
###### only works in some games that haven't changed the roblox default
```lua
 setfflag("FIntCameraMaxZoomDistance", "100000000") 
```

