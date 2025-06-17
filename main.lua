require "libraries.biribiri.main"
require "Game"
require "modules.SceneManager"
local environment = require "modules.environment"

function love.load()
    love.window.setTitle("Goose Battleground")
    love.graphics.setDefaultFilter("nearest", "nearest")
    biribiri:LoadSprites("assets/sprites")
    biribiri:LoadAudio("assets/audio/music", "stream")
    biribiri:LoadAudio("assets/audio/sfx", "static")
    SceneManager:RegisterAllScenes()
    SceneManager:SetActiveScene(Game.ActiveScene)
end

function love.update(dt)
    Game.World:update(dt)
    biribiri:Update(dt)
    SceneManager:UpdateScene(Game.ActiveScene, dt)
    environment:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    SceneManager:DrawScene(Game.ActiveScene)
    environment:draw()
end