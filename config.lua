Config = {}


Config.JobBlips = {
	['Truck'] = {
		coords = vector3(1208.321, -3114.976, 5.538452),
		
		Blip = {
			Sprite = 545,
			Colour = 0,
			name = 'BarBari',
			Scale = 1.0,
		}
	}
}

Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.Truck = {
	{
		title = 'چوب - 2500$',
		payment = 2500,
		vehicles = {'hauler', 'trailerlogs'},
		start = {vector3(1171.319, -3114.382, 5.79126), 0.0},
		trailer = {vector3(1282.339, -3074.268, 5.892334), 93.5433},
		arrive = vector3(-558.0264, 5374.457, 70.3092),
		taken = false
	},
	{
		title = 'مواد شیمیایی - 1500$',
		payment = 1500,
		vehicles = {'hauler', 'tanker'},
		start = {vector3(1177.912, -3111.297, 6.0271), 0.0},
		trailer = {vector3(1135.279, -3083.552, 5.79126), 269.2913},
		arrive = vector3(3631.714, 3757.596, 28.50476),
		taken = false
	},
	{
		title = 'ماشین - 1200$',
		payment = 1200,
		vehicles = {'hauler', 'tr4'},
		start = {vector3(1188.58, -3075.073, 5.841797), 272.125976},
		trailer = {vector3(1132.919, -3098.703, 5.858643), 269.29135},
		arrive = vector3(-14.2945, -1096.246, 26.6680),
		taken = false
	},
	{
		title = 'ارتش - 2000$',
		payment = 2000,
		vehicles = {'hauler', 'armytanker'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1216.365, -3004.365, 5.858643), 178.58267},
		arrive = vector3(-2133.257, 3419.842, 31.50403),
		taken = false
	},
	{
		title = 'معدن - 2000$',
		payment = 2000,
		vehicles = {'hauler', 'docktrailer'},
		start = {vector3(1220.466, -3078.62, 5.892334), 87.87},
		trailer = {vector3(1271.367, -3160.51, 5.892334), 87.8740},
		arrive = vector3(2827.859, 2800.615, 57.60437),
		taken = false
	},
	{
		title = 'صدا و سیما - 500$',
		payment = 500,
		vehicles = {'hauler', 'tvtrailer'},
		start = {vector3(1171.78, -3126.343, 5.79126), 0.0},
		trailer = {vector3(1287.389, -3198.633, 5.892334), 87.87401},
		arrive = vector3(-258.5143, -2080.734, 27.61169),
		taken = false
	},
	--[[{
		title = 'تجهیزات - 1500$',
		payment = 1500,
		vehicles = {'phantom', 'trailerlarge'},
		start = {vector3(1152, -3095.934, 5.808105), 357.1653},
		trailer = {vector3(1201.042, -3194.176, 6.0271), 181.41732},
		arrive = vector3(1872.303, 280.8396, 164.2975),
		taken = false
	},]]--
}