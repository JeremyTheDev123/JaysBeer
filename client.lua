---Coded by Jeremiah:0420
RegisterCommand("beer", function(source,args,rawCommand)
    beer()
end, false)

---Beer Code
function beer()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then -- Returns if the player is in any vehicle
		DisplayNotification("Please leave the vehicle first.")
		return false
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(10000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	drunk = true
end
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if drunk then
			drunk = false
            Citizen.Wait(5000)
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
			SetTimecycleModifier("spectator5")
            SetPedMotionBlur(GetPlayerPed(-1), true)
            DisplayNotification("You are very drunk!")
            SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
            SetPedIsDrunk(GetPlayerPed(-1), true)
            SetPedAccuracy(GetPlayerPed(-1), 0)
            DisplayNotification("You are very drunk!")
            DoScreenFadeIn(1000)            
            Citizen.Wait(600000) ---10 mins
            DoScreenFadeOut(1000)
            Citizen.Wait(1000)
            DoScreenFadeIn(1000)
            ClearTimecycleModifier()
            ResetScenarioTypesEnabled()
            ResetPedMovementClipset(GetPlayerPed(-1), 0)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(GetPlayerPed(-1), false)
            DisplayNotification("You are sober now!")
			end
		end
	end)

---Display notification code
---DisplayNotification("Test")
function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
