; initial tad alt sync by slymi
; made in 1 hr for the slymi part, Eli is slow...

#Requires AutoHotkey v2.0 
#SingleInstance Force

global GatherLoopTimer := 0
global SyncFoundX := 0
global SyncFoundY := 0
global TabActive := 1
global GummyBackgroundColor := 0
global GummyBackgroundTimer := 0
global TradePosting := 0
global d := "d"
global s := "s"
global w := "w"
global a := "a"
global ScreenWidth
global ScreenHeight
CoordMode("Pixel", "Client")
CoordMode("Mouse", "Client")
if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
	WinGetClientPos , , &ScreenWidth, &ScreenHeight
} else {
	global ScreenWidth := A_ScreenWidth
	global ScreenHeight := A_ScreenHeight
}

TraySetIcon("AltSyncImages\fuzzbomb.ico")

global IniFilePath := A_ScriptDir "\Settings.ini"
global NatroStartTime := 10000 ; ADJUST THIS HIGHER IF UR PC IS SO ASS :skull:
;
;░██████╗░██╗░░░██╗██╗
;██╔════╝░██║░░░██║██║
;██║░░██╗░██║░░░██║██║
;██║░░╚██╗██║░░░██║██║
;╚██████╔╝╚██████╔╝██║
;░╚═════╝░░╚═════╝░╚═╝

MyGui := Gui()
MyGui.Title := "Alt Sync - Slymi & EliTheLegoGuy"  ; title
MyGui.BackColor := 0x120620
MyGui.SetFont("norm s13.25 cbbbbbb")
Tab := MyGui.AddTab3("w450 h200" , ["Sync", "Boost", "HiveHub"])

Tab.OnEvent("Change", TabChanged)

TabChanged(GuiCtrlObj, Info) {
	global TabActive := GuiCtrlObj.Value
	SaveSettings()
}

Tab.UseTab("Sync")
MyGui.SetFont("norm s9 c216eff")
MyGui.Add("GroupBox", "x20 y50 w110 h85", "Tad Alts")
MyGui.SetFont("norm s9 ca221ff")
MyGui.Add("GroupBox", "x140 y50 w320 h85", "Webhooks")

TadAlt1Activation := MyGui.Add("Checkbox", "x35 y70 w16 h20")
TadAlt2Activation := MyGui.Add("Checkbox", "x35 y100 w16 h20")

MyGui.SetFont("norm s12 cbbbbbb")
MyGui.Add("Text", "x55 y70", "Tad alt 1")
MyGui.Add("Text", "x55 y100", "Tad alt 2")
MyGui.Add("Text", "x150 y70", "Webhook 1")
MyGui.Add("Text", "x150 y100", "Webhook 2")

MyGui.SetFont("norm s10 c111111")
GlitterUsage := MyGui.Add("DropDownList", "vIDK2 x274 y173 w81 Choose1", ["none", "extension", "boost", "another app"])
BoostColor := MyGui.Add("DropDownList", "vIDK3 x189 y173 w58 Choose1", ["blue", "white", "red", "just pine"])

;buttons 
MacroStart := MyGui.Add("Button", "x30 y170 w62 h30", "Start (F7)")
MacroStop := MyGui.Add("Button", "x99 y170 w62 h30", "Stop (F8)")

;text
MyGui.SetFont("norm s10 cbbbbbb")
MyGui.Add("Text", "x294 y154", "glitter usage (slot")
MyGui.Add("Text", "x415 y154", ")")
MyGui.Add("Text", "x193 y154", "boost color")
MyGui.Add("Text", "x357 y177", "at")
MyGui.Add("Text", "x407 y177", "s left")

;edit
MyGui.SetFont("norm s12 c111111")
Tad1Webhook := MyGui.Add("Edit", "x250 y70 w160 h23")
Tad2Webhook := MyGui.Add("Edit", "x250 y100 w160 h23")
MyGui.SetFont("norm s11 c111111")
BoostTime := MyGui.Add("Edit", "x371 y174 w34 h23")
MyGui.SetFont("norm s10 c111111")
GlitterSlot := MyGui.Add("Edit", "x400 y153 w13 h18")

MacroStart.OnEvent("Click", MainLoop)
MacroStop.OnEvent("Click", Restart)

TadAlt1Activation.OnEvent("click", SaveSettings)
TadAlt2Activation.OnEvent("click", SaveSettings)
GlitterUsage.OnEvent("change", SaveSettings)
BoostColor.OnEvent("change", SaveSettings)
Tad1Webhook.OnEvent("change", SaveSettings)
Tad2Webhook.OnEvent("change", SaveSettings)
BoostTime.OnEvent("change", SaveSettings)
GlitterSlot.OnEvent("change", SaveSettings)

