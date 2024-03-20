local vector_t = require("vector_t")
local agent_t = require("agent_t")
local utilities_t = require("utilities_t")

function love.load()
    love.window.setMode(500, 500)
    love.window.setTitle('Agents')

    agent_a = agent_t.new(vector_t.new(250, 250), vector_t.new(100, 0))

    love.graphics.setBackgroundColor(0, 0, 0)
end

function love.update(dt)
    local dir = vector_t.new(0, 0)

    if love.keyboard.isDown('z') then dir.y = dir.y - 1.0 end
    if love.keyboard.isDown('q') then dir.x = dir.x - 1.0 end
    if love.keyboard.isDown('s') then dir.y = dir.y + 1.0 end
    if love.keyboard.isDown('d') then dir.x = dir.x + 1.0 end

    agent_a:apply_force(dir * 10.0)

    agent_a:update(dt)
end

function love.draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", agent_a.pos.x, agent_a.pos.y, 5)
end
