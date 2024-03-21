local tools = {}
tools.__index = tools

function tools.fif(condition, on_true, on_false) if condition then return on_true else return on_false end end

return tools