MyGui.OnEvent("Close", MyGui_Close)


Tab.UseTab("Boost")

;buttons
MacroStart := MyGui.Add("Button", "x30 y170 w62 h30", "Start (F7)")
MacroStop := MyGui.Add("Button", "x99 y170 w62 h30", "Stop (F8)")
MacroStart.OnEvent("Click", MainLoop)
MacroStop.OnEvent("Click", Restart)

;checkboxxes
AutoHolder := MyGui.Add("Checkbox", "x34 y52 w13 h13")
GummyballWarning := MyGui.Add("Checkbox", "x34 y74 w13 h13")
HotkeyActivation1 := MyGui.Add("Checkbox", "x178 y52 w13 h13")
HotkeyActivation2 := MyGui.Add("Checkbox", "x178 y74 w13 h13")
HotkeyActivation3 := MyGui.Add("Checkbox", "x178 y96 w13 h13")
HotkeyActivation4 := MyGui.Add("Checkbox", "x178 y118 w13 h13")
HotkeyActivation5 := MyGui.Add("Checkbox", "x178 y140 w13 h13")
HotkeyActivation6 := MyGui.Add("Checkbox", "x178 y162 w13 h13")
HotkeyActivation7 := MyGui.Add("Checkbox", "x178 y184 w13 h13")
AutoHolder.OnEvent("click", SaveSettings)
GummyballWarning.OnEvent("click", SaveSettings)
HotkeyActivation1.OnEvent("click", SaveSettings)
HotkeyActivation2.OnEvent("click", SaveSettings)
HotkeyActivation3.OnEvent("click", SaveSettings)
HotkeyActivation4.OnEvent("click", SaveSettings)
HotkeyActivation5.OnEvent("click", SaveSettings)
HotkeyActivation6.OnEvent("click", SaveSettings)
HotkeyActivation7.OnEvent("click", SaveSettings)

;text
MyGui.SetFont("norm s10 cbbbbbb")
MyGui.Add("Text", "x54 y50", "auto holder")
MyGui.Add("Text", "x54 y72", "gummyball warning")
MyGui.Add("Text", "x198 y50", "send")
MyGui.Add("Text", "x250 y50", "every")
MyGui.Add("Text", "x342 y50", "ms")

;edit
MyGui.SetFont("norm s10 c111111")
HotkeyCharacter1 := MyGui.Add("Edit", "x234 y50 w13 h18")
HotkeyInterval1 := MyGui.Add("Edit", "x288 y50 w50 h18")
HotkeyCharacter2 := MyGui.Add("Edit", "x234 y72 w13 h18")
HotkeyInterval2 := MyGui.Add("Edit", "x288 y72 w50 h18")
HotkeyCharacter3 := MyGui.Add("Edit", "x234 y94 w13 h18")
HotkeyInterval3 := MyGui.Add("Edit", "x288 y94 w50 h18")
HotkeyCharacter4 := MyGui.Add("Edit", "x234 y116 w13 h18")
HotkeyInterval4 := MyGui.Add("Edit", "x288 y116 w50 h18")
HotkeyCharacter5 := MyGui.Add("Edit", "x234 y138 w13 h18")
HotkeyInterval5 := MyGui.Add("Edit", "x288 y138 w50 h18")
HotkeyCharacter6 := MyGui.Add("Edit", "x234 y160 w13 h18")
HotkeyInterval6 := MyGui.Add("Edit", "x288 y160 w50 h18")
HotkeyCharacter7 := MyGui.Add("Edit", "x234 y182 w13 h18")
HotkeyInterval7 := MyGui.Add("Edit", "x288 y182 w50 h18")
HotkeyCharacter1.OnEvent("change", SaveSettings)
HotkeyCharacter2.OnEvent("change", SaveSettings)
HotkeyCharacter3.OnEvent("change", SaveSettings)
HotkeyCharacter4.OnEvent("change", SaveSettings)
HotkeyCharacter5.OnEvent("change", SaveSettings)
HotkeyCharacter6.OnEvent("change", SaveSettings)
HotkeyCharacter7.OnEvent("change", SaveSettings)
HotkeyInterval1.OnEvent("change", SaveSettings)
HotkeyInterval2.OnEvent("change", SaveSettings)
HotkeyInterval3.OnEvent("change", SaveSettings)
HotkeyInterval4.OnEvent("change", SaveSettings)
HotkeyInterval5.OnEvent("change", SaveSettings)
HotkeyInterval6.OnEvent("change", SaveSettings)
HotkeyInterval7.OnEvent("change", SaveSettings)


Tab.UseTab("HiveHub")

