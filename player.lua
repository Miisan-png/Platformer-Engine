


local Player = {}
Player.__index = Player

local Collision = require("collision2d")

function Player.new(x, y)
    local self = setmetatable({}, Player)

    self.x = x
    self.y = y
    self.width = 16
    self.height = 16

    self.vx = 0 
    self.vy = 0 

    self.gravity = 800
    self.maxFallSpeed = 400
    self.moveSpeed = 150
    self.acceleration = 1200
    self.friction = 1000

    self.jumpForce = -250
    self.jumpReleaseForce = -100
    self.isGrounded = false

    self.coyoteTime = 0.1
    self.coyoteTimer = 0

    self.jumpBuffer = 0.1
    self.jumpBufferTimer = 0

    
    self.image = nil

    return self
end

function Player:update(dt, map)
    local moveDirection = 0
    if love.keyboard.isDown("left") then
        moveDirection = -1
    elseif love.keyboard.isDown("right") then
        moveDirection = 1
    end

    if moveDirection ~= 0 then
        self.vx = self.vx + moveDirection * self.acceleration * dt
        self.vx = math.clamp(self.vx, -self.moveSpeed, self.moveSpeed)
    else
        if self.vx > 0 then
            self.vx = math.max(0, self.vx - self.friction * dt)
        elseif self.vx < 0 then
            self.vx = math.min(0, self.vx + self.friction * dt)
        end
    end

    self.coyoteTimer = self.coyoteTimer - dt
    self.jumpBufferTimer = self.jumpBufferTimer - dt

    if love.keyboard.isDown("x") then
        self.jumpBufferTimer = self.jumpBuffer
    end

    if self.jumpBufferTimer > 0 and self.coyoteTimer > 0 then
        self.vy = self.jumpForce
        self.jumpBufferTimer = 0 
        self.coyoteTimer = 0
    end
    
    if not love.keyboard.isDown("x") and self.vy < self.jumpReleaseForce then
        self.vy = self.jumpReleaseForce
    end

    self.vy = self.vy + self.gravity * dt
    self.vy = math.min(self.vy, self.maxFallSpeed)

    self.x = self.x + self.vx * dt
    for _, platform in ipairs(map.platforms) do
        if Collision.check(self, platform) then
            if self.vx > 0 then
                self.x = platform.x - self.width
            elseif self.vx < 0 then
                self.x = platform.x + platform.width
            end
            self.vx = 0
        end
    end

    self.isGrounded = false

    self.y = self.y + self.vy * dt
    for _, platform in ipairs(map.platforms) do
        if Collision.check(self, platform) then
            if self.vy > 0 then 
                self.y = platform.y - self.height
                self.isGrounded = true
                self.coyoteTimer = self.coyoteTime 
                self.vy = 0
            elseif self.vy < 0 then 
                self.y = platform.y + self.height
                self.vy = 0
            end
        end
    end

    if self.isGrounded then
        self.coyoteTimer = self.coyoteTime
    end
end

function Player:draw()
    if self.image then
        love.graphics.draw(self.image, self.x, self.y)
    else
        love.graphics.setColor(1, 1, 1) 
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function math.clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

return Player
