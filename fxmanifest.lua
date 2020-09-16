fx_version 'adamant'

game 'gta5'

description 'PoliceJob by Pablo Z.'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'zones.lua',
	-- Gestionnaire de zones
	'modules/zones/zonesManager.lua',
	'modules/zones/zonesThread.lua',
	'client/main.lua',
	-- Rage UI V2
	"src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
	"src/client/menu/windows/*.lua",
	-- Menus
	'modules/menus/manager.lua',
}
