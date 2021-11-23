--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

local song, difficulty

local stageBack, curtains

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("isaac/basement")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("isaac/gapers")))

		girlfriend = love.filesystem.load("sprites/characters/girlfriend.lua")()

		curtains.y = 295

		curtains.sizeX, curtains.sizeY = 0.45, 0.45

		stageBack.sizeX, stageBack.sizeY = 0.85, 0.85

		enemy = love.filesystem.load("sprites/characters/funkyisaac.lua")()

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, 70
		boyfriend.x, boyfriend.y = 260, 100

		enemyIcon:animate("isaac", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 1 then
			inst = love.audio.newSource("music/isaac/sacrificial/Inst.ogg", "stream")
			voices = love.audio.newSource("music/isaac/sacrificial/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/isaac/innocence-glitched/Inst.ogg", "stream")
			voices = love.audio.newSource("music/isaac/innocence-glitched/Voices.ogg", "stream")

			isaac = love.filesystem.load("sprites/characters/isaacswitch.lua")()

			static = love.filesystem.load("sprites/isaac/holy fucking shit its fucking static what the fuck do i do.lua")()

			static.sizeX, static.sizeY = 15, 15

			isaac.y = 70
			isaac.x = -380
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 1 then
			weeks:generateNotes(love.filesystem.load("charts/isaac/sacrificial" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/isaac/innocence-glitched" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		if song == 2 then
			isaac:update(dt)
			if musicTime >= 136004 then
				if musicTime <= 300000 then
					if enemy:getAnimName() == "up" then
						isaac:animate("up", false)
						enemy:animate("yo mama", false)
					elseif enemy:getAnimName() == "down" then
						isaac:animate("down", false)
						enemy:animate("yo mama", false)
					elseif enemy:getAnimName() == "left" then
						isaac:animate("left", false)
						enemy:animate("yo mama", false)
					elseif enemy:getAnimName() == "right" then
						isaac:animate("right", false)
						enemy:animate("yo mama", false)
					end
				end
			end
		end
		if health >= 80 then
			if enemyIcon:getAnimName() == "isaac" then
				enemyIcon:animate("isaac losing", false)
			end
		else
			if enemyIcon:getAnimName() == "isaac losing" then
				enemyIcon:animate("isaac", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 2 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				stageBack:draw()

				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
			if song == 1 then
				enemy:draw()
			end
			if song == 2 then
				if musicTime <= 136004 then
					if musicTime <= 300000 then
						enemy:draw()
					end
				end
				if musicTime >= 136004 then
					if musicTime <= 300000 then
						isaac:draw()
					end
				end
			end
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

				curtains:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		if song == 2 then
			if musicTime >= 136004 then
				if musicTime <= 300000 then
					static:draw()
				end
			end
		end
		weeks:drawUI()
		
	end,

	leave = function(self)
		stageBack = nil
		curtains = nil
		isaac = nil

		weeks:leave()
	end
}
