require("lib.functions");


function  love.load()
   bird ={}
   bird.img=love.graphics.newImage("bluebird-downflap.png");
   print(type(bird.img))

end
function love.draw()
   love.graphics.print("你好!love2d",102,103);

   love.graphics.draw(bird.img,bird.x,bird.y);
end

function  love.update(dt)
  
end

function love.mousepressed()
end


