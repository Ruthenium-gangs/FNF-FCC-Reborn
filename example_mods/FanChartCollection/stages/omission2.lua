function onCreate()
	-- background shit
    makeLuaSprite('omissioned', 'stages/omissioned', -950,-550)
    setLuaSpriteScrollFactor('omissioned', 0.9, 0.9); 
    addLuaSprite('omissioned')
	scaleObject('omissioned', 1.5,1.5);
    setScrollFactor('omissioned', 0, 0);

end

local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
	setSpriteShader('omissioned', shadname)
end
	
function onUpdate(elapsed)
	setShaderFloat('omissioned', 'uWaveAmplitude', 0.1)
	setShaderFloat('omissioned', 'uFrequency', 200)
	setShaderFloat('omissioned', 'uSpeed', 5)
end

function onUpdatePost(elapsed)
	setShaderFloat('omissioned', 'uTime', os.clock())
end

