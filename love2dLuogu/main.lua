-- main.lua
function love.load()
    -- 创建一个 Canvas，宽度和高度都是 200 像素
    myCanvas = love.graphics.newCanvas(200, 200)
    
    -- 在 Canvas 上绘制内容
    love.graphics.setCanvas(myCanvas)
    love.graphics.clear()
    love.graphics.setColor(1, 0, 0) -- 设置绘图颜色为红色
    love.graphics.rectangle("fill", 50, 50, 100, 100) -- 绘制一个红色矩形
    love.graphics.print("buhao");
    love.graphics.setColor(1, 1, 1) -- 恢复颜色为白色
    love.graphics.setCanvas() -- 恢复到默认 Canvas

    -- 设置 Canvas 在主屏幕上的位置
    canvasX, canvasY = 100, 100
end

function love.update(dt)
    -- 可以在这里添加更新逻辑，例如移动 Canvas
end

function love.draw()
    -- 在主屏幕上绘制 Canvas
    love.graphics.draw(myCanvas, canvasX, canvasY)
    love.graphics.print("nihao",0,0);
end