;buttons 
MacroStart := MyGui.Add("Button", "x30 y170 w62 h30", "Start (F7)")
MacroStop := MyGui.Add("Button", "x99 y170 w62 h30", "Stop (F8)")
MacroStart.OnEvent("Click", MainLoop)
MacroStop.OnEvent("Click", Restart)

;checkboxxes, not saveable yet
PostTradeMessage := MyGui.Add("Checkbox", "x34 y52 w13 h13")
AcceptTrades := MyGui.Add("Checkbox", "x34 y74 w13 h13")
HiveHubMove := MyGui.Add("Checkbox", "x34 y96 w13 h13")
ShiftLock := MyGui.Add("Checkbox", "x34 y118 w13 h13")
PostTradeMessage.OnEvent("click", SaveSettings)
AcceptTrades.OnEvent("click", SaveSettings)
HiveHubMove.OnEvent("click", SaveSettings)
ShiftLock.OnEvent("click", SaveSettings)

;edit
MyGui.SetFont("norm s10 c111111")
PlayerMovespeed := MyGui.Add("Edit", "x364 y50 w40 h18")
HiveHubMessage := MyGui.Add("Edit", "x180 y140 w264 h60")
PlayerMovespeed.OnEvent("change", SaveSettings)
HiveHubMessage.OnEvent("change", SaveSettings)

;text
MyGui.SetFont("norm s10 cbbbbbb")
MyGui.Add("Text", "x54 y50", "post trade messages")
MyGui.Add("Text", "x54 y72", "accept trades")
MyGui.Add("Text", "x54 y94", "collect (hive hub)")
MyGui.Add("Text", "x54 y116", "shift lock (when collecting)")
MyGui.Add("Text", "x240 y50", "player movespeed:")
MyGui.Add("Text", "x254 y120", "trade message:")


		

GuiControl := 1

MyGui.Show()
LoadSettings()

F7::MainLoop
F8::Restart


MyGui_Close(thisGui) {
	ExitApp()
}

Restart(*) {
	Reload()
}

CheckForSync(*) {
	global ScreenWidth
	global ScreenHeight
	if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
		WinGetClientPos , , &ScreenWidth, &ScreenHeight
	} else {
		ScreenWidth := A_ScreenWidth
		ScreenHeight := A_ScreenHeight
	}
    global SyncFoundX
	global SyncFoundY
	if (BoostColor.value = 1) {
	;blue
		;blue flower
        FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bluf_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Blue Flower")
        }
        ;bamboo
        FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bamb_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Bamboo")
        }
        ;pine tree
        if (GlitterUsage.value != 1) {
			FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pine_tree_boost.png")
			if (FoundBoost = 1) {
				;default field
				ChangeFieldBoosted("Pine Tree")
			} else if (GlitterUsage.value = 3) {
				send "{%GlitterSlot.value% down}"
				sleep 20
				send "{%GlitterSlot.value% up}"
			}
		}
	} else if (BoostColor.value = 2) {
	;white
		;dandelion
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\dandi_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Dandelion")
        }
		;sunflower
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\sunf_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Sunflower")
        }
		;spider
		if (GlitterUsage.value != 1) {
			FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\spider_boost.png")
			if (FoundBoost = 1) {
				;default field
				ChangeFieldBoosted("Spider")
			} else if (GlitterUsage.value = 3) {
				send "{%GlitterSlot.value% down}"
				sleep 20
				send "{%GlitterSlot.value% up}"
			}
		}
		;pineapple
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pineapple_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Pineapple")
        }
		
		;pumpkin
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pump_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Pumpkin")
        }
	} else if (BoostColor.value = 3) {
	;red
		;strawberry
		if (GlitterUsage.value != 1) {
			FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\strawb_boost.png")
			if (FoundBoost = 1) {
				;default field
				ChangeFieldBoosted("Strawberry")
			} else if (GlitterUsage.value = 3) {
				send "{%GlitterSlot.value% down}"
				sleep 20
				send "{%GlitterSlot.value% up}"
			}
		}
		;rose
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\rose_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Rose")
        }
		;pepper
		FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pep_boost.png")
        if (FoundBoost = 1) {
            ChangeFieldBoosted("Pepper")
        }
		
	} else {
	; pinetree only
		;pine tree
        if (GlitterUsage.value != 1) {
			FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pine_tree_boost.png")
			if (FoundBoost = 1) {
				;default field
				ChangeFieldBoosted("Pine Tree")
			} else if (GlitterUsage.value = 3) {
				send "{%GlitterSlot.value% down}"
				sleep 20
				send "{%GlitterSlot.value% up}"
			}
		}
	}
}

