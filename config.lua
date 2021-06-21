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
		title = 'چوب',
		payment = 2500,
		vehicles = {'phantom', 'trailerlogs'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1272.158, -3097.556, 5.892334), 90.78},
		arrive = vector3(-558.0264, 5374.457, 70.3092),
		taken = false
	},
	{
		title = 'مزرعه',
		payment = 2000,
		vehicles = {'phantom', 'baletrailer'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1272.158, -3097.556, 5.892334), 90.78},
		arrive = vector3(1912.787, 4938.87, 48.80884),
		taken = false
	},
	{
		title = 'مواد شیمیایی',
		payment = 1500,
		vehicles = {'phantom', 'tanker'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1272.158, -3097.556, 5.892334), 90.78},
		arrive = vector3(3631.714, 3757.596, 28.50476),
		taken = false
	},
	{
		title = 'ماشین',
		payment = 1200,
		vehicles = {'phantom', 'tr4'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1272.158, -3097.556, 5.892334), 90.78},
		arrive = vector3(-14.2945, -1096.246, 26.6680),
		taken = false
	},
	{
		title = 'قایق',
		payment = 1000,
		vehicles = {'phantom', 'tr3'},
		start = {vector3(1189.793, -3104.505, 5.757568), 0.0},
		trailer = {vector3(1272.158, -3097.556, 5.892334), 90.78},
		arrive = vector3(-1169.13, -1768.998, 3.853516),
		taken = false
	},
}