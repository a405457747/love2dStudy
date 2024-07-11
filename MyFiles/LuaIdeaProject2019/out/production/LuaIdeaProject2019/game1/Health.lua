local Health=class("Health");

function Health:awake()
    self:initHp(2000);

end

function Health:initHp(maxHp)
    self.maxHp=maxHp;
    self.hp =self.maxHp;
    self.isDie=false;
end

function Health:damage(val)
    self.hp=self.hp-val;
    if(self.hp<=0)then
        self:die();
    end
end

function Health:die()
    print("die exe")
    self.isDie=true;
end

return Health;