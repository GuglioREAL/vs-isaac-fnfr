return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("menu/MenuIdle")),
	-- Automatically generated from MenuIdle.xml
	{
		{x = 0, y = 0, width = 457, height = 425, offsetX = -6, offsetY = 0, offsetWidth = 478, offsetHeight = 426}, -- 1: MenuIdle0000
		{x = 0, y = 0, width = 457, height = 425, offsetX = -6, offsetY = 0, offsetWidth = 478, offsetHeight = 426}, -- 2: MenuIdle0001
		{x = 0, y = 425, width = 478, height = 417, offsetX = 0, offsetY = -9, offsetWidth = 478, offsetHeight = 426}, -- 3: MenuIdle0002
		{x = 0, y = 425, width = 478, height = 417, offsetX = 0, offsetY = -9, offsetWidth = 478, offsetHeight = 426} -- 4: MenuIdle0003
	},
    {
        ["anim"] = {start = 1, stop = 4, speed = 10, offsetX = 0, offsetY = 0}
    },
    "anim",
    true
)