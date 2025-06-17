require "libraries.biribiri.main"
require "Game"
require "modules.SceneManager"

function love.load()
    love.window.setTitle("Goose Battleground")
    biribiri:LoadSprites("assets/sprites")
    biribiri:LoadAudio("assets/audio/music", "stream")
    biribiri:LoadAudio("assets/audio/sfx", "static")
    SceneManager:RegisterAllScenes()
end

function love.update(dt)
    biribiri:Update(dt)
    SceneManager:UpdateScene(Game.ActiveScene, dt)
end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.setColor(0,0,0)
    SceneManager:DrawScene(Game.ActiveScene)
end