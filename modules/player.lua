local player = {}
local movementDirections = {a = {-1,0}, d = {1,0}, space = {0,-1}}

player.MovementData = {
    ["Speed"] = 9000,
    ["MaxSpeed"] = 600,
    ["Direction"] = -1,
    ["JumpHeight"] = 5000,
    ["OnGround"] = false,
}

local cX, cY = 0, 0
local jumped = false

function player.beginContact(_, _, coll)
    local x, y = coll:getNormal()
    print(x, y)
    if y > 0.5 then
        player.MovementData["OnGround"] = true
        jumped = false
    end
end

function player.endContact(_, _, coll)
    local x, y = coll:getNormal()
    print(x, y)
    if y < 0.0001 then -- why on earth is this 4.5916346780531e-41
        player.MovementData["OnGround"] = false
    end
end

function player:load()
    self.body = love.physics.newBody(Game.World, 400, 100, "dynamic")
    self.body:setLinearDamping(1)
    self.body:setFixedRotation(true)
    self.shape = love.physics.newRectangleShape(100, 100)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData("Player")
    self.fixture:setRestitution(0)
    self.fixture:setCategory(1)

    biribiri:NewAnimation("player", assets["assets/sprites/goose.png"], 32, 32, 0.5)
end

function player:update(dt)
    if not love.keyboard.isDown("space") then
        jumped = false
    end

    for key, data in pairs(movementDirections) do 
        if love.keyboard.isDown(key) then
            local impulseX = 0
            local impulseY = 0

            if key == "space" and self.MovementData.OnGround and not jumped then        
                impulseY = self.MovementData.JumpHeight * data[2]
                jumped = true
            else
                impulseX = self.MovementData.Speed * data[1] * dt
                
                if key == "a" then
                    self.MovementData.Direction = 1
                elseif key == "d" then
                    self.MovementData.Direction = -1
                end
            end
            
            self.body:applyLinearImpulse(impulseX, impulseY)
        end
    end

    local vx, _ = self.body:getLinearVelocity()
    if math.abs(vx) > 50 then
        biribiri:UpdateAnimation("player", dt)
    else
        biribiri:ResetAnimation("player")
    end
end

function player:draw()
    -- TODO: make the first frame not included in the animation
    local animation = animations["player"]
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1

    if not animation.quads[spriteNum] then
        spriteNum = 1
    end

    if animation.currentTime ~= 0 then
        spriteNum = math.max(spriteNum, 2)
    end


    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], self.body:getX(), self.body:getY(), 0, self.MovementData["Direction"] * 100/32, 100/32, 16, 16)
    love.graphics.setColor(0,0,1)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.setColor(1,1,1)
end

return player