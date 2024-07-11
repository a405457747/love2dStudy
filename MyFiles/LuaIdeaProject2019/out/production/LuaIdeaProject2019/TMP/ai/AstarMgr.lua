
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local t = require("ai.Grid");
local Grid = t.Grid;
local E_Node_Type = t.E_Node_Type;

local AstarMgr = class('AstarMgr')

local mapW;
local mapH;
local nodes;
---@type List
local openList;
---@type List
local closeList;

--[[function AstarMgr:ctor()
end]]

function AstarMgr:initMpaInfo(w, h)
    --二维数组
    nodes = List.Matrix(w, h);

    mapW = w;
    mapH = h;

    for i in range(0, w, 1) do
        for j in range(0, h, 1) do
            local type = math.random() < 0.2 and E_Node_Type.Stop or E_Node_Type.Walk;
            local node = Grid.new(i, j, type);
            nodes:get(i):set(j, node);
        end
    end
end

local function sortOpenList(nodeA, nodeB)
    return nodeA.f <= nodeB.f;
end

local function findNearlyNodeToOpenList(x, y, g, father, endP)
    if (x < 0 or x >= mapW or y < 0 or y >= mapH) then
        return ;
    end

    local node = nodes:get(x):get(y);
    if (node == nil or node.type == E_Node_Type.Stop or closeList:inList(node) or openList:inList(node)) then
        return ;
    end

    --计算f值
    node.father = father;
    --这里妙啊
    node.g = father.g + g;
    node.h = math.abs(endP.x - node.x) + math.abs(endP.y - node.y);
    node.f = node.g + node.h;

    openList:append(node);
end

local function int(num)
    return math.modf(num);
end

--startPos,endPos是vector2
function AstarMgr:findPath(startPos, endPos)
    --校验
    local b1 = startPos.x < 0 or startPos.x >= mapW or startPos.y < 0 or startPos.y >= mapH;
    local b2 = endPos.x < 0 or endPos.x >= mapW or endPos.y < 0 or endPos.y >= mapH;
    if (b1 or b2) then
        return nil;
    end

    local start = nodes:get(int(startPos.x)):get(int(startPos.y));
    local endP = nodes:get(int(endPos.x)):get(int(endPos.y));

    if (start.type == E_Node_Type.Stop or endP.type == E_Node_Type.Stop) then
        return nil;
    end

    --函数会多次调用
    closeList:clear();
    openList:clear();
    start.father = nil;--这里找父亲做准备
    start.f = 0;
    start.g = 0;
    start.h = 0;

    closeList:append(start);

    while (true) do
        findNearlyNodeToOpenList(start.x - 1, start.y - 1, 1.4, start, endP);
        findNearlyNodeToOpenList(start.x, start.y - 1, 1, start, endP);
        findNearlyNodeToOpenList(start.x + 1, start.y - 1, 1.4, start, endP);
        findNearlyNodeToOpenList(start.x - 1, start.y, 1, start, endP);
        findNearlyNodeToOpenList(start.x + 1, start.y, 1, start, endP);
        findNearlyNodeToOpenList(start.x - 1, start.y + 1, 1.4, start, endP);
        findNearlyNodeToOpenList(start.x, start.y + 1, 1, start, endP);
        findNearlyNodeToOpenList(start.x + 1, start.y + 1, 1.4, start, endP);

        --开启列表为空，说明是思路
        if (openList:len() == 0) then
            print("dead road");
            return nil;
        end

        --寻找消耗最小的点
        openList:sort(sortOpenList);

        local first = openList:pop(0);

        closeList:append(first);

        --找得这个点，又是新的起点，进行下一次寻路计算了
        start = first;

        --找完了
        if (start == endP) then
            local path = list {};
            path:append(endP);

            while (endP.father ~= nil) do

                path:append(endP.father);

                endP = endP.father;
            end

            path:reverse();

            return path;
        end
    end
end

return AstarMgr;