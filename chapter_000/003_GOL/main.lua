local vector_t = require("vector_t")
local cell_t = require("cell_t")
local tools = require("tools")

local cells = {}
local dim = vector_t.new(500, 500)
local div = vector_t.new(25, 25)
local step = vector_t.new(
    dim.x / div.x,
    dim.y / div.y
)
local t = 0


function love.load()
    love.window.setMode(dim.x, dim.y, {
        vsync = 1,
    })
    love.window.setTitle("GOL")

    love.graphics.setBackgroundColor(0, 0, 0.1)

    for x=0, div.x do
        for y=0, div.y do
            table.insert(cells, cell_t.new(
                vector_t.new(x, y),
                tools.fif(love.math.random() < 0.5, 1, 0)
            ))
        end
    end

    shader_rainbow = love.graphics.newShader [[
        extern number t;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 pixel = Texel(texture, texture_coords);
            pixel.r = sin(texture_coords.x * 1.5 + t) * 0.5 + 0.5;
            pixel.r = sin(texture_coords.x * 1.3 + t * 0.75) * 0.5 + 0.5;
            pixel.b = sin(texture_coords.y * 1.7 + t * 2.0) * 0.5 + 0.5;
            return pixel * color;
        }
    ]]

    love.graphics.setShader(shader_rainbow)

    local func = function(a) return a end
    func(5)

    local r = tools.fif(
        love.math.random() < 0.5,
        {f=func, v=4},
        {f=func, v=2}
    )
    r.f(r.v)
end

function love.update(dt)
    t = t + dt
    shader_rainbow:send('t', t)
end

function love.draw()
    for x=0, div.x do
        for y=0, div.y do
            local cell = cells[1 + x + y * div.x]
            if cell.state > 0 then
                local bounds = cell:bounds(dim, div)
                love.graphics.rectangle("fill", bounds.x, bounds.y, step.x, step.y)
            end
        end
    end
end
