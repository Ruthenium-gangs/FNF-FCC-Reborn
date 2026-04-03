local shaderName = "Real_Mist"
local elapsedTime = 0

function onCreate()
    -- Apply Red_Mist shader to camGame
    prepareShaderForCamGame(shaderName)
end 

function onUpdate(elapsed)

    -- Update shader's time uniform
    elapsedTime = elapsedTime + elapsed
    setShaderFloat("shaderImage", "iTime", elapsedTime)
 end

function prepareShaderForCamGame(shaderName)
    shaderCoordFix() -- Fix for texture coordinate issues

    -- Use sprite for shader implementation
    makeLuaSprite("shaderImage", "TransImage", -700, -400)
    scaleObject('shaderImage', 1.5, 1.5)
	setScrollFactor('shaderImage', 0, 0);
    
    -- Apply the shader to the sprite
    setSpriteShader("shaderImage", shaderName)
    
    -- Add the sprite to the stage (its texture is invisible, but the shader effect will be drawn)
    addLuaSprite("shaderImage", true)

    runHaxeCode([[ 
        var shaderName = "]] .. shaderName .. [["; 
        game.initLuaShader(shaderName);
        var shaderInstance = game.createRuntimeShader(shaderName);
        game.getLuaObject("shaderImage").shader = shaderInstance;
    ]])
end


-- Fix shader coordinate issues for different cameras
function shaderCoordFix()
   runHaxeCode([[
       resetCamCache = function(?spr) {
           if (spr == null || spr.filters == null) return;
           spr.__cacheBitmap = null;
           spr.__cacheBitmapData = null;
       }
       
       fixShaderCoordFix = function(?_) {
           resetCamCache(game.camGame.flashSprite);
           resetCamCache(game.camHUD.flashSprite);
           resetCamCache(game.camOther.flashSprite);
       }
   
       FlxG.signals.gameResized.add(fixShaderCoordFix);
       fixShaderCoordFix();
       return;
   ]])

   local temp = onDestroy
   function onDestroy()
       runHaxeCode([[ 
           FlxG.signals.gameResized.remove(fixShaderCoordFix);
           return;
       ]])
       if temp then temp() end
   end
end