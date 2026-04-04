function onCreate()
	-- background shit
    makeLuaSprite('insanebg', 'stages/insane/insanebg', -950,-550)
    setLuaSpriteScrollFactor('insanebg', 0.9, 0.9); 
    addLuaSprite('insanebg')
	scaleObject('insanebg', 4.3,4.3);
    setScrollFactor('insanebg', 0, 0);

    makeLuaSprite('bgshit', 'stages/insane/bgshit', -1350,-550)
    setLuaSpriteScrollFactor('bgshit', 0.9, 0.9); 
    addLuaSprite('bgshit')
	scaleObject('bgshit', 4.3,4.3);
    setScrollFactor('bgshit', 0, 0);

    makeLuaSprite('pillar', 'stages/insane/pillar', 870,130)
    setLuaSpriteScrollFactor('pillar', 0.9, 0.9); 
    addLuaSprite('pillar')
	scaleObject('pillar', 4.3,4.3);
    setScrollFactor('pillar', 1, 1);

    makeLuaSprite('gg', 'stages/insane/light', -1000, -90)
    setLuaSpriteScrollFactor('gg', 0.9, 0.9); 
    addLuaSprite('gg', true)
	scaleObject('gg', 6, 0.6);
    setScrollFactor('gg', 0, 0);   
    
    makeLuaSprite('gg2', 'stages/insane/light2', -1000, -550)
    setLuaSpriteScrollFactor('gg2', 0.9, 0.9); 
    addLuaSprite('gg2', true)
	scaleObject('gg2', 6, 0.6);
    setScrollFactor('gg2', 0, 0);        


end

local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
	setSpriteShader('insanebg', shadname)
    setSpriteShader('bgshit', shadname)
end
	
function onUpdate(elapsed)
	setShaderFloat('insanebg', 'uWaveAmplitude', 0.1)
	setShaderFloat('insanebg', 'uFrequency', 300)
	setShaderFloat('insanebg', 'uSpeed', 1)

	setShaderFloat('bgshit', 'uWaveAmplitude', 0.1)
	setShaderFloat('bgshit', 'uFrequency', 20)
	setShaderFloat('bgshit', 'uSpeed', 1)    
end

function onUpdatePost(elapsed)
	setShaderFloat('insanebg', 'uTime', os.clock())
    setShaderFloat('bgshit', 'uTime', os.clock())
end

