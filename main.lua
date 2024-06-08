local player ={
    imgObj=nil,
    img="ss",
    x=200,
    y=200,
}

bgMusic=love.audio.newSource("case1/music.wav","stream");
bgMusic:setLooping(true);
sfx=love.audio.newSource("case1/laser.wav","static");


function love.load()
    --love.audio.play(bgMusic);

    player.imgObj=love.graphics.newImage("case1/player.png");
end;

function fire()
    love.audio.play(sfx);
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        player.x=player.x-100*dt;
    elseif love.keyboard.isDown("right") then
        player.x=player.x+100*dt;
    end
end;

function love.keypressed(key)
    if key=="a" then
        
        love.audio.play(sfx);
    end
    
end

function love.draw()
    love.graphics.draw(player.imgObj,player.x,player.y);
end;