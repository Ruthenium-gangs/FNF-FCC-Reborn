function onCreate()
	-- background shit
    makeLuaSprite('omissioned', 'stages/Theor/theorbg', -950,-550)
    setLuaSpriteScrollFactor('omissioned', 0, 0); 
    addLuaSprite('omissioned')
	scaleObject('omissioned', 1.5,1.5);
    setScrollFactor('omissioned', 0, 0);

    makeLuaSprite('bg', 'stages/Theor/theowa', -950,-550)
    setLuaSpriteScrollFactor('b', 0.9, 0.9); 
    addLuaSprite('bg')
	scaleObject('bg', 1.5,1.5);
    setScrollFactor('bg', 0, 0);

    makeLuaSprite('b', 'stages/Theor/bro', -950,-550)
    setLuaSpriteScrollFactor('b', 0.9, 0.9); 
    addLuaSprite('b')
	scaleObject('b', 1.5,1.5);
    setScrollFactor('b', 0, 0);

    makeLuaSprite('g', 'stages/Theor/theoground', 400,30)
    setLuaSpriteScrollFactor('g', 0.9, 0.9); 
    addLuaSprite('g')
	scaleObject('g', 0.6,0.6);
    setScrollFactor('g', 1, 1);

    makeLuaSprite('gg', 'stages/Theor/light', -700, 0)
    setLuaSpriteScrollFactor('gg', 0.9, 0.9); 
    addLuaSprite('gg', true)
	scaleObject('gg', 6, 0.6);
    setScrollFactor('gg', 0, 0);

end


local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
	setSpriteShader('omissioned', shadname)
    setSpriteShader('b', shadname)
    setSpriteShader('bg', shadname)
end
	
function onUpdate(elapsed)
	setShaderFloat('omissioned', 'uWaveAmplitude', 0.1)
	setShaderFloat('omissioned', 'uFrequency', 50)
	setShaderFloat('omissioned', 'uSpeed', 0.1)
    setShaderFloat('b', 'uWaveAmplitude', 0.1)
	setShaderFloat('b', 'uFrequency', -41)
	setShaderFloat('b', 'uSpeed', 0.2)
    setShaderFloat('bg', 'uWaveAmplitude', 0.1)
	setShaderFloat('bg', 'uFrequency', 44)
	setShaderFloat('bg', 'uSpeed', 0.5)   
end

function onUpdatePost(elapsed)
	setShaderFloat('omissioned', 'uTime', os.clock())
	setShaderFloat('b', 'uTime', os.clock())
	setShaderFloat('bg', 'uTime', os.clock())
end




