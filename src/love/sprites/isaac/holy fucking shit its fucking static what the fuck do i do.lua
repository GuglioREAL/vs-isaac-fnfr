return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("isaac/Staticlol")),
    	-- Automatically generated from staticlol.xml
	{
		{x = 0, y = 0, width = 306, height = 167, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Static0000
		{x = 0, y = 167, width = 306, height = 167, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Static0001
		{x = 0, y = 334, width = 306, height = 166, offsetX = 0, offsetY = -1, offsetWidth = 306, offsetHeight = 167} -- 3: Static0002
	},
    {
        ["anim"] = {start = 1, stop = 3, speed = 24, offsetX = 0, offsetY = 0}
    },
    "anim",
    true
)