local gameMgr =require("g1.gameMgr");
--这个是UI的也是子系统
local numItem =class("numItem");

--[[
function numItem:ctor()
    print("numItem ctor");
end
]]

function numItem:awake()
    self.img =self.trans:GetComponent("Image");
    --print("numItem awake");
end

function numItem:onPointerClick(other)
    if(self.num==0)then
        return;
    end


    print("nuItem click"..self.go.name,"num is ",self.num,"x,y is ",self.x .. self.y,"l:",gameMgr.inst:getLToStr());
    gameMgr.inst:checkSwap(self);
end

function numItem:setXy(x,y)
    self.x =x;
    self.y =y;
end

function numItem:loadSpByNum(spList,num)
    self.num =num;

    if(self.num==0)then
        self.img.sprite=nil;
    else
        self.img.sprite =spList:get(self.num-1);
    end


   -- local spName =string.format("Sp%s")
end

return numItem;