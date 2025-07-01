



VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 180
local canvas


local Player = require("player")
local Map = require("map")
local Collision = require("collision2d")
local Camera = require("camera")


local player
local map
local camera

function love.load()
    
    canvas = love.graphics.newCanvas(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    canvas:setFilter("nearest", "nearest")
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    
    map = Map.new()
    player = Player.new(40, 140) 
    camera = Camera.new(map)

    love.graphics.setBackgroundColor(135/255, 206/255, 235/255)
end

function love.update(dt)
    
    local clamped_dt = math.min(dt, 1/30)

    
    player:update(clamped_dt, map)
    camera:update(clamped_dt, player)
end

function love.draw()
    
    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    
    camera:attach()

    
    map:draw()
    player:draw()

    
    camera:detach()

    
    love.graphics.setCanvas()

    
    local scale = math.min(love.graphics.getWidth() / VIRTUAL_WIDTH, love.graphics.getHeight() / VIRTUAL_HEIGHT)
    local x = (love.graphics.getWidth() - VIRTUAL_WIDTH * scale) / 2
    local y = (love.graphics.getHeight() - VIRTUAL_HEIGHT * scale) / 2
    love.graphics.draw(canvas, x, y, 0, scale, scale)
end
