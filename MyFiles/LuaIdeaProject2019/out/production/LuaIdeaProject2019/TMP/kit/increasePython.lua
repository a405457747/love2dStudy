
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen



--唯一个没有返回的全局class
---@class List
List = class('List');

function List:ctor(t)
    self._t = { unpack(t) };
end;

function List:len()
    return #self._t;
end;
--[[List.__index = List
function List.__add(v1,v2)
    return v1:addSign(v2);
end]]

local getIndex = function(i, len)
    local fixedIndex = nil;
    if (i >= 0 and i < len) then
        fixedIndex = i;
    elseif (i < 0 and math.abs(i) <= len) then
        fixedIndex = len + i;
    else
        error("idx error!");
    end
    return fixedIndex;
end

function List:get(i)

    local idx = getIndex(i, self:len());
    return self._t[idx + 1];
end;

function List:_rightIndex(i)
    if (i >= 0 and i < self:len()) then
        return true;
    end

    if (i < 0 and math.abs(i) <= self:len()) then
        return true;
    end
    return false;
end

function List:set(i, v)
    local idx = getIndex(i, self:len());

    self._t[idx + 1] = v;
end;

function List:toStr()
    return string.toStr(self._t);
end

function List:append(v)
    self._t[#self._t + 1] = v;
end;

function List:index(obj)
    for _, item in enumerate(self) do
        if (item == obj) then
            return _;
        end
    end

    return -1;--python是error但是我不改了
end

function List:inList(item)
    return self:index(item) ~= (-1);
end;

function List:count(item)
    local res = 0;
    for i, it in enumerate(self) do
        if (item == it) then
            res = res + 1;
        end ;
    end ;
    return res;
end

--原地添加
function List:extend(list)
    for _, item in enumerate(list) do
        self:append(item);
    end
end

--创建新列表
function List:addSign(list2)
    self:extend(list2);
    return self:copy();
end

function List:insert(index, obj)
    local minIndex = 0;--这个不支持负数索引哦
    local maxIndex = self:len() - 1;
    if ((index < minIndex) or (index > (maxIndex + 1))) then
        return false;
    end

    table.insert(self._t, index + 1, obj);--这个返回索引的

    return true;
end

function List:pop(index)
    index = index or self:len() - 1;

    local idx = getIndex(index, self:len());

    local res = table.remove(self._t, idx + 1);
    return res;
end

function List:remove(obj)
    for _, item in enumerate(self) do
        if (item == obj) then
            table.remove(self._t, _ + 1);
            return true;
        end
    end ;
    return false;
end

--交换数据是吧
function List:swap(l, r)
    local tmp = self:get(l);
    self:set(l, self:get(r));
    self:set(r, tmp);
end

function List:reverse()
    local l = 0;
    local r = self:len() - 1;

    while l < r do
        local tmp = self:get(l);
        self:set(l, self:get(r));
        self:set(r, tmp);

        l = l + 1;
        r = r - 1;
    end
end

function List:shuffle()
    for i in range(self:len() - 1, -1, -1) do
        local ramIdx = math.random(i + 1) - 1;
        local t = self:get(ramIdx);
        self:set(ramIdx, self:get(i));
        self:set(i, t);--0的时候原地交换一次无所谓
    end
end

function List:randomItem()
    local idx = math.random(self:len()) - 1;
    return self:get(idx);
end

function List:sort(key, reverse)
    reverse = reverse or false;
    table.sort(self._t, key);--<=是升序

    if (reverse == true) then
        self:reverse();
    end
end

function List:clear()
    for i, v in ipairs(self._t) do
        self._t[i] = nil;
    end
end

function List:copy()
    return self:slice(0, self:len());
end

function List:filter(func)
    local res = List.new({});
    for i, v in enumerate(self) do
        if (func(v)) then
            res:append(v)
        end
    end
    return res;
end

function List:map(func)
    local res = List.new({});
    for i, v in enumerate(self) do
        res:append(func(v))
    end
    return res;
end

--类似python的切片
function List:slice(startPos, endPos, step)

    endPos = endPos or self:len();
    step = step or 1;

    if (endPos < 0) then
        endPos = self:len() + endPos;
    end

    local res = List.new({});

    while (startPos < endPos) do
        res:append(self:get(startPos))
        startPos = startPos + step;
    end

    return res;
end

function List:toTable(t)
    while #t > 0 do
        table.remove(t);
    end

    for i, item in enumerate(self) do
        t[#t + 1] = item;
    end
end

function List:all(func)
    for i, item in enumerate(self) do
        if (not func(item)) then
            return false;
        end
    end
    return true;
end

function List:any(func)
    for i, item in enumerate(self) do
        if (func(item)) then
            return true;
        end
    end
    return false;
end

function List:reduce(func)
    local res = self:get(0);

    for i in range(1, self:len()) do
        local listItem = self:get(i);
        res = func(res, listItem);
    end

    return res;
end

function List:max()
    return math.max(unpack(self._t));
end

function List:min()
    return math.min(unpack(self._t));
end

function List:mulSign(num)
    local res = List.new({});
    for i in range(0, num) do
        for j, item in enumerate(self) do
            res:append(item);
        end
    end
    return res;
end


function List:printStr()
    for i,item in enumerate(self) do
        print(string.format(" i=%s val=%s ",i,item));
    end
end

function List.Matrix(w, h, defaultValue)
    --w是行数，h是列数
    defaultValue = defaultValue or 0;

    local res = List.new({});
    for i in range(0, w) do
        local resItem = List.new({});

        for j in range(0, h) do
            resItem:append(defaultValue);
        end

        res:append(resItem);
    end
    return res;
end

function List.MatrixByTable(t)
    local w =#t;
    local h =#t[1];
    local res =List.Matrix(w,h,0);

    for i in range(0,w) do
        for j in range(0,h) do
            res:get(i):set(j,t[i+1][j+1]);
        end
    end

    return res;
end

function List.MatrixToStr(matrix)
    local res = "";
    for i, itemList in enumerate(matrix) do
        local itemStr = "";
        for j in enumerate(itemList) do
            itemStr = itemStr .. string.format("%s", matrix:get(i):get(j));
            if (j ~= (itemList:len() - 1)) then
                itemStr = itemStr .. ","
            end
        end

        res = res .. itemStr;

        if (i ~= (matrix:len() - 1)) then
            res = res .. " | ";
        end
    end
    res = "[" .. res .. "]";

    return res;
end

function List:dataTable()
    return self._t;
end

function List.NumberIncremental(list1)
    --判断是否是递增关系
    local list2 = list1:copy();

    list2:sort(function(a, b)
        return a <= b;
    end)

    return List.ContentEqual(list1, list2);
end

--弃用的方法
function List.RightType(list, typeStr)
    local firstTypeStr = type(list:get(0));

    if (typeStr ~= firstTypeStr) then
        return false;
    end

    for i in range(1, list:len()) do
        if (type(list:get(i)) ~= firstTypeStr) then
            return false;
        end
    end
    return true;
end

function List.ContentEqual(list1, list2)
    if (list1:len() ~= list2:len()) then
        return false
    else
        --必须要复制一下哦
        list1 = list1:copy();
        list2 = list2:copy();

        list1:sort(function(a, b)
            return a <= b;
        end)
        list2:sort(function(a, b)
            return a <= b;
        end)

        for i in range(0, list1:len()) do
            if (list1:get(i) ~= list2:get(i)) then
                return false;
            end
        end
        return true;
    end
end

list = function(t)
    return List.new(t);
end



---hash
function table.has_key(hash, key)
    return hash[key] ~= nil;
end

function table.clear(hash)
    while #hash > 0 do
        table.remove(hash);
    end
end

function table.fromkeys(keys, vals)
    local res = {};
    for i in range(0, keys:len()) do
        res[keys:get(i)] = vals:get(i);
    end ;
    return res;
end

function table.pop(hash, key)
    local res = hash[key];
    hash[key] = nil;
    return res;
end

function table.popitem(hash)
    local keys = {}
    for key, _ in pairs(hash) do
        table.insert(keys, key)
    end

    -- 随机选择要删除的键
    local index = math.random(#keys)
    local key = keys[index]

    -- 删除字典中的相应键值对
    local res = hash[key];
    hash[key] = nil
    return res;
end

function table.setdefault(hash, key, defaultVal)

    if (hash[key] ~= nil) then
        return hash[key];
    else
        hash[key] = defaultVal;
        return defaultVal;
    end ;
end

function table.copy(hash)
    local res = {}
    for i, v in pairs(hash) do
        res[i] = v;
    end
    return res;
end

function table.get(hash, key)
    return hash[key];
end

function table.items(hash)
    local res = List.new({});
    for i, v in pairs(hash) do
        local item = List.new({});
        item:append(i);
        item:append(v);

        res:append(item);
    end
    return res;
end

function table.len(hash)
    local res = 0;
    for i, v in pairs(hash) do
        res = res + 1;
    end
    return res
end

function table.keys(hash)
    local res = List.new({});
    for i, v in pairs(hash) do
        res:append(i);
    end
    return res;
end

function table.update(dict, updatedDict)

    local function updateDict(dict, updatedDict)
        for key, value in pairs(updatedDict) do
            dict[key] = value
        end
    end
    updateDict(dict, updatedDict)
end

function table.values(hash)
    local res = List.new({});
    for i, v in pairs(hash) do
        res:append(v);
    end
    return res;
end

function string.toList(str)
    local res = list {};

    local startIndex = 0;

    while (startIndex < #str) do
        res:append(string.get(str, startIndex));
        startIndex = startIndex + 1;
    end
    return res;
end

function string.get(str, idx)
    local i = getIndex(idx, #str);

    local luaIdx = i + 1;
    return str:sub(luaIdx, luaIdx)
end

function string.strip(str)
    return str:gsub("^%s*(.-)%s*$", "%1")
end

function string.join(symbol, list)
    return table.concat(list:dataTable(), symbol);
end

function string.split(str, delimiter, num)
    num = num or -1;--这里还没有实现呢

    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    str:gsub(pattern, function(token)
        table.insert(result, token)
    end)

    return list(result);
end

function string.startswith(str, prefix)
    return string.sub(str, 1, string.len(prefix)) == prefix
end

function string.endswith(str, suffix)
    return string.sub(str, -string.len(suffix)) == suffix
end

function string.replace(str)
    error("wait");
end

function string.inStr(str, item)
    return string.find(str, item) ~= nil
end

function string.slice(str, startPos, endPos, step)
    endPos = endPos or #str;
    step = step or 1;

    if (endPos < 0) then
        endPos = #str + endPos;
    end

    local t = {};--用了table也挺好!
    while (startPos < endPos) do
        t[#t + 1] = string.get(str, startPos);
        startPos = startPos + step;
    end
    return table.concat(t);
end

function enumerate(list)
    local index = -1
    local maxIndex = list:len() - 1;

    return function()
        index = index + 1
        if index <= maxIndex then
            return index, list:get(index);
        end
    end
end

--[[function int(num)
    return math.modf(num);
end]]

function len(listOrHash)
    if (listOrHash._t ~= nil) then
        return listOrHash:len();
    end ;

    return table.len(listOrHash);
end

--[[function str(obj)
    return tostring(obj);
end]]

function range(start, stop, step)

    if (stop == nil and step == nil) then --这个实现的不好，没法像python这种操作list(range(2,3));
        stop = start;--这里顺序不能调换的哦
        start = 0;
    end

    step = step or 1

    if (step > 0) then
        return function()
            if start < stop then
                local current = start
                start = start + step
                return current
            end
        end
    elseif (step < 0) then
        return function()
            if start > stop then
                local current = start
                start = start + step
                return current
            end
        end
    end
end

--[[function filter(func, listObj)
    error("wait")
end

function map(func, listObj)
    error("wait")
end

function all()
    error("wait");
end

function any()
    error("wait");
end]]

function sum(list)
    local res = 0;
    for _, item in enumerate(list) do
        res = res + item;
    end
    return res;
end

--[[function reduce()
    error("wait");
end]]

function max(...)
    if(select("#",...)==1)then
        return select(1,...):max();
    end

    return math.max(...);
end

function min(...)
    if(select("#",...)==1)then
        return select(1,...):min();
    end

    return math.min(...);
end

--[[function float(n)
    return tonumber(n);
end]]

--[[
function sorted(list, func)
    error("wait");
end
]]


---py
py={};


