
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

---@class ShakeTree
local ShakeTree = class('ShakeTree');


local money ;
local perClickAddMoney ;
local fishAnimalTotalCost ;
local floatTextAnimalTotalCost ;


function ShakeTree.Init()
    print("shakeTree Init");
    ShakeTree.CLICK_EVENT = "CLICK_EVENT";

    money = Shake_Tree_Config.money ;

    ShakeTree.InitConfig();
end

function ShakeTree.InitConfig()
    perClickAddMoney =Shake_Tree_Config.perClickAddMoney;
    fishAnimalTotalCost =Shake_Tree_Config.fishAnimalTotalCost;
    floatTextAnimalTotalCost = Shake_Tree_Config.floatTextAnimalTotalCost;
end


function ShakeTree.Money()
    return money;
end

function ShakeTree.ClickStart()
    --print("ShakeTree clickstart")
    local perClickAddMoney =Shake_Tree_Config.perClickAddMoney2();

    money = money + perClickAddMoney;
    --print("before money is",money);

    sendEvent(ShakeTree.CLICK_EVENT, money, fishAnimalTotalCost, perClickAddMoney, floatTextAnimalTotalCost);
end

return ShakeTree;