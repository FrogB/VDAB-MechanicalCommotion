camShake = false;
function onEvent(n,v1,v2)

	if n == "LUA-Based Eyesores" then
		if v1 == "1" then
			if flashingLights then
				addPulseEffect('game', 1, 2, 1);
			end
		elseif v1 == "0" then
			clearEffects('game');
			clearShadersFromCamera('game');
			if flashingLights then
				cameraFlash('camGame', 'FFFFFF', 0.15);
			end
		end
	end
end
