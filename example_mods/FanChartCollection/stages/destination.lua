function onCreate()
	-- background shit
    makeLuaSprite('bambi', 'stages/destination/bambi', -950,-550)
    setLuaSpriteScrollFactor('bambi', 0.9, 0.9); 
    addLuaSprite('bambi')
	scaleObject('bambi', 1.5,1.5);
    setScrollFactor('bambi', 0, 0);


end




local shadname = "WavyBackgrounds"

function onCreatePost()
	initLuaShader("WavyBackgrounds")
    setSpriteShader('bambi', shadname)
    setSpriteShader('hortas', shadname)
    setSpriteShader('theore', shadname)
    setSpriteShader('Fallen', shadname)
    setSpriteShader('Dave', shadname)
    setSpriteShader('holy', shadname)
end
	
function onUpdate(elapsed)
    setShaderFloat('bambi', 'uWaveAmplitude', 0.1)
	setShaderFloat('bambi', 'uFrequency', 3)
	setShaderFloat('bambi', 'uSpeed', 0.5)   
end

function onUpdatePost(elapsed)
    setShaderFloat('bambi', 'uTime', os.clock())
    setShaderFloat('hortas', 'uTime', os.clock())
    setShaderFloat('theore', 'uTime', os.clock())
    setShaderFloat('Fallen', 'uTime', os.clock())
    setShaderFloat('Dave', 'uTime', os.clock())
    setShaderFloat('holy', 'uTime', os.clock())

end

function onStepHit()
    if curStep == 1744 then
        removeLuaSprite('bambi');
        makeLuaSprite('hortas', 'stages/destination/hortas', -950,-550);
        addLuaSprite('hortas')
	    scaleObject('hortas', 1.5,1.5);
        setLuaSpriteScrollFactor('hortas', 0.9, 0.9);  
        setScrollFactor('hortas', 0, 0);

        setSpriteShader('hortas', shadname)

        setShaderFloat('hortas', 'uWaveAmplitude', 0.1)
	    setShaderFloat('hortas', 'uFrequency', 3)
	    setShaderFloat('hortas', 'uSpeed', 0.5)   
        
        setShaderFloat('hortas', 'uTime', os.clock())
    end

    if curStep == 3024 then
        removeLuaSprite('hortas');
        makeLuaSprite('theore', 'stages/destination/theore', -950,-550);
        addLuaSprite('theore')
	    scaleObject('theore', 1.5,1.5);
        setLuaSpriteScrollFactor('theore', 0.9, 0.9);  
        setScrollFactor('theore', 0, 0);

        setSpriteShader('theore', shadname)

        setShaderFloat('theore', 'uWaveAmplitude', 0.1)
	    setShaderFloat('theore', 'uFrequency', 3)
	    setShaderFloat('theore', 'uSpeed', 0.5)   
        
        setShaderFloat('theore', 'uTime', os.clock())
    end    

    if curStep == 4368 then
        removeLuaSprite('theore');
        makeLuaSprite('Fallen', 'stages/destination/Fallen', -950,-550);
        addLuaSprite('Fallen')
	    scaleObject('Fallen', 1.5,1.5);
        setLuaSpriteScrollFactor('Fallen', 0.9, 0.9);  
        setScrollFactor('Fallen', 0, 0);

        setSpriteShader('Fallen', shadname)

        setShaderFloat('Fallen', 'uWaveAmplitude', 0.1)
	    setShaderFloat('Fallen', 'uFrequency', 3)
	    setShaderFloat('Fallen', 'uSpeed', 0.5)   
        
        setShaderFloat('Fallen', 'uTime', os.clock())
    end        

    if curStep == 5776 then
        removeLuaSprite('Fallen');
        makeLuaSprite('Dave', 'stages/destination/Dave', -950,-550);
        addLuaSprite('Dave')
	    scaleObject('Dave', 1.5,1.5);
        setLuaSpriteScrollFactor('Dave', 0.9, 0.9);  
        setScrollFactor('Dave', 0, 0);

        setSpriteShader('Dave', shadname)

        setShaderFloat('Dave', 'uWaveAmplitude', 0.1)
	    setShaderFloat('Dave', 'uFrequency', 3)
	    setShaderFloat('Dave', 'uSpeed', 0.5)   
        
        setShaderFloat('Dave', 'uTime', os.clock())
    end      
    
    if curStep == 7184 then
        removeLuaSprite('Dave');
        makeLuaSprite('holy', 'stages/destination/holy', -950,-550);
        addLuaSprite('holy')
	    scaleObject('holy', 1.5,1.5);
        setLuaSpriteScrollFactor('holy', 0.9, 0.9);  
        setScrollFactor('holy', 0, 0);

        setSpriteShader('holy', shadname)

        setShaderFloat('holy', 'uWaveAmplitude', 0.1)
	    setShaderFloat('holy', 'uFrequency', 3)
	    setShaderFloat('holy', 'uSpeed', 0.5)   
        
        setShaderFloat('holy', 'uTime', os.clock())
    end       
end



