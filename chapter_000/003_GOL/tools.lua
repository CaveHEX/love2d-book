local tools = {}
tools.__index = tools

function tools.fif(condition, on_true, on_false) if condition then return on_true else return on_false end end

function tools.round(num) return num + (2^52 + 2^51) - (2^52 + 2^51) end

return tools