ChangeFieldBoosted(field) {
	global ScreenWidth
	global ScreenHeight
    global SyncFoundX
	global SyncFoundY
	global GatherLoopTimer
    if (field != "Pine Tree" && field != "Spider" && field != "Strawberry") {
		if (TadAlt1Activation.Value = true) {
            SendWebhook("?stop", Tad1Webhook.Value)
        }
        if (TadAlt2Activation.Value = true) {
            SendWebhook("?stop", Tad2Webhook.Value)
        }

		Sleep NatroStartTime ; wait for macro to restart

        if (TadAlt1Activation.Value = true) {
            SendWebhook("?set FieldName1 " field, Tad1Webhook.value)
        }
        if (TadAlt2Activation.Value = true) {
            SendWebhook("?set FieldName1 " field, Tad2Webhook.value)
        }

		Sleep 1200 ; wait for field change to apply

        if (TadAlt1Activation.Value = true) {
            SendWebhook("?start", Tad1Webhook.value)
        }
        if (TadAlt2Activation.Value = true) {
            SendWebhook("?start", Tad2Webhook.value)
        }
	}
	
	; wait until boost is gone
	if (GlitterUsage.value = 1) {
		sleep 897000
	} else if (GlitterUsage.value = 4) {
		GatherLoopTimer := 89
		settimer GatherLoopTick, 10000, 999
		loop {
			sleep 1000
			if (GatherLoopTimer = 0) {
				break
			} else {
				if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
					WinGetClientPos , , &ScreenWidth, &ScreenHeight
				} else {
					ScreenWidth := A_ScreenWidth
					ScreenHeight := A_ScreenHeight
				}
				if (field = "Blue Flower") {
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bluf_boost.png")
				} else if (field = "Bamboo"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bamb_boost.png")
				} else if (field = "Pine Tree"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pine_tree_boost.png")
				} else if (field = "Dandelion"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\dandi_boost.png")
				} else if (field = "Sunflower"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\sunf_boost.png")
				} else if (field = "Spider"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\spider_boost.png")
				} else if (field = "Pineapple"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pineapple_boost.png")
				} else if (field = "Pumpkin"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pump_boost.png")
				} else if (field = "Strawberry"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\strawb_boost.png")
				} else if (field = "Rose"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\rose_boost.png")
				} else {
					;pepper
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pep_boost.png")
				}
				if (FoundBoost = 1) {
					GatherLoopTimer := 89
				}
			}
		}
	} else {
		GatherLoopTimer := 89
		settimer GatherLoopTick, 10000, 999
		loop {
			sleep 1000
			if (GatherLoopTimer = 0) {
				break
			} else if (GatherLoopTimer > 0 && GatherLoopTimer <= (BoostTime.value * 0.1)) {
				send "{" GlitterSlot.value " down}"
				sleep 20
				send "{" GlitterSlot.value " up}"
				
				if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
					WinGetClientPos , , &ScreenWidth, &ScreenHeight
				} else {
					ScreenWidth := A_ScreenWidth
					ScreenHeight := A_ScreenHeight
				}
				if (field = "Blue Flower") {
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bluf_boost.png")
				} else if (field = "Bamboo"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\bamb_boost.png")
				} else if (field = "Pine Tree"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pine_tree_boost.png")
				} else if (field = "Dandelion"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\dandi_boost.png")
				} else if (field = "Sunflower"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\sunf_boost.png")
				} else if (field = "Spider"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\spider_boost.png")
				} else if (field = "Pineapple"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pineapple_boost.png")
				} else if (field = "Pumpkin"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pump_boost.png")
				} else if (field = "Strawberry"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\strawb_boost.png")
				} else if (field = "Rose"){
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\rose_boost.png")
				} else {
					;pepper
					FoundBoost := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\pep_boost.png")
				}
				if (FoundBoost = 1) {
					GatherLoopTimer := -89
				}
			}
		}
	}
		
	if (field != "Pine Tree" && field != "Spider" && field != "Strawberry") {
        if (TadAlt1Activation.Value = true) {
            SendWebhook("?stop", Tad1Webhook.value)
        }
        if (TadAlt2Activation.Value = true) {
            SendWebhook("?stop", Tad2Webhook.value)
        }

		Sleep NatroStartTime ; wait for natro to restart
		; send alts to default field
		if (BoostColor.value = 1) {
			;blue
			if (TadAlt1Activation.Value = true) {
				SendWebhook("?set FieldName1 Pine Tree", Tad1Webhook.value)
			}
			if (TadAlt2Activation.Value = true) {
				SendWebhook("?set FieldName1 Pine Tree", Tad2Webhook.value)
			}
		} else if (BoostColor.value = 2) {
			;white
			if (TadAlt1Activation.Value = true) {
				SendWebhook("?set FieldName1 Spider", Tad1Webhook.value)
			}
			if (TadAlt2Activation.Value = true) {
				SendWebhook("?set FieldName1 Spider", Tad2Webhook.value)
			}
		} else {
			;red
			if (TadAlt1Activation.Value = true) {
				SendWebhook("?set FieldName1 Strawberry", Tad1Webhook.value)
			}
			if (TadAlt2Activation.Value = true) {
				SendWebhook("?set FieldName1 Strawberry", Tad2Webhook.value)
			}
		}

		Sleep 1200 ; wait for field change to take change

        if (TadAlt1Activation.Value = true) {
            SendWebhook("?start", Tad1Webhook.value)
        }
        if (TadAlt2Activation.Value = true) {
            SendWebhook("?start", Tad2Webhook.value)
        }
	}
}

