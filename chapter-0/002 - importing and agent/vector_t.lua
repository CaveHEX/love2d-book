-- vector metatable:
local vector_t = {}
vector_t.__index = vector_t

-- vector constructor:
function vector_t.new(x, y)
    local self = setmetatable({}, vector_t)
    self.x = x or 0
    self.y = y or 0
    return self
end

-- +
function vector_t.__add(a, b) return vector_t.new(a.x + b.x, a.y + b.y) end

-- -
function vector_t.__sub(a, b) return vector_t.new(a.x - b.x, a.y - b.y) end

-- * scalar
function vector_t.__mul(a, b)
    if type(a) == "number" then
        return vector_t.new(b.x * a, b.y * a)
    elseif type(b) == "number" then
        return vector_t.new(a.x * b, a.y * b)
    else
        error("Can only multiply vector by scalar.")
    end
end

--  / scalar
function vector_t.__div(a, b)
    if type(b) == "number" then
        return vector_t.new(a.x / b, a.y / b)
    else
        error("Invalid argument types for vector division.")
    end
end

-- vector equivalence comparison:
function vector_t.__eq(a, b) return a.x == b.x and a.y == b.y end

-- vector not equivalence comparison:
function vector_t.__ne(a, b) return not vector_t.__eq(a, b) end

-- unary negation operator:
function vector_t.__unm(a) return vector_t.new(-a.x, -a.y) end

-- vector < comparison:
function vector_t.__lt(a, b) return a.x < b.x and a.y < b.y end

-- vector <= comparison:
function vector_t.__le(a, b) return a.x <= b.x and a.y <= b.y end

-- vector value string output:
function vector_t.__tostring(v) return "(" .. v.x .. ", " .. v.y .. ")" end

return vector_t
