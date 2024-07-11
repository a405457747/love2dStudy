
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local ShakeTree = require("sys.ShakeTree")
---@class ShakeTreeUi
local ShakeTreeUi = class('ShakeTreeUi',require("ui.UPanel"));



function ShakeTreeUi:init(go,tier)
    ShakeTreeUi.super.init(self,go,tier);


    self.moneyText =self:txtGet("moneyText");
    self.mainBtn =self:btnGet("mainButton");
    --print("ui go ",panelGo);

    self:btnClick(self.mainBtn,function ()
        ShakeTreeUi.MainBtnClick()
    end)

    self:UpdateUi(ShakeTree.Money());

    addEvent(ShakeTree.CLICK_EVENT, function(money, fishAnimalTotalCost, perClickAddMoney, floatTextAnimalTotalCost)

        self:UpdateUi(money)
        self:WoodenFishAnimal(fishAnimalTotalCost)
        self:CreateFloatText(perClickAddMoney, floatTextAnimalTotalCost);
        print("shakeUi accept event")
    end)
end

function ShakeTreeUi:UpdateUi(money)
    self:txtText(self.moneyText,"功德数：" .. money)
end

function ShakeTreeUi:WoodenFishAnimal(animalTotalCost)
    local transform = self.mainBtn.transform;
    local perCost = animalTotalCost / 2;
    transform:DOScale(1.2, perCost):OnComplete(function()
        transform:DOScale(1, perCost);
    end)
end

function ShakeTreeUi:CreateFloatText(num, floatTextAnimalTotalCost)
    local go = Main.GenerateGo(loadGo("UI/WoodenFish/floatText"),self.go.transform);


    getComp(go,"Text").text = "功德+" .. num;

    go.transform:DOAnchorPosY(100, floatTextAnimalTotalCost):SetRelative(true):OnComplete(function()
        GameObject.Destroy(go);
    end)
end

function ShakeTreeUi.MainBtnClick()
    ShakeTree.ClickStart();
end


return ShakeTreeUi;