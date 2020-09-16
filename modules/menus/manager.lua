local plainteCooldown = false
local rdvCooldown = false

function initializeMenus()
    RMenu.Add("pz_lspd", 'main', RageUI.CreateMenu("Accueil","Accueil du poste de police"))
    Citizen.Wait(1)
    RageUI.CloseAll()
    Citizen.CreateThread(function()
        while true do
            RageUI.IsVisible(RMenu:Get("pz_lspd",'main'),true,true,true,function()
                local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Zones.Markers["home"].location, false)
                if dist > 1.5 then RageUI.Visible(RMenu:Get("pz_lspd",'main'), false) end
                RageUI.ButtonWithStyle("Déposer plainte","Vous permets de déposer une plainte en ligne.", {RightLabel = "→→"}, not plainteCooldown, function(_,_,s)
                    if s then
                        RageUI.Visible(RMenu:Get("pz_lspd",'main'), false)
                        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 5000)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            TriggerServerEvent("pz_lspd:plainte", result)
                            PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                            ESX.ShowAdvancedNotification('~b~Poste de police', '~g~Succès', "Votre plainte a été correctement envoyée et sera traitée dans les plus brefs délais.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                            plainteCooldown = true
                            Citizen.SetTimeout((1000*60)*2, function()
                                plainteCooldown = false
                            end)
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Demander un rendez-vous", "Vous permets d'envoyer une demande de RDV en ligne.", {RightLabel = "→→"}, not rdvCooldown, function(_,_,s)
                    if s then
                        RageUI.Visible(RMenu:Get("pz_lspd",'main'), false)
                        TriggerServerEvent("pz_lspd:rdv")
                        PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                        ESX.ShowAdvancedNotification('~b~Poste de police', '~g~Succès', "Votre demande de rendez-vous a été prise en compte, vous recevrez une convocation sous peu.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                        rdvCooldown = true
                        Citizen.SetTimeout((1000*60)*30, function()
                            rdvCooldown = false
                        end)
                    end
                end)

                RageUI.ButtonWithStyle("Obtenir mon casier judiciaire", "Vous permets d'obtenir un duplicata de votre casier judiciaire.", {RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        RageUI.Visible(RMenu:Get("pz_lspd",'main'), false)
                    end
                end)

                
            end, function()    
            end, 1)
            Citizen.Wait(0)
        end
    end)
end