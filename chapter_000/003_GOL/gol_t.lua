local gol_t = {}
gol_t.__index = gol_t

function get_index(x, y, div) return 1 + x + y * div.x end

function get_neighbour_count(cells_source, x, y, div)
    local count = 0

    if x > 0 and                           cells_source[get_index(x - 1, y, div)].state == 1     then count = count + 1 end
    if x < div.x - 1 and                   cells_source[get_index(x + 1, y, div)].state == 1     then count = count + 1 end
    if y > 0 and                           cells_source[get_index(x, y - 1, div)].state == 1     then count = count + 1 end
    if y < div.y - 1 and                   cells_source[get_index(x, y + 1, div)].state == 1     then count = count + 1 end
    if x > 0 and y > 0 and                 cells_source[get_index(x - 1, y - 1, div)].state == 1 then count = count + 1 end
    if x < div.x - 1 and y > 0 and         cells_source[get_index(x + 1, y - 1, div)].state == 1 then count = count + 1 end
    if x > 0 and y < div.y - 1 and         cells_source[get_index(x - 1, y + 1, div)].state == 1 then count = count + 1 end
    if x < div.x - 1 and y < div.y - 1 and cells_source[get_index(x + 1, y + 1, div)].state == 1 then count = count + 1 end

    return count
end

function gol_t.update(cells_source, cells_destination, div)
    for x=0, div.x do
        for y=0, div.y do
            local neighbours = get_neighbour_count(cells_source, x, y, div)

                if cells_source[get_index(x, y, div)].state == 1 then
        if neighbours < 2 or neighbours > 3 then
            cells_destination[get_index(x, y, div)].state = 0
        else
            cells_destination[get_index(x, y, div)].state = 1
        end
    end
end



return gol_t
