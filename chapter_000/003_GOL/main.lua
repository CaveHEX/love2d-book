local vector_t = require("vector_t")
local cell_t = require("cell_t")
local gol_t = require("gol_t")
local tools = require("tools")

local cells = {}
local cells_spare = {}
local dim = vector_t.new(1000, 1000)
local div = vector_t.new(250, 250)
local step = vector_t.new(
    dim.x / div.x,
    dim.y / div.y
)
local t = 0
local iter = 0


function love.load()
    love.window.setMode(dim.x, dim.y, {
        vsync = 1,
    })
    love.window.setTitle("GOL")

    love.graphics.setBackgroundColor(0, 0, 0.1)

    cells = gol_t.init_cells(div, "random")

    shader_rainbow = love.graphics.newShader [[
        extern number t;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
        {
            vec4 pixel = Texel(texture, texture_coords);
            pixel.r = sin(pixel_coords.x * 0.01 + t) * 0.3 + 0.75;
            pixel.g = sin(pixel_coords.y * 0.012 + t * 0.75) * 0.3 + 0.75;
            pixel.b = sin(pixel_coords.y * 0.008 + t * 2.0) * 0.3 + 0.75;
            return pixel * color;
        }
    ]]

    love.graphics.setShader(shader_rainbow)
end

function love.update(dt)
    t = t + dt
    shader_rainbow:send('t', t)

    iter = iter + 1
    if iter % 5 == 0 then
        cells = gol_t.update(cells, div)
    end
end


function love.draw()
    for x=0, div.x do
        for y=0, div.y do
            local cell = cells[gol_t.get_index(x, y, div)]
            if cell.state > 0 then
                local bounds = cell:bounds(dim, div)
                love.graphics.rectangle("fill", bounds.x, bounds.y, step.x, step.y)
            end
        end
    end
end
