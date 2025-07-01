


local Map = {}
Map.__index = Map



function Map.new()
    local self = setmetatable({}, Map)
    
    
    local LevelLoader = require("level_loader")

    
    self.visual = love.graphics.newImage("assets/maps/level1_visual.png")

    
    self.platforms = LevelLoader.load("assets/maps/level1_collision.png")
    
    
    self.rooms = {
        
        { x = 0, y = 0, width = 320, height = 180 },
        
        { x = 320, y = 0, width = 320, height = 180 }
    }

    return self
end

function Map:draw()
    love.graphics.setColor(1, 1, 1)
    
    if self.visual then
        love.graphics.draw(self.visual, 0, 0)
    end
end

return Map
