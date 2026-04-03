luaDebugMode = true

-- If enabled, subtitles will be taken from TXT files
-- When enabled, using the event will take lines from the TXT file instead of what's in value 1
local useFromFile = false

-- Supports subtitle translations for versions 1.0 and above. Will look for the TXT file with the .lang file name appended to it, examples: "subtitles/bopeebo-pt-BR.txt" or "subtitles/global-pt-BR.txt"
-- Defaults to the normal TXT file if the translated TXT file isn't able to be found
-- ADD YOUR .LANG FILE NAMES HERE IF YOU WANT IT TO SUPPORT YOUR LANGUAGE!
local translations = {
    -- 'pt-BR'
}

-- Which path should the subtitles be taken from?
-- example: If subtitlePath is set to "subtitles/", the game will take "subtitles/SONGNAME.txt" or "subtitles/global.txt" if global subtitles are enabled
local subtitlePath = 'subtitles/'

-- If enabled, uses "global.txt" for all subtitles, and will try to find the song name within global.txt
local useGlobalSubtitles = false

-- If enabled, the subtitles will be taken from "data/SONGNAME/SONGNAME.txt"
-- example: "data/bopeebo/bopeebo.txt"
local useSongPath = false

-- Default values that will be given for each subtitle made
-- Some values cannot be changed via the event, like the positions or the sounds, so it is up to you if you want to change those
local defaultData = {
    x = 640, -- The x position of the subtitle, only works if centerAxis is not set to X or XY
    y = 160, -- The y position of the subtitle, only works if centerAxis is not set to Y or XY
    centerSub = true, -- Centers the subtitle
    centerAxis = 'X', -- Which axis to center the subtitle on, only works if centerSub is true
    font = 'vcr.ttf', -- The font of the subtitle
    duration = 1, -- The amount of time that the subtitle stays on screen before disappearing
    subtitleSize = 36, -- The size of the subtitle text
    typeSpeed = 0.02, -- The speed that the subtitle types at
    sounds = {} -- List of sounds that will play while being typed, e.g {'sounds/soundName'} will play the sound from sounds/soundName
}

local lines = {}
local lineCount = 1
function onEvent(name, v1, v2)
    if name:lower() == 'dnb subtitle' then
        local splitV2 = stringSplit(v2, ',')

        local duration = tonumber(splitV2[1]) or 1
        local size = tonumber(splitV2[2]) or 36
        local speed = tonumber(splitV2[3]) or 0.02
        startSubtitle(useFromFile and lines[lineCount] or v1, duration, size, speed)
    end
end

function onCreate()
    if useFromFile then
        if subtitlePath:sub(#subtitlePath) ~= '/' then subtitlePath = subtitlePath..'/' end

        local path = subtitlePath..songPath..'.txt'
        if useSongPath then
            path = 'data/'..songPath..'/'..songPath..'.txt'
        end
        if useGlobalSubtitles then
            path = subtitlePath..'global.txt'
        end
        lines = getSubtitle(path, useGlobalSubtitles, songPath)
    end

    for _, sound in pairs(defaultData.sounds) do
        precacheSound(sound)
    end

    runHaxeCode([[
        createCallback('setSubtitleCallback', function(sub:String, ?duration:Float) {
            if (duration == null || duration <= 0) duration = 1;
            getVar(sub).completeCallback = function() {
                new FlxTimer().start(duration, function(tmr) {
                    FlxTween.tween(getVar(sub), { alpha: 0 }, 0.5, { onComplete: function(twn) {
                        getVar(sub).destroy();
                        remove(getVar(sub));
                        removeVar(sub);
                    } });
                });
            }
        });

        createCallback('setSubtitleSounds', function(sub:String, sounds:Array<String>) {
            if (sounds.length <= 0) return;
            getVar(sub).sounds = [for (sound in sounds) FlxG.sound.load(Paths.returnSound(sound))];
        });
    ]])
end

function startSubtitle(text, duration, size, typeSpeed, sounds)
    if sounds == nil then sounds = {} end
    createInstance('subtitle'..lineCount, 'flixel.addons.text.FlxTypeText', {defaultData.x, defaultData.y, screenWidth, text, size})
    setProperty('subtitle'..lineCount..'.antialiasing', true)
    setTextFont('subtitle'..lineCount, defaultData.font)
    setTextBorder('subtitle'..lineCount, 2, 'black')
    setTextAlignment('subtitle'..lineCount, 'center')
    if version == '1.0' then -- wish i could go back in time and prevent myself from removing the stupid dynamic type in the pr
        setProperty('subtitle'..lineCount..'.camera', instanceArg('camOther'), false, true)
    else
        setObjectCamera('subtitle'..lineCount, 'other')
    end
    setSubtitleCallback('subtitle'..lineCount, duration)
    if #sounds > 0 then setSubtitleSounds('subtitle'..lineCount, sounds) end
    if defaultData.centerSub then screenCenter('subtitle'..lineCount, defaultData.centerAxis) end
    callMethod('subtitle'..lineCount..'.start', {typeSpeed})
    addInstance('subtitle'..lineCount, true)
    lineCount = lineCount + 1
end

function getSubtitle(path, isGlobal, song)
    if path == nil or path == '' then return {} end
    if path:find('.txt') == nil then path = path..'.txt' end
    if isGlobal == nil then isGlobal = false end

    local translatedPath = nil
    -- No language support for 0.7.x
    if version >= '1.0' then
        translatedPath = path
        if getPropertyFromClass('backend.ClientPrefs', 'data.language') ~= 'en-US' then
            translatedPath = translatedPath:gsub('.txt', '-'..getPropertyFromClass('backend.ClientPrefs', 'data.language')..'.txt')
        end
        if checkFileExists(translatedPath) then
            path = translatedPath
        else
            -- if translatedPath ~= path then debugPrint('WARNING: '..scriptName..': Translated subtitle path "'..translatedPath..'" not found!', 'yellow') end -- uncomment this if needed for debug purposes
            translatedPath = nil
        end
    end
    if translatedPath == nil and not checkFileExists(path) then
        debugPrint('ERROR: '..scriptName..': Subtitle path "'..path..'" not found!', 'red')
        return {}
    end

    local text = getTextFromFile(path)
    if #stringTrim(text) <= 0 then
        return {}
    end

    local split = stringSplit(text, '\n')
    local lines = {}
    local k = 1
    for _, line in pairs(split) do
        if #stringTrim(line) > 0 and stringTrim(line):find('//') ~= 1 then
            if not isGlobal then
                lines[k] = line
                k = k + 1
            elseif stringTrim(line:lower()):find(song:lower()) ~= nil then
                lines[k] = stringSplit(line, '==')[2]
                k = k + 1
            end
        end
    end
    return lines
end