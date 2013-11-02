SoundManager= Core.class()

SoundManager.bgmActive = true
SoundManager.sfxActive = true
SoundManager.vibrateActive = true

local SoundManager_Bgm = {}
local SoundManager_Sfx = {}
local SoundManager_BgmCh = nil -- only 1 bgm active at a time

--Sound Manager bertugas untuk mengatur sound
function SoundManager.init() 
	-- example
	--SoundManager.setBgm("mainmenu", "res/bgm/mainmenu.mp3")
end

function SoundManager.setSfx(identifier, asset)
	SoundManager_Sfx[identifier] = Sound.new(asset)
	SoundManager_Sfx[identifier].Ch = nil
end

function SoundManager.setBgm(identifier, asset)
	SoundManager_Bgm[identifier] = Sound.new(asset)
end

function SoundManager.playBgm(identifier)	
	for _,v in pairs(SoundManager_Bgm) do
		if _ == identifier then
			if SoundManager_BgmCh ~= nil then
				SoundManager_BgmCh:stop()
				SoundManager_BgmCh = nil
			end
			SoundManager_BgmCh = v:play()
			SoundManager_BgmCh:setLooping(true)
			if SoundManager.bgmActive ~= true then 
				SoundManager_BgmCh:setPaused(true) 
			end
			return
		end
	end
end

function SoundManager.pauseBgm()
	if SoundManager_BgmCh ~= nil then
		SoundManager_BgmCh:setPaused(true)
	end
end

function SoundManager.resumeBgm()
	if SoundManager_BgmCh ~= nil then
		SoundManager_BgmCh:setPaused(false)
	else
		for _,v in pairs(SoundManager_Bgm) do
			SoundManager.playBgm(_)
			break
		end
	end
end

function SoundManager.resumeBgmFromId(identifier)
	for _,v in pairs(SoundManager_Bgm) do
		if _ == identifier then
			if SoundManager_BgmCh ~= nil then
				SoundManager_BgmCh:setPaused(false)
			else
				SoundManager.playBgm(_)
				break
			end
		end
	end	
end

function SoundManager.playSfx(identifier, isLooping)
	if SoundManager.sfxActive ~= true then return end
	for _,v in pairs(SoundManager_Sfx) do
		if _ == identifier then
			if v.Ch ~= nil then
				v.Ch:stop()
				v.Ch= nil
			end
			v.Ch = v:play()
			if isLooping then
				v.Ch:setLooping(true)
			end
			return
		end
	end
end
