local truck, trailer = nil, nil

RegisterNetEvent('master_job:start_truck')
AddEventHandler('master_job:start_truck', function(data, jobid)
	working = true
	truck, trailer = nil, nil
	ESX.Game.SpawnVehicle(data.vehicles[1], data.start[1], data.start[2], function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		local vehNet = NetworkGetNetworkIdFromEntity(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)
		truck = vehicle
		TriggerServerEvent("car_lock:GiveKeys", vehNet, plate)
		TriggerServerEvent("master_job:CarIsReady", jobid, vehNet)
	end)
	
	local destinationBlip, truckBlip, trailerBlip = addBlip(data.arrive, 38, 3, 'Kamiyon')
    while truck == nil or trailer == nil do
		Citizen.Wait(1)
	end
	
	while working do
        local sleep, distance = 250, GetDistanceBetweenCoords(data.arrive, GetEntityCoords(trailer), true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) then
            text('Savare ~y~Kamiyon~w~ shavid!', 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, 'Kamiyon') 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
           if not IsVehicleAttachedToTrailer(truck, trailer) then
                text('~y~Bar~w~ ra tahvil begirid!', 250)
                if not DoesBlipExist(trailerBlip) then 
                    trailerBlip = addBlip(GetEntityCoords(trailer), 479, 5, 'Bar') 
                    SetBlipRoute(trailerBlip, true) 
                end
                if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
            else
                if DoesBlipExist(trailerBlip) then RemoveBlip(trailerBlip) end

                if not DoesBlipExist(destinationBlip) then
                    destinationBlip = addBlip(data.arrive, 38, 3, 'Kamiyon')
                    SetBlipRoute(destinationBlip, true)
                end
            end
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
        end
        if distance <= 45.0 and IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
            sleep = 0
            DrawMarker(1, vector3(data.arrive.x, data.arrive.y, data.arrive.z - 1), vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(3.0, 3.0, 3.0), 255, 255, 50, 150, false, false, 2, false, false, false)
            if distance <= 10.0 then
                while IsVehicleAttachedToTrailer(truck, trailer) do 
                    text('Jahate Tahvil bar ~y~H~w~ Bezanid.', 250)
                    Wait(250)
                end
                break
            else
                text('Be mahale tahvile bar beravid!')
            end
        else
            if IsPedInVehicle(PlayerPedId(), truck, false) and IsVehicleAttachedToTrailer(truck, trailer) then
                text('Bar ra tahvil dahid.', 250)
            end
        end
        Wait(sleep)
    end
	
	DeleteVehicle(trailer)
    RemoveBlip(destinationBlip)
    RemoveBlip(trailerBlip)
    RemoveBlip(truckBlip)
	
    while working do
        local sleep, distance = 250, GetDistanceBetweenCoords(GetEntityCoords(truck), data.start[1], true)
        if not IsPedInVehicle(PlayerPedId(), truck, false) and distance >= 10.0 then
            text('Savare ~y~Kamiyon~w~ shavid!', 250)
            if not DoesBlipExist(truckBlip) then
                truckBlip = addBlip(GetEntityCoords(truck), 477, 5, 'Kamiyon') 
                SetBlipRoute(truckBlip, true) 
            end
            if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
        else
            if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
            if not DoesBlipExist(destinationBlip) then
                destinationBlip = addBlip(data.start[1], 38, 3, 'Tahvil Khodro')
                SetBlipRoute(destinationBlip, true)
            end
            if distance <= 30.0 then
                sleep = 0
                DrawMarker(1, vector3(data.start[1].x, data.start[1].y, data.start[1].z - 1), vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(3.0, 3.0, 3.0), 255, 255, 50, 150, false, false, 2, false, false, false)
                if distance <= 10.0 then
                    if IsPedInVehicle(PlayerPedId(), truck, false) then
                        text('Az Khodro Kharej shavid.')
                    else
                        if DoesBlipExist(destinationBlip) then RemoveBlip(destinationBlip) end
                        if DoesBlipExist(truckBlip) then RemoveBlip(truckBlip) end
                        break
                    end
                else
                    text('Khodro ra dar mahle marbote park konid.')
                end
            else
                text('Khodro ra tahvil dahid.', 250)
            end
        end
        Wait(sleep)
    end
    local damages = {['windows'] = {}, ['tires'] = {}, ['doors'] = {}, ['body_health'] = GetVehicleBodyHealth(truck), ['engine_health'] = GetVehicleEngineHealth(truck)}
    for i = 0, GetVehicleNumberOfWheels(truck) do
        if IsVehicleTyreBurst(truck, i, false) then table.insert(damages['tires'], i) end 
    end
    for i = 0, 13 do
        if not IsVehicleWindowIntact(truck, i) then table.insert(damages['windows'], i) end
    end
    for i = 0, GetNumberOfVehicleDoors(truck) do 
        if IsVehicleDoorDamaged(truck, i) then table.insert(damages['doors'], i) end 
    end
    DeleteVehicle(truck)
    working = false
    TriggerServerEvent('master_job:finished_truck', jobid, damages)
end)

RegisterNetEvent('master_job:spawn_trailer')
AddEventHandler('master_job:spawn_trailer', function(data, jobid)
	if working == true and data.vehicles[2] ~= nil and data.trailer ~= nil then
		ESX.Game.SpawnVehicle(data.vehicles[2], data.trailer[1], data.trailer[2], function(vehicle)
			trailer = vehicle
		end)
	end
end)

function OpenTruckMenu()
    ESX.UI.Menu.CloseAll()
	local elements = {}
	for k, v in pairs(Config.Truck) do
        table.insert(elements, {label = v.title, value = k})
    end
	
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'turck_JOB',
        {
            title = 'انتخاب مقصد',
            align = 'top-right',
            elements = elements
        },
        function(data, menu)
		
			--check Spawn point is free!
			
            TriggerServerEvent('master_job:startTruckJob', data.current.value)
            menu.close()
        end,
    function(data, menu)
        menu.close()
    end)
end

addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

text = function(text, duration)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandPrint(duration, 1)
end