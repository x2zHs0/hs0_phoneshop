ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


ConfHs0              = {}
ConfHs0.DrawDistance = 100
ConfHs0.Size         = {x = 1.0, y = 1.0, z = 1.0}
ConfHs0.Color        = {r = 255, g = 255, b = 255}
ConfHs0.Type         = 29

local position = {
        {x = 393.16,  y = -832.42,  z = 29.29}          
}  

Citizen.CreateThread(function()
     for k in pairs(position) do
        local blip = AddBlipForCoord(position[k].x, position[k].y, position[k].z)
        SetBlipSprite(blip, 521)
        SetBlipColour(blip, 72)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Magasin Eléctronique")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(position) do
            if (ConfHs0.Type ~= -1 and GetDistanceBetweenCoords(coords, position[k].x, position[k].y, position[k].z, true) < ConfHs0.DrawDistance) then
                DrawMarker(ConfHs0.Type, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, ConfHs0.Size.x, ConfHs0.Size.y, ConfHs0.Size.z, ConfHs0.Color.r, ConfHs0.Color.g, ConfHs0.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('hs0_phoneshop', 'main', RageUI.CreateMenu("Magasin Eléctronique", "Achat éléctronique"))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('hs0_phoneshop', 'main'), true, true, true, function()

            RageUI.Button("Acheter Iphone", nil, {RightLabel = "~g~1000$"},true, function(Hovered, Active, Selected)
            if (Selected) then   
            	local item = "phone"
            	local prix = 1000
                TriggerServerEvent('hs0_phoneshop:acheter', item, prix)
            end
            end)
           

        end, function()
        end)

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(position) do
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
    
                if dist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au Magasin éléctronique")
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('hs0_phoneshop', 'main'), not RageUI.Visible(RMenu:Get('hs0_phoneshop', 'main')))
                    end   
                end
            end
        end
    end)