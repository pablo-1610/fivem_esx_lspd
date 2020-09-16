ESX = nil
local pedsSpawned = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	Citizen.Wait(10)
	if ESX.PlayerData.job.name == 'police' then
		createMarkerThread(true)
	else
		createMarkerThread(false)
	end
	initializeMenus()
	if Config.AddPeds then
		while not pedsSpawned do
			local playerPos = GetEntityCoords(PlayerPedId())
			local dist = GetDistanceBetweenCoords(playerPos,vector3(441.06, -978.73, 30.68), false)
			if dist < 50.0 then
				for index,ped in pairs(Config.Peds) do
					RequestModel(GetHashKey(ped.model))
					while not HasModelLoaded(GetHashKey(ped.model)) do Citizen.Wait(10) end
					local entity = CreatePed(9, GetHashKey(ped.model), ped.position.x, ped.position.y, ped.position.z, ped.heading, false, false)
					TaskStartScenarioInPlace(entity, "WORLD_HUMAN_AA_COFFEE", -1, true) 
					SetEntityInvincible(entity, true)
					SetBlockingOfNonTemporaryEvents(entity, true)
					Citizen.CreateThread(function()
						Citizen.Wait(2000)
						FreezeEntityPosition(entity, true)
					end)
				end
				pedsSpawned = true
			end
			Citizen.Wait(1000)
		end
	end
	
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	if ESX.PlayerData.job.name == 'police' then
		updateMarkerAccess(true)
	else
		updateMarkerAccess(false)
	end

end)


-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)








--[[AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)--]]


