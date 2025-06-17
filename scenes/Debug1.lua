local player = require "modules.player"
local Scene = {
    name = "Debug1"
}


function Scene:activate()
    player:load()
end

function Scene:draw()
    player:draw()
end

function Scene:update(dt)
    player:update(dt)
end

return Scene