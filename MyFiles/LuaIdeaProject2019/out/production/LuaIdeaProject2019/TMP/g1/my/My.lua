
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen


local My =class("My");


function My:ctor(a1,a2,a3,a4)
    print("My Main lua About",Main.shakeTreeUi);
    print("My ctor args",a1,"a1 type is "..type(a1),a2,"a2 type is "..type(a2),a3,"a3 type is "..type(a3),a4,"a4 type is "..type(a4));
end

function My:awake()
    print("My awake");
    print("My inst",My.inst,self,My);
    print("My go",self.go.name);
    print("My trans",self.trans);
    print("My mono",self.mono);
end

function My:start()
    print("My start");
end




return My;