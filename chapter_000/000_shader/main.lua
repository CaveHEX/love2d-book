t = 0.0

function love.load()
    love.window.setMode(1080, 1080)
    love.window.setTitle('Shading da shader')

    i_cast_gpu_magic = love.graphics.newShader[[
        extern number t;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
        {
            vec4 pixel = Texel(texture, texture_coords);
            pixel.r = pixel.r + sin(texture_coords.x * 1.5 + t);
            pixel.b = pixel.b + sin(texture_coords.y * 1.5 + t * 2.0);
            return pixel * color;
        }
    ]]

    img = love.graphics.newImage('card_258.png', {})
end

function love.update(dt)
    t = t + dt
    i_cast_gpu_magic:send('t', t)
end

function love.draw()
    love.graphics.setShader(i_cast_gpu_magic)
    love.graphics.draw(img, 0, 0)
    love.graphics.setShader()
end
