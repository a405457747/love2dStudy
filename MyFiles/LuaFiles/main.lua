function love.load()
    love.window.setTitle("你好");
    love.window.setMode(300,300);
    target={
        x=300,
        y=300,
        radius=50
    }
    score=0
    timer=0
    gameState=1

    gameFont=love.graphics.newFont(40)

    sprites={}
    sprites.sky=love.graphics.newImage("sprites/sky.png")
    sprites.target=love.graphics.newImage("sprites/target.png")
    sprites.crosshairs=love.graphics.newImage("sprites/crosshairs.png")

    --love.mouse.setVisible(true);
end

function love.update(dt)
    if timer >0 then
        timer=timer-dt
    end

    if timer <0 then
        timer =0
        gameState=1
    end
end

function love.draw()
    love.graphics.print()
    love.graphics.draw(sprites.sky,0,0);
    love.graphics.setColor(1,1,1);
    love.graphics.setFont(gameFont);
    love.graphics.print("Score:".. score,5,5);
    love.graphics.print("Time:"..math.ceil(timer),300,5);

    love.graphics.draw(sprites.crosshairs,love.mouse.getX()-20,love.mouse.getY()-20);

end