local gameMgr = class("gameMgr");

local allSp;
local numItemList;

--[[function gameMgr:ctor()
    print("gameMgr ctor")
end]]
local width;
local height;

local datas;
---@type List
local numItems;
local l;

function gameMgr:start()
    print("gameMgr start")
    width = 3;
    height = 3;
    datas = List.Matrix(3, 3, 0);

    local numItemWrap = GameObject.Find("Canvas/Panel/numItemWrap");
    local luaMonoList = getComps(numItemWrap.transform, typeof(CS.LuaMono));
    print("luaMonoList len is ", luaMonoList:len());
    numItems = luaMonoList:map(function(item)
        return item.TableIns
    end);
    --numItems:printStr();
    allSp = loadAll("Sprites/g1/1", typeof(UnityEngine.Sprite));

     l = list {};
    for i in range(0, width * height) do
        l:append(i);
    end

    self:gameStart();
end

function gameMgr:getLToStr()
    return l:toStr();
end

function gameMgr:gameStart()
    l:shuffle();

    self:initPattern(l);
end

function gameMgr:initPattern(l)
    for i in range(0, l:len()) do
        local numItem = numItems:get(i);
        numItem:loadSpByNum(allSp, l:get(i));
    end

    print("pattern is", l:toStr());

    self:setDatas(l, numItems)
end

function gameMgr:setDatas(l, numItems)
    local lIdx = 0;
    for i in range(0, width) do
        for j in range(0, height) do
            local numItem = numItems:get(lIdx);
            numItem:setXy(i, j);
            datas:get(i):set(j, numItem)
            lIdx = lIdx + 1;
            print("datas i j numItem num is  ", numItem.num);
        end
    end
    --print("datas is ",List.MatrixToStr(datas));
end

function gameMgr:rightOne(x, y)
    if (x < 0 or x >= width or y < 0 or y >= height) then
        return false;
    end
    return true;
end

function gameMgr:checkOne(x, y)
    local right = self:rightOne(x, y);
    --nobug("checkOne datas item 's num",datas:get(x):get(y).num);
    if (right) then
        return datas:get(x):get(y).num == 0;
    else
        return false;
    end
end

function gameMgr:swapNumItem(zeroItem,numItem)
    local zeroItemIdx =numItems:index(zeroItem);
    local numItemIdx =numItems:index(numItem);

    print("zeroItemidx is "..zeroItemIdx,"numItemIdx is "..numItemIdx);

    --交互l，因为l是最上层一级，和numItems是对应关系，而且l改变numItems自然也改变了。
    l:swap(zeroItemIdx,numItemIdx);

    self:initPattern(l);

    if(self:isGameWin(l))then
        print("Game win");
    end
end

function gameMgr:isGameWin(l)
    --l=l or list{1,2,3,4,5,6,7,8,0};
    for i in range(1,l:len()) do
        if(l:get(i-1)~=i) then
            return false;
        end
    end
    return l:get(-1)==0;
end

function gameMgr:checkSwap(numItem)
    local x = numItem.x;
    local y = numItem.y;

    local dirs = list {};
    dirs:append(list { x, y + 1 });
    dirs:append(list { x, y - 1 });
    dirs:append(list { x + 1, y });
    dirs:append(list { x - 1, y });

    local canSwap=false;
    local zeroItem =nil;
    for i, item in enumerate( dirs) do
        local _x =item:get(0);
        local _y =item:get(1);
        if self:checkOne(_x,_y) then
            canSwap =true;
            zeroItem =datas:get(_x):get(_y);
            break;
        end
    end

    if(canSwap)then
        print("canSwap")
        self:swapNumItem(zeroItem,numItem)
    else
        print("Can't Swap");
    end
end


return gameMgr;