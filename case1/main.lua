
function  love.load()
    love.window.setTitle("你好");
    w=love.graphics.newImage("red.png");
end

function love.draw()
    love.graphics.draw(w,200,200);
end;

function love.keypressed(key,scancode,isrepeat)
    print(key);
end;