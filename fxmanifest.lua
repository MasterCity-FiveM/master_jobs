fx_version 'adamant'
games { 'rdr3', 'gta5' }

description 'MasterkinG32 jobs (MasterkinG32#9999)'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua',
}

dependencies {
	'es_extended',
}