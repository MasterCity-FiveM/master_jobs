ESX = nil
local PlayerData, CurrentBlip = {}, nil
local Working = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local lastTested = 0
Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    PlayerData = ESX.GetPlayerData()
	
	for k,v in pairs(Config.JobBlips) do
		if v.Blip ~= nil then
			local blip = AddBlipForCoord(v.coords)

			SetBlipSprite (blip, v.Blip.Sprite)
			SetBlipScale(blip, v.Blip.Scale)
			SetBlipColour (blip, v.Blip.Colour)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Blip.name)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Draw markers and more
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		letSleep = true
		CurrentBlip = nil
		for k,v in pairs(Config.JobBlips) do
			jobData = v
			local distance = #(playerCoords - jobData.coords)
			
			if distance < 50 then
				letSleep = false
				DrawMarker(20, jobData.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
			
				if distance < 2 then
					CurrentBlip = k
				end
			end
		end

		if letSleep then
			Citizen.Wait(2000)
		end
	end
end)

RegisterNetEvent('master_keymap:e')
AddEventHandler('master_keymap:e', function()
	if CurrentBlip ~= nil and not Working then
		if CurrentBlip == 'Truck' then
			OpenTruckMenu()
		end
	end
end)


local truck, trailer = nil, nil

RegisterNetEvent('master_job:startTrucke')
AddEventHandler('master_job:startTruck', function(data, jobid)
	working = true
	truck, trailer = nil, nil
	print("zzzzz")
	ESX.Game.SpawnVehicle(data.vehicles[1], data.start[1], data.start[2], function(vehicle)
		print("A")
		truck = vehicle
		local vehNet = NetworkGetNetworkIdFromEntity(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)
		TriggerServerEvent("car_lock:GiveKeys", vehNet, plate)
		TriggerServerEvent("master_job:CarIsReady", vehNet)
		exports.pNotify:SendNotification({text = 'لطفا خودرو را در پارکینگ تحویل بگیرید.', type = "success", timeout = 5000})
	end)
	
	
    local destinationBlip, truckBlip, trailerBlip = addBlip(data.arrive, 38, 3, Strings['destination'])
    while working do
		
	end
end)
