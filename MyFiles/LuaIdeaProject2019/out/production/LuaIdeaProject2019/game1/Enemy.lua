local Enemy=class("Enemy");
local m =require("lib.M");

function Enemy:awake()
    self.btn =self.trans:GetComponent("Button");
    self.btn.onClick:AddListener(function()
        self:fightStart();
    end);

    self.health=CS.LuaMonoHelper.GetLuaComp(self.go,require("game1.Health"));
    print("enemy health",self.health);

    self.hpText=self.trans:Find("hpText"):GetComponent("Text");

    self:refreshHp();

    self.hitAS=self.trans:GetComponent("AudioSource");
    print("hitAS",self.hitAS);
end

function Enemy:refreshHp()
    self.hpText.text=self.health.hp;
end

--战斗开始
function Enemy:fightStart()
    if(self.health.isDie==true)then
        return;
    end
    print("fightStart");

    local damage = self['damage'..math.random(1,4)](self);
    self.health:damage(damage);
    self.hitAS:Play();
    self:refreshHp();
end

function Enemy:damage1()
      local a =math.random(0,10);
    local b =math.random(5,10);
    local c =math.random(5,10);

    local is_tri =m.is_tri(a,b,c);
    local damage1=0;
    if(is_tri)then
        damage1= math.floor( m.tri_area(a,b,c));
    end
    print("damage1 is ",damage1);
    return damage1;
end

function Enemy:damage2()
    local data =m.snakeMatrix(4,4,2);
    local randomT =m.randomItem(data);
    local damage2=m.listSum(randomT);
    print("damage2 is",damage2);
    return damage2;
end

function Enemy:damage3()
    local t ={};
    local n =6;
    for i=1,n do
        t[i]=m.doubleArithmeticSeqItem(2,3,i);
    end
    m.printList(t);
    local damage3=m.listSum(t);
    print("damage3",damage3);
    return damage3;
end

--todo 创新是好，但是试错成本高，还是得招人
function Enemy:damage4()
    local damage4 =1+1;
    print("damage4",damage4);
    return damage4;
end

--todo 弹珠的弹跳？
function Enemy:damage5()
    error("wait ");
end

return Enemy;