local vector_t = require("vector_t")

local cell_t = {}
cell_t.__index = cell_t

function cell_t.new(pos, state)
    local self = setmetatable({}, cell_t)

    self.pos = pos or vector_t.new(0, 0)
    self.state = state or 0

    return self
end

function cell_t:bounds(dim, div)
    local step_x = dim.x / div.x
    local step_y = dim.y / div.y

    return vector_t.new(
        step_x * self.pos.x,
        step_y * self.pos.y
    )
end

return cell_t
