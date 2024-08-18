
imgs=nil
function love.load()
      imgs=love.graphics.newImage("jump_3.png");
      --50,60是左上切割点坐标，150,100是切割宽高
      qua1=love.graphics.newQuad(50,60,150,100,imgs:getWidth(),imgs:getHeight());
end;
function love.draw()
      love.graphics.draw(imgs,0,0);
      --200,300是坐标，qua1的quad对象
      love.graphics.draw(imgs,qua1,200,300);
end;

function love.keypressed(key)
      if key=='a' then
            love.event.quit("restart");
            print("a");
      end;
end