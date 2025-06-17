SceneManager = {}

---@class Scene
---@field name string The name of the scene
---@field draw fun(self: Scene) The draw function to run every frame
---@field update fun(self: Scene, dt: number) The update function to run every frame

---@type table<Scene>
SceneManager.scenes = {}
SceneManager.activeScene = nil

---Register all scenes
function SceneManager:RegisterAllScenes()
    self:RegisterScene(require("scenes.Debug1"))
end

---Register a scene
---@param scene Scene The scene to register
function SceneManager:RegisterScene(scene)
    table.insert(self.scenes, scene)
end

function SceneManager:DrawScene(sceneName)
    for _,v in pairs(self.scenes) do 
        if v.name == sceneName then 
            v:draw()
        end
    end
end

function SceneManager:UpdateScene(sceneName, dt)
    for _,v in pairs(self.scenes) do 
        if v.name == sceneName then 
            v:update(dt)
        end
    end
end

function SceneManager:SetActiveScene(name)
    local found = false
    for _,v in pairs(self.scenes) do 
        if v.name == name then 
            found = true
            break
        end
    end

    if found == false then 
        print("⚠️ | A scene with the name " .. name .. " could not be found.")
        return
    end

    self.activeScene = name
end

return SceneManager