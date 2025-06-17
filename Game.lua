Game = {
    ActiveScene = "Debug1",
    World = love.physics.newWorld(0, (9.8*love.physics.getMeter())*2, true)
}

Game.World:setCallbacks(function(a, b, coll)
    if a:getUserData() == "Player" or b:getUserData() == "Player" then
        require("modules.player").beginContact(a, b, coll)
    end
end, function (a, b, coll)
    if a:getUserData() == "Player" or b:getUserData() == "Player" then
        require("modules.player").endContact(a, b, coll)
    end
end, nil, nil)