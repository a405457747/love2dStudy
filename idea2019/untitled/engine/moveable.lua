
Moveable =Node:extend();

function Moveable:init(X,Y,W,H)
    local args =(type(X)=='table') and X or {T={X or 0, Y or 0,W or 0,H or 0}}
    Node.init(self)
end