local ue =CS.UnityEngine;
local game1 = class("game1");




function game1:awake()
    local a=1;
     a=a+1;
     a=a+1;
    print("i am game 1 start! "..a);
end

local function mouseClick()
    if(ue.Input.GetMouseButtonDown(0))then
        local  ray = ue.Camera.main:ScreenPointToRay(ue.Input.mousePosition);
        print("ray",ray,ray.origin,ray.direction);
     local hit = ue.Physics2D.Raycast(ray.origin,ue.Vector2( ray.direction.x,ray.direction.y));

        if (hit.collider ~= nil ) then
         local  hitObject = hit.collider.gameObject;
         print("点击到的GameObject：" ..hitObject.name);
        end
    end
end

function game1:update()
    --mouseClick();
end

--生成敌人
function game1:spawnEnemy()

end

return game1;