GatherLoopTick(*) {
	global GatherLoopTimer
	if (GatherLoopTimer = 0) {
		settimer , 0
	} else if (GatherLoopTimer > 0) {
		GatherLoopTimer := GatherLoopTimer - 1
	} else {
		GatherLoopTimer := GatherLoopTimer + 1
	}
}

SendWebhook(msg, url) {
    postdata := '{"content":"' msg '"}'
    whr := ComObject("WinHTTP.WinHTTPRequest.5.1")
    whr.open("POST", url, false)
    whr.setRequestHeader("Content-Type", "application/json")
    whr.setRequestHeader("User-Agent", "MAD_DENISDAILY2")
    whr.send(postdata)
    return whr.responseText
}

BoostingAid(*) {
	global GummyBackgroundColor
	global GummyBackgroundTimer
	if (AutoHolder.value = 1) {
		RightClick := GetKeyState("RButton")
		if (RightClick = 1) {
			send "{LButton down}"
			KeyWait "RButton"
		}
	}
	if (GummyballWarning.value = 1) {
		Found9xGummyBall := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\9xGummyBall.png")
		Found8xGummyBall := ImageSearch(&SyncFoundX, &SyncFoundY, 0, 0, ScreenWidth, 100, "*30 AltSyncImages\8xGummyBall.png")
		if (Found9xGummyBall = 1) {
			if (GummyBackgroundColor != 1) {
				MyGui.BackColor := 0xE38DF4
				Tab.Redraw()
				GummyBackgroundColor := 1
			}
			GummyBackgroundTimer := 16
		} else if (Found8xGummyBall = 1) {
			if (GummyBackgroundColor != 2) {
				MyGui.BackColor := 0x5EFFCA
				Tab.Redraw()
				GummyBackgroundColor := 2
			}
			GummyBackgroundTimer := 16
		} else {
			if (GummyBackgroundColor != 0 && GummyBackgroundTimer = 0) {
				MyGui.BackColor := 0x420650
				Tab.Redraw()
				GummyBackgroundColor := 0
			}
		}
		if (GummyBackgroundTimer > 0) {
			GummyBackgroundTimer := GummyBackgroundTimer - 1
		}
	}
	
}

SendHotkey1(*) {
	send "{" HotkeyCharacter1.value " down}"
	send "{" HotkeyCharacter1.value " up}"
}
SendHotkey2(*) {
	send "{" HotkeyCharacter2.value " down}"
	send "{" HotkeyCharacter2.value " up}"
}
SendHotkey3(*) {
	send "{" HotkeyCharacter3.value " down}"
	send "{" HotkeyCharacter3.value " up}"
}
SendHotkey4(*) {
	send "{" HotkeyCharacter4.value " down}"
	send "{" HotkeyCharacter4.value " up}"
}
SendHotkey5(*) {
	send "{" HotkeyCharacter5.value " down}"
	send "{" HotkeyCharacter5.value " up}"
}
SendHotkey6(*) {
	send "{" HotkeyCharacter6.value " down}"
	send "{" HotkeyCharacter6.value " up}"
}
SendHotkey7(*) {
	send "{" HotkeyCharacter7.value " down}"
	send "{" HotkeyCharacter7.value " up}"
}

MoveCharacter(WalkDistance, KeyDirection, KeyDirection2:="") {
	KeyDirectionType := (KeyDirection2!="")
	send "{" KeyDirection " down}"
	if (KeyDirectionType) {
		send "{" KeyDirection2 " down}"
	}
	;moves 1 flower for each unit, assumes a 29 movespeed, should be 3908 to be accurate...
	sleep (WalkDistance * 3400/PlayerMovespeed.value)
	send "{" KeyDirection " up}"
	if (KeyDirectionType) {
		send "{" KeyDirection2 " up}"
	}
}

