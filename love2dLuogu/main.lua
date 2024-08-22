
function love.load()
    love.graphics.setBackgroundColor(1,1,1);
    local info =love.filesystem.getInfo("./main.lua");
    print(info,type(info));
end;
function love.draw()
    love.graphics.setColor(1,0,0);
    love.graphics.points(0,0,20,20,10,10,0,0);
end;