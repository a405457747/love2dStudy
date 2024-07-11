
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local E_Node_Type = {
    Null = 0,
    Stop = 1,
    Walk = 2
}

local Grid = class("Grid");

function Grid:ctor(x, y, type)
    self.x = x;
    self.y = y;
    self.type = type;
end

return {
    Grid = Grid,
    E_Node_Type = E_Node_Type,
}