HiveHubLoop(*) {
	global d
	global s
	global w
	global a
	global ScreenWidth
	global ScreenHeight
	if (PostTradeMessage.value = 1) {
		global TradePosting := 1
		sleep 500
		send "{/}"
		sleep 800
		send HiveHubMessage.value
		sleep 800
		send "{Enter}"
		global TradePosting := 0
		sleep 1200
	}
	if (HiveHubMove.value = 1) {
		send "{LButton down}"
		MoveCharacter(15, s, d)
		MoveCharacter(8, s)
		MoveCharacter(12, w, a)
		MoveCharacter(5, w)
		loop 40 {
			MoveCharacter(10.5, a)
			send "{. down}"
			send "{. up}"
		}
	} else {
		sleep 60000
	}
}

AcceptTradeClick(*) {
	global ScreenWidth
	global ScreenHeight
	global SyncFoundX
	global SyncFoundY
	if (TradePosting = 0) {
		if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
			WinGetClientPos , , &ScreenWidth, &ScreenHeight
		} else {
			global ScreenWidth := A_ScreenWidth
			global ScreenHeight := A_ScreenHeight
		}
		FoundTradeRequest := ImageSearch(&SyncFoundX, &SyncFoundY, ScreenWidth - 300, (ScreenHeight * 0.6 - 100), ScreenWidth, (ScreenHeight * 0.6 + 100), "*1 AltSyncImages\TradeRequest.png")
		if (FoundTradeRequest = 1) {
			if (ShiftLock.value = 1) {
				send "{shift}"
				sleep 500
			}
			MouseClickDrag "left", , , (ScreenWidth - 200), (ScreenHeight * 0.6 + 80)
			sleep 200
			loop 8 {
				MouseClick
				sleep 100
			}
			Reload()
		}
	}
}

MainLoop(*) {
	MsgBoxError := 0
	global TabActive
	if (TabActive = 1) {
		;sync
		WinMinimize("Alt Sync - Slymi & EliTheLegoGuy")
		if (GlitterUsage.value != 1) {
			if (BoostTime.value = "" || BoostTime.value > 900 || BoostTime.value < 20) {
				MsgBoxError := 1
				MsgBox "Please enter a valid time in seconds (20 to 900) for the remaining duration of the boost when glitter is used."
				return
			}
			if (GlitterSlot.value < 1 || GlitterSlot.value > 7 || GlitterSlot.value = "") {
				MsgBoxError := 1
				MsgBox "Please enter a valid slot number (1 to 7) in your hotbar for glitter usage."
				return
			}
		}
		if (MsgBoxError = 0) {
			MyGui.BackColor := 0x420650
			Tab.Redraw()
			; set alts to default field
			if (BoostColor.value = 1) {
				;blue
				if (TadAlt1Activation.Value = true) {
					SendWebhook("?set FieldName1 Pine Tree", Tad1Webhook.value)
				}
				if (TadAlt2Activation.Value = true) {
					SendWebhook("?set FieldName1 Pine Tree", Tad2Webhook.value)
				}
			} else if (BoostColor.value = 2) {
				;white
				if (TadAlt1Activation.Value = true) {
					SendWebhook("?set FieldName1 Spider", Tad1Webhook.value)
				}
				if (TadAlt2Activation.Value = true) {
					SendWebhook("?set FieldName1 Spider", Tad2Webhook.value)
				}
			} else {
				;red
				if (TadAlt1Activation.Value = true) {
					SendWebhook("?set FieldName1 Strawberry", Tad1Webhook.value)
				}
				if (TadAlt2Activation.Value = true) {
					SendWebhook("?set FieldName1 Strawberry", Tad2Webhook.value)
				}
			}

			Sleep 1200 ; wait for field change to take change

			Loop {
				CheckForSync
				sleep 1000
			}
		}
	} else if (TabActive = 2) {
		if (IsNumber(HotkeyInterval1.value) && IsNumber(HotkeyInterval2.value) && IsNumber(HotkeyInterval3.value) && IsNumber(HotkeyInterval4.value) && IsNumber(HotkeyInterval5.value) && IsNumber(HotkeyInterval6.value) && IsNumber(HotkeyInterval7.value)) {
			MyGui.BackColor := 0x420650
			Tab.Redraw()
			;boost
			if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
				WinActivate
			}
			if (HotkeyActivation1.value = true) {
				SetTimer SendHotkey1, HotkeyInterval1.value
			}
			if (HotkeyActivation2.value = true) {
				SetTimer SendHotkey2, HotkeyInterval2.value
			}
			if (HotkeyActivation3.value = true) {
				SetTimer SendHotkey3, HotkeyInterval3.value
			}
			if (HotkeyActivation4.value = true) {
				SetTimer SendHotkey4, HotkeyInterval4.value
			}
			if (HotkeyActivation5.value = true) {
				SetTimer SendHotkey5, HotkeyInterval5.value
			}
			if (HotkeyActivation6.value = true) {
				SetTimer SendHotkey6, HotkeyInterval6.value
			}
			if (HotkeyActivation7.value = true) {
				SetTimer SendHotkey7, HotkeyInterval7.value
			}
			if (AutoHolder.value = 1 || GummyballWarning.value = 1) {
				Loop {
					BoostingAid
				}
			}
		} else {
			MsgBox "Please enter a number for each hotkey delay."
			return
		}
	} else if (TabActive = 3) {
		if (PostTradeMessage.value = 1) {
			HiveHubMessageLength := StrLen(HiveHubMessage.value)
			if (HiveHubMessage.value = "" || HiveHubMessageLength < 2 || HiveHubMessageLength > 200 ) {
				MsgBoxError := 1
				MsgBox "Please enter a valid message (2-200 characters) in the message box."
				return
			;none of these symbols !#^+{}
			}
			if (InStr(HiveHubMessage.value, "!") || InStr(HiveHubMessage.value, "#") || InStr(HiveHubMessage.value, "^") || InStr(HiveHubMessage.value, "+") || InStr(HiveHubMessage.value, "{") || InStr(HiveHubMessage.value, "}")) {
				MsgBoxError := 1
				MsgBox "Please enter a valid message without these symbols `n`n		   ! # ^ + { }"
				return
			}
			if !IsNumber(PlayerMovespeed.value) {
				MsgBoxError := 1
				MsgBox "Please enter a number for the player movespeed"
				return
			}
		}
		if (MsgBoxError = 0) {
			MyGui.BackColor := 0x420650
			Tab.Redraw()
			if WinExist("Roblox ahk_exe RobloxPlayerBeta.exe") {
				WinActivate
			}
			if (AcceptTrades.value = 1) {
				settimer AcceptTradeClick, 1
			}
			if (HiveHubMove.value = 1) {
				MoveCharacter(10, s)
				if (ShiftLock.value = 1) {
					send "{shift}"
				}
			}
			
			Loop {
				HiveHubLoop
			}
		}
	}
}

