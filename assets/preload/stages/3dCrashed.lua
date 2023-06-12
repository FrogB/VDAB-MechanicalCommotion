nightColor = 'DDAAAA';
dalapsed = 0.0;
function onCreate()
	makeLuaSprite('Satellite', 'expunged/Satellite', 550, -600);
	setScrollFactor('Satellite', 0.6, 0.6);
	scaleObject('Satellite', 2.0, 1.5);
	doTweenColor('satColor', 'Satellite', 'CCBBBB', 0.0001);

	makeLuaSprite('crashCompooper', 'expunged/crashCompooper', 175, 40);
	setScrollFactor('crashCompooper', 0.8, 0.8);
	scaleObject('crashCompooper', 2.25, 2.25);

	makeLuaSprite('Maus', 'expunged/Maus', 1100, 675);
	setScrollFactor('Maus', 1.0, 1.0);
	scaleObject('Maus', 3.0, 3.0);
	
	--darken the screen so the bloom doesn't ruin the brightness
	makeLuaSprite('darken', '', -500, -500);
	makeGraphic('darken', 1280 * 5, 720 * 5, '330000');
	setScrollFactor('darken', 0, 0);
	screenCenter('darken');
	setProperty('darken.alpha', 0.25);

	addLuaSprite('graysky', false);	
	addLuaSprite('BombaiBG', false);
	addLuaSprite('Satellite', false);
	addLuaSprite('crashCompooper', false);
	addLuaSprite('Maus', false);
	addLuaSprite('darken', true);
	
	addBloomEffect('camGame', 0.25);
end

function onCreatePost()
	-- gf repositioning because it's cool
	setScrollFactor('gfGroup', 0.8, 0.8);
	scaleObject('gfGroup', 0.75, 0.75);
	setProperty('gfGroup.angle', -3);
	characterDance('gf'); --refreshes character
	
	doTweenColor('bfColor', 'boyfriend', nightColor, 0.0001);
	doTweenColor('gfColor', 'gf', nightColor, 0.0001);
	doTweenColor('dadColor', 'dad', nightColor, 0.0001);
end

function onUpdate(elapsed)
	dalapsed = dalapsed + elapsed;

	doTweenY('dadTweenY', 'dad', -150 - 150 * math.sin((dalapsed - 10)), 0.0001)
	doTweenX('dadTweenX', 'dad', -600 + 150 * math.sin((dalapsed)), 0.001)

	setProperty('gfGroup.x', 350 - 25 * math.sin((dalapsed - 10)));
	setProperty('crashCompooper.x', 175 - 25 * math.sin((dalapsed - 10)));
	setProperty('gfGroup.y', 160 - 25 * math.cos((dalapsed - 10)));
	setProperty('crashCompooper.y', 40 - 25 * math.cos((dalapsed - 10)));

	setProperty('boyfriendGroup.y', 100 - 10 * math.cos((dalapsed) * 1.2));
	setProperty('Maus.y', 675 - 10 * math.cos((dalapsed) * 1.2));
	
	--I wanted to make the platform float but I couldn't get bf to float with it so I just scrapped the idea
end