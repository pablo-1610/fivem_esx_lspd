--[[

                                                                    ____               _____        _      _        
                                                                    |  _ \             |  __ \      | |    | |       
                                                                    | |_) | _   _      | |__) |__ _ | |__  | |  ___  
                                                                    |  _ < | | | |     |  ___// _` || '_ \ | | / _ \ 
                                                                    | |_) || |_| |     | |   | (_| || |_) || || (_) |
                                                                    |____/  \__, |     |_|    \__,_||_.__/ |_| \___/ 
                                                                            __/ |                                   
                                                                            |___/             
                                                                            

                                    Tous droits réservés, il est interdit de modifier et / ou de vendre ce script sans l'accord de son auteur (Discord: 🤖Pablo🤖#8635)

]]

Config = {}

--  Changez cette ligne si votre fonction de récupération d'ESX est différente (pour vérifier cela -> es_extended/client/common.lua)
Config.ESXLib = "esx:getSharedObject"

--[[
    Configuration des fonctionalités principales
--]]

-- Webhook Discord pour les plaintes
Config.PlaintesWebhook = "https://discordapp.com/api/webhooks/755777995863490631/NZBnAjwWHxDHKi89YTBdREpIofWSLRjZPd7FcnJZ150TXTlpEj0SsNNNvXJ1gUd2MJSk"

-- Webhook Discord pour les demandes de rendez-vous
Config.RdvWebhook = "https://discordapp.com/api/webhooks/755785754315325531/0fRZqu54clzNyORw0QHZi79dx0KLf2-bwszOZn7FhXtvJIG81oUEmCVO2abAZXY7-LrH"

-- Permets de génerer des peds décoratif dans le comissariat.
Config.AddPeds = true

-- Ne pas toucher si vous ne vous y connaissez pas!
Config.Peds = {
    {model = "s_f_y_cop_01", position = vector3(441.06, -978.73, 30.68), heading = 173.8, scenario = "WORLD_HUMAN_CLIPBOARD"}
}