SaveSettings(*) {
    global Inifilepath
    try {
        ; Construct contents to be saved
        Contents := "[Settings]`n"
        Contents .= "TadAltActivation1=" . TadAlt1Activation.Value . "`n"
        Contents .= "TadAltActivation2=" . TadAlt2Activation.Value . "`n"
        Contents .= "WebhookAlt1=" . Tad1Webhook.Value . "`n"
        Contents .= "WebhookAlt2=" . Tad2Webhook.Value . "`n"
		Contents .= "GlitterUsage=" . GlitterUsage.Value . "`n"
		Contents .= "BoostColor=" . BoostColor.Value . "`n"
		Contents .= "BoostTime=" . BoostTime.Value . "`n"
		Contents .= "GlitterSlot=" . GlitterSlot.Value . "`n"
		Contents .= "AutoHolder=" . AutoHolder.Value . "`n"
        Contents .= "GummyballWarning=" . GummyballWarning.Value . "`n"
		Contents .= "HotkeyActivation1=" . HotkeyActivation1.Value . "`n"
        Contents .= "HotkeyActivation2=" . HotkeyActivation2.Value . "`n"
		Contents .= "HotkeyActivation3=" . HotkeyActivation3.Value . "`n"
        Contents .= "HotkeyActivation4=" . HotkeyActivation4.Value . "`n"
		Contents .= "HotkeyActivation5=" . HotkeyActivation5.Value . "`n"
        Contents .= "HotkeyActivation6=" . HotkeyActivation6.Value . "`n"
		Contents .= "HotkeyActivation7=" . HotkeyActivation7.Value . "`n"
		Contents .= "HotkeyCharacter1=" . HotkeyCharacter1.Value . "`n"
        Contents .= "HotkeyCharacter2=" . HotkeyCharacter2.Value . "`n"
		Contents .= "HotkeyCharacter3=" . HotkeyCharacter3.Value . "`n"
        Contents .= "HotkeyCharacter4=" . HotkeyCharacter4.Value . "`n"
		Contents .= "HotkeyCharacter5=" . HotkeyCharacter5.Value . "`n"
        Contents .= "HotkeyCharacter6=" . HotkeyCharacter6.Value . "`n"
		Contents .= "HotkeyCharacter7=" . HotkeyCharacter7.Value . "`n"
		Contents .= "HotkeyInterval1=" . HotkeyInterval1.Value . "`n"
        Contents .= "HotkeyInterval2=" . HotkeyInterval2.Value . "`n"
		Contents .= "HotkeyInterval3=" . HotkeyInterval3.Value . "`n"
        Contents .= "HotkeyInterval4=" . HotkeyInterval4.Value . "`n"
		Contents .= "HotkeyInterval5=" . HotkeyInterval5.Value . "`n"
        Contents .= "HotkeyInterval6=" . HotkeyInterval6.Value . "`n"
		Contents .= "HotkeyInterval7=" . HotkeyInterval7.Value . "`n"
		Contents .= "PlayerMovespeed=" . PlayerMovespeed.Value . "`n"
		Contents .= "PostTradeMessage=" . PostTradeMessage.Value . "`n"
		Contents .= "AcceptTrades=" . AcceptTrades.Value . "`n"
		Contents .= "HiveHubMove=" . HiveHubMove.Value . "`n"
		Contents .= "ShiftLock=" . ShiftLock.Value . "`n"
		Contents .= "HiveHubMessage=" . HiveHubMessage.Value . "`n"
		Contents .= "LastTab=" . Tab.Value . "`n"
        FileDelete(IniFilePath)  ; Delete existing file if it exists
        FileAppend(Contents, IniFilePath)
    } catch {
        MsgBox("Error saving settings to " . IniFilePath)
    }
}

LoadSettings() {
    try {
        Contents := FileRead(IniFilePath)
        
        for Line in StrSplit(Contents, "`n") {
            if InStr(Line, "=") {
                Key := Trim(StrSplit(Line, "=")[1])
                Value := Trim(SubStr(Line, InStr(Line, "=") + 1))
				
                switch (Key) {
                    case "TadAltActivation1":
                        TadAlt1Activation.Value := Value
                    case "TadAltActivation2":
                        TadAlt2Activation.Value := Value
                    case "WebhookAlt1":
                        Tad1Webhook.Value := Value
                    case "WebhookAlt2":
                        Tad2Webhook.Value := Value
					case "GlitterUsage":
                        GlitterUsage.Value := Value
                    case "BoostColor":
                        BoostColor.Value := Value
					case "BoostTime":
                        BoostTime.Value := Value
					case "GlitterSlot":
                        GlitterSlot.Value := Value
					case "AutoHolder":
                        AutoHolder.Value := Value
                    case "GummyballWarning":
                        GummyballWarning.Value := Value
					case "HotkeyActivation1":
                        HotkeyActivation1.Value := Value
                    case "HotkeyActivation2":
                        HotkeyActivation2.Value := Value
					case "HotkeyActivation3":
                        HotkeyActivation3.Value := Value
                    case "HotkeyActivation4":
                        HotkeyActivation4.Value := Value
					case "HotkeyActivation5":
                        HotkeyActivation5.Value := Value
                    case "HotkeyActivation6":
                        HotkeyActivation6.Value := Value
					case "HotkeyActivation7":
                        HotkeyActivation7.Value := Value
					case "HotkeyCharacter1":
                        HotkeyCharacter1.Value := Value
                    case "HotkeyCharacter2":
                        HotkeyCharacter2.Value := Value
					case "HotkeyCharacter3":
                        HotkeyCharacter3.Value := Value
                    case "HotkeyCharacter4":
                        HotkeyCharacter4.Value := Value
					case "HotkeyCharacter5":
                        HotkeyCharacter5.Value := Value
                    case "HotkeyCharacter6":
                        HotkeyCharacter6.Value := Value
					case "HotkeyCharacter7":
                        HotkeyCharacter7.Value := Value
					case "HotkeyInterval1":
                        HotkeyInterval1.Value := Value
                    case "HotkeyInterval2":
                        HotkeyInterval2.Value := Value
					case "HotkeyInterval3":
                        HotkeyInterval3.Value := Value
                    case "HotkeyInterval4":
                        HotkeyInterval4.Value := Value
					case "HotkeyInterval5":
                        HotkeyInterval5.Value := Value
                    case "HotkeyInterval6":
                        HotkeyInterval6.Value := Value
					case "HotkeyInterval7":
                        HotkeyInterval7.Value := Value
					case "PlayerMovespeed":
                        PlayerMovespeed.Value := Value
					case "PostTradeMessage":
                        PostTradeMessage.Value := Value
					case "AcceptTrades":
                        AcceptTrades.Value := Value
					case "HiveHubMove":
                        HiveHubMove.Value := Value
					case "ShiftLock":
                        ShiftLock.Value := Value
					case "HiveHubMessage":
                        HiveHubMessage.Value := Value
					case "LastTab":
                        Tab.Value := Value
                        global TabActive := Value
                }
            }
        }
    } catch {
        MsgBox("Error loading settings from " . IniFilePath)
    }
}