local vector_t = require("vector_t")
local cell_t = require("cell_t")
local tools = require("tools")

local gol_t = {}
gol_t.__index = gol_t

function gol_t.init_cells(div, config)
    local cells = {}

    for x=0, div.x do
        for y=0, div.y do
            local state = 0

            if config == "random" then
                state = tools.fif(love.math.random() < 0.45, 1, 0)
            end

            table.insert(cells, cell_t.new(
                vector_t.new(x, y),
                state
            ))
        end
    end

    return cells
end

function gol_t.get_index(x, y, div) return 1 + x + (y * (div.x+1)) end

function get_neighbour_count(cells, x, y, div)
    local count = 0

    -- if x > 0 and                           cells[gol_t.get_index(x - 1, y, div)].state == 1     then count = count + 1 end
    -- if x < div.x - 1 and                   cells[gol_t.get_index(x + 1, y, div)].state == 1     then count = count + 1 end
    -- if y > 0 and                           cells[gol_t.get_index(x, y - 1, div)].state == 1     then count = count + 1 end
    -- if y < div.y - 1 and                   cells[gol_t.get_index(x, y + 1, div)].state == 1     then count = count + 1 end
    -- if x > 0 and y > 0 and                 cells[gol_t.get_index(x - 1, y - 1, div)].state == 1 then count = count + 1 end
    -- if x < div.x - 1 and y > 0 and         cells[gol_t.get_index(x + 1, y - 1, div)].state == 1 then count = count + 1 end
    -- if x > 0 and y < div.y - 1 and         cells[gol_t.get_index(x - 1, y + 1, div)].state == 1 then count = count + 1 end
    -- if x < div.x - 1 and y < div.y - 1 and cells[gol_t.get_index(x + 1, y + 1, div)].state == 1 then count = count + 1 end

    if cells[gol_t.get_index(x - 1, y, div)].state == 1     then count = count + 1 end
    if cells[gol_t.get_index(x + 1, y, div)].state == 1     then count = count + 1 end
    if cells[gol_t.get_index(x, y - 1, div)].state == 1     then count = count + 1 end
    if cells[gol_t.get_index(x, y + 1, div)].state == 1     then count = count + 1 end
    
    if cells[gol_t.get_index(x - 1, y - 1, div)].state == 1 then count = count + 1 end
    if cells[gol_t.get_index(x + 1, y - 1, div)].state == 1 then count = count + 1 end
    if cells[gol_t.get_index(x - 1, y + 1, div)].state == 1 then count = count + 1 end
    if cells[gol_t.get_index(x + 1, y + 1, div)].state == 1 then count = count + 1 end

    return count
    -- return count + tools.round(love.math.random(-1 ,1))
end



function gol_t.update(cells_source, div)
    local cells_destination = gol_t.init_cells(div, "empty")

    for x=1, div.x - 1 do
        for y=1, div.y - 1 do
            local neighbours = get_neighbour_count(cells_source, x, y, div)
            local idx = gol_t.get_index(x, y, div)
            local state = cells_source[idx].state


            if state == 1 and (neighbours == 2 or neighbours == 3) then
                cells_destination[idx].state = 1
            end

            if state == 0 and neighbours == 3 then
                cells_destination[idx].state = 1
            end

            if neighbours < 2 or neighbours > 3 then
                cells_destination[idx].state = 0
            end
        end
    end

    return cells_destination
end



return gol_t
