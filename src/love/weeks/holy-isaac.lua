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

local stageBack

return {
	enter = function(self, from, songNum, songAppend)
		midweek:enter()

		song = songNum
		difficulty = songAppend

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("isaac/cathedral")))

		girlfriend = love.filesystem.load("sprites/characters/girlfriend.lua")()

		stageBack.sizeX, stageBack.sizeY = 0.85, 0.85

		enemy = love.filesystem.load("sprites/characters/holyisaac.lua")()

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, -40
		boyfriend.x, boyfriend.y = 260, 100

		enemyIcon:animate("isaac", false)

		self:load()
	end,

	load = function(self)
		midweek:load()

		inst = love.audio.newSource("music/isaac/innermost-apocalypse/Inst.ogg", "stream")
		voices = love.audio.newSource("music/isaac/innermost-apocalypse/Voices.ogg", "stream")
	

		self:initUI()

		midweek:setupCountdown()
	end,

	initUI = function(self)
		midweek:initUI()

		
		midweek:generateNotes(love.filesystem.load("charts/isaac/innermost-apocalypse" .. difficulty .. ".lua")())

	end,

	update = function(self, dt)
		midweek:update(dt)
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

		midweek:updateUI(dt)
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
				enemy:draw()
			
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

			love.graphics.pop()
			midweek:drawRating(0.9)
		love.graphics.pop()
		if song == 2 then
			if musicTime >= 136004 then
				if musicTime <= 300000 then
					static:draw()
				end
			end
		end
		midweek:drawUI()
		
	end,

	leave = function(self)
		stageBack = nil
		isaac = nil

		midweek:leave()
	end
}
