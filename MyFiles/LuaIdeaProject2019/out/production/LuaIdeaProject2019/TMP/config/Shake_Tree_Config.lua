
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local Shake_Tree_Config = {
    money = 100,
    perClickAddMoney = 100 * 5,
    fishAnimalTotalCost = 0.2 * 1,
    floatTextAnimalTotalCost = 0.5 * 1,
    kk = function(n)
        if (math.random() < 0.3) then
            --print("x");
            return n * 10 * 10;
        else
            --print("y");
            return n * 5 * 10;
        end
    end,
    perClickAddMoney2 = function()
        local n = 2;
        return Shake_Tree_Config.kk(n + 3);
    end
}

return Shake_Tree_Config;