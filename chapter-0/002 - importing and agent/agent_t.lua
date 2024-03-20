local vector_t = require("vector_t")

local agent_t = {}
agent_t.__index = agent_t

function agent_t.new(pos, vel)
    local self = setmetatable({}, agent_t)

    self.pos = pos or vector_t.new(0, 0)
    self.vel = vel or vector_t.new(0, 0)
    self.acc = vector_t.new(0, 0)
    self.friction = 0.98

    return self
end

function agent_t:update(dt)
    self.vel = self.vel + self.acc
    self.vel = self.vel * self.friction * dt
    self.pos = self.pos + self.vel
    self.acc = self.acc * 0.0
end

function agent_t:apply_force(force)
    self.acc = self.acc + force
end

return agent_t
