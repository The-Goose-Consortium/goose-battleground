local environment = {}
environment.Scenes = {}

environment.Scenes.Debug1 = {
    loaded = false,
    load = function(self)
        self.ground = {}
        self.ground.body = love.physics.newBody(Game.World, 400, 300, "static")
        self.ground.shape = love.physics.newRectangleShape(500, 50)
        self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)
    end,
    update = function(self)
        
    end,
    draw = function(self)
        if self.ground and self.ground.body and self.ground.shape then
            love.graphics.setColor(1, 0, 0)
            love.graphics.polygon("line", self.ground.body:getWorldPoints(self.ground.shape:getPoints()))
            love.graphics.setColor(1, 1, 1)
        else
            print("nope!")
        end
    end,
    unload = function(self)

    end,
}

function environment:update(dt)
    local scene = self.Scenes[Game.ActiveScene]
    if scene then
       scene.update(scene)
        if scene.loaded == false then 
            scene.loaded = true
            scene:load()
        end
    end
end

function environment:draw()
    local scene = self.Scenes[Game.ActiveScene]
    if scene then
       scene.draw(scene)
    end
end

return environment