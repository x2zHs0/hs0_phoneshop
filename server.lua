ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('hs0_phoneshop:acheter')
AddEventHandler('hs0_phoneshop:acheter', function(item, prix)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if playerMoney >= prix then
		xPlayer.addInventoryItem(item, 1)
		xPlayer.removeMoney(prix)
		TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~"..item.." ~s~!")
	else
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")
	end
end)
