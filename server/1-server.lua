ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
InJob = {}

--- TRUCK
RegisterServerEvent('master_job:startTruckJob')
AddEventHandler('master_job:startTruckJob', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if InJob[xPlayer.source] ~= nil then
		TriggerClientEvent("pNotify:SendNotification", xPlayer.source, { text = "شما ابتدا باید محموله قبلی را تحویل دهید.", type = "error", timeout = 5000, layout = "bottomCenter"})
		return
	end
	
	if Config.Truck[id] then
		InJob[xPlayer.source] = {}
		InJob[xPlayer.source].trailerLoaded = false
		InJob[xPlayer.source].id = id
		TriggerEvent('master_warden:AllowSpawnCar', xPlayer.source)
		TriggerClientEvent('master_job:start_truck', xPlayer.source, Config.Truck[id], id)
	else
		TriggerClientEvent("pNotify:SendNotification", xPlayer.source, { text = "در حال حاضر شخض دیگری در حال بارگیری می باشد.", type = "error", timeout = 5000, layout = "bottomCenter"})
	end
end)

RegisterServerEvent('master_job:CarIsReady')
AddEventHandler('master_job:CarIsReady', function(id, veh)
    local xPlayer = ESX.GetPlayerFromId(source)
	if InJob[xPlayer.source] == nil then
		return
	end
	
	if Config.Truck[id] and InJob[xPlayer.source].id == id and InJob[xPlayer.source].trailerLoaded == false then
		InJob[xPlayer.source].trailerLoaded = true
		TriggerEvent('master_warden:AllowSpawnCar', xPlayer.source)
		TriggerClientEvent('master_job:spawn_trailer', xPlayer.source, Config.Truck[id], id)
	else
		return
	end
end)

RegisterServerEvent('master_job:finished_truck')
AddEventHandler('master_job:finished_truck', function(id, damages)
    local xPlayer = ESX.GetPlayerFromId(source)
	if InJob[xPlayer.source] == nil then
		return
	end
	-- SET TIME AND CHECK IT
	if Config.Truck[id] and InJob[xPlayer.source].trailerLoaded == true then
		local price, health = Config.Truck[id].payment, (damages['body_health'] + damages['engine_health']) / 2
        for k, v in pairs(damages['windows']) do health = health - 30 end
        for k, v in pairs(damages['tires']) do health = health - 35 end
        for k, v in pairs(damages['doors']) do health = health - 40 end
        if health <= 900 and health > 800 then price = price - 50 elseif health <= 800 and health > 700 then price = price - 75 elseif health <= 700 and health > 600 then price = price - 100 elseif health <= 600 and health > 300 then price = price - 150 elseif health <= 300 then price = price - 350 end
        
        if price >= 0 then
            xPlayer.addMoney(price)
			TriggerClientEvent("pNotify:SendNotification", xPlayer.source, { text = "شما مبلغ " .. price .. "$ بدست آوردید.", type = "success", timeout = 5000, layout = "bottomCenter"})
		else
            TriggerClientEvent("pNotify:SendNotification", xPlayer.source, { text = "در حال حاضر شخض دیگری در حال بارگیری می باشد.", type = "error", timeout = 5000, layout = "bottomCenter"})
		end
		
		InJob[xPlayer.source] = nil
	else
		return
	end
end)