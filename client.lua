local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenMenu()
	SendNUIMessage({type = 'openAll'})
	SetNuiFocus(true, true)
end

function CloseMenu()
	SendNUIMessage({type = 'closeAll'})
	SetNuiFocus(false, false)
end

RegisterNUICallback('closeAll', function(data, cb)
	CloseMenu()
end)

RegisterNUICallback('setJob', function(data, cb)
	TriggerServerEvent('esx_job_center:setjob', data.job, data.label)
end)


-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local coords = GetEntityCoords(GetPlayerPed(-1))
			local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, -265.0, -963.6, 30.2, true)
      isInMarker = false
			if distance <= 100 then
        DrawMarker(1, -265.0, -963.6, 30.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 194, 66, 245, 100, false, true, 2, false, false, false, false)
      end
      
	  if distance <= 1.5 then
		isInMarker = true
        ESX.ShowHelpNotification('Wciśnij ~INPUT_CONTEXT~ aby otworzyć ~p~menu pracy')
      end

		end
end)

-- Create blips
Citizen.CreateThread(function()
		local blip = AddBlipForCoord(-265.0, -963.6, 30.2)

		SetBlipSprite (blip, 407)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 27)
		SetBlipAsShortRange(blip, true)

	  BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Centrum pracy")
    EndTextCommandSetBlipName(blip)
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['E']) and isInMarker and not menuIsShowed then
			OpenMenu()
		end
	end
end)