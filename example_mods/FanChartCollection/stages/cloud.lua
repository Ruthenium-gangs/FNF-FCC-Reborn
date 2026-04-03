function onCreate()
	makeLuaSprite('bg', 'stages/cloud', -700, -500);
	scaleObject('bg', 2, 2)
	setScrollFactor('bg', 0, 0);
	addLuaSprite('bg', false);

end


local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
	setSpriteShader('bg', shadname)
end
	
function onUpdate(elapsed)
	setShaderFloat('bg', 'uWaveAmplitude', 0.1)
	setShaderFloat('bg', 'uFrequency', 1)
	setShaderFloat('bg', 'uSpeed', 0.5)
end

function onUpdatePost(elapsed)
	setShaderFloat('bg', 'uTime', os.clock())
end

