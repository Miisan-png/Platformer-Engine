


local Camera = {}
Camera.__index = Camera


local Tween = require("tween")

function Camera.new(map)
    local cam = setmetatable({}, Camera)

    cam.x = 0
    cam.y = 0
    cam.width = VIRTUAL_WIDTH   
    cam.height = VIRTUAL_HEIGHT 

    cam.map = map
    cam.currentRoom = nil

    return cam
end

function Camera:update(dt, player)
    
    Tween.update(dt)

    
    local playerRoom = self:getRoomForPosition(player.x + player.width / 2, player.y + player.height / 2)

    
    if playerRoom and playerRoom ~= self.currentRoom then
        self.currentRoom = playerRoom
        
        Tween.new(self, "x", self.currentRoom.x, 0.4, "easeInOutQuad")
        Tween.new(self, "y", self.currentRoom.y, 0.4, "easeInOutQuad")
    end
end


function Camera:getRoomForPosition(px, py)
    for _, room in ipairs(self.map.rooms) do
        if px >= room.x and px < room.x + room.width and
           py >= room.y and py < room.y + room.height then
            return room
        end
    end
    return nil
end



function Camera:attach()
    love.graphics.push()
    love.graphics.translate(-math.floor(self.x), -math.floor(self.y))
end



function Camera:detach()
    love.graphics.pop()
end

return Camera
