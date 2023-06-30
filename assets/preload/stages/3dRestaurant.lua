function onCreate()
	-- background shit
	makeLuaSprite('bg', 'expunged/restaurant/3D_Hut_BG', -200, 150);
	scaleObject('bg', 0.8, 0.8)

	makeLuaSprite('gp', 'expunged/restaurant/glasspane', -400, -350);
	scaleObject('gp', 1.2, 1.2)

	makeLuaSprite('table', 'expunged/restaurant/tables', -1000, 0);
	scaleObject('table', 1.4, 1.4)

	makeLuaSprite('wall', 'expunged/restaurant/wall', -200, 100);
	scaleObject('wall', 1.2, 1.2)

	makeLuaSprite('THE FUCKING FLOOR', 'expunged/restaurant/floor', -400, -600);
	scaleObject('THE FUCKING FLOOR', 2, 2)

	addLuaSprite('bg', false)
	addLuaSprite('gp', false)
	addLuaSprite('wall', false)
	addLuaSprite('THE FUCKING FLOOR', false)
	addLuaSprite('table', false)
	addLuaSprite('lights', false)

	addGlitchEffect('bg', 1, 5, 0.1)
end