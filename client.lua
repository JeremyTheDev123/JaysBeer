---Coded by Jeremiah:0420
RegisterCommand("party", function(source,args,rawCommand)
    party()
end, false)

---Party Code
function party()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then -- Returns if the player is in any vehicle
		DisplayNotification("Please leave the vehicle first.")
		return false
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_PARTYING", 0, true)
	Citizen.Wait(5000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	drunk = true
end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if drunk then
				drunk = false
				Citizen.Wait(2000)
				DoScreenFadeOut(1000)
				Citizen.Wait(1000)
				SetTimecycleModifier("spectator5")
				SetPedMotionBlur(GetPlayerPed(-1), true)
				SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
				SetPedIsDrunk(GetPlayerPed(-1), true)
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
---Animation code
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
