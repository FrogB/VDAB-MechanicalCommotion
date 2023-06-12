nightColor = 'AAAADD';
elapsedtime = 0.0;
function onCreate()
	-- background shit
	makeLuaSprite('Laptop Platform', 'expunged/Laptop_Platform', 800, 150);
	setScrollFactor('Laptop Platform', 1.0, 1.0);
	scaleObject('Laptop Platform', 2.6, 2.6);
	
	--darken the screen so the bloom doesn't ruin the brightness
	makeLuaSprite('darken', '', -500, -500);
	makeGraphic('darken', 1280 * 2, 720 * 2, '000066');
	setScrollFactor('darken', 0, 0);
	screenCenter('darken');
	setProperty('darken.alpha', 0.2);

	addLuaSprite('graysky', false);	
	addLuaSprite('BombuBG', false);
	addLuaSprite('Laptop Platform', false);
	addLuaSprite('poop', false);
	addLuaSprite('darken', true);
	
	addBloomEffect('camGame');
end

function onCreatePost()
	doTweenColor('bfColor', 'boyfriend', nightColor, 0.0001);
	doTweenColor('gfColor', 'gf', nightColor, 0.0001);
	doTweenColor('dadColor', 'dad', nightColor, 0.0001);
end

function onUpdate(elapsed)
	elapsedtime = elapsedtime + elapsed;
	
	setProperty('poop.alpha', math.sin(elapsedtime) / 5 + 0.4);
end