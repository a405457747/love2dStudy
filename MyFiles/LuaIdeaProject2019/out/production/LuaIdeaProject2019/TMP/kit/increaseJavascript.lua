
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

--- arr
function table.push(t, val)
    table.insert(t, val);
end

function table.pop(t)
    local res = table.remove(t);
    return res;
end

function table.shift(t)
    local res = table.remove(t, 1);
    return res;
end

function table.forEach(t, func)
    for i = 1, #t do
        func(t[i], i, t);
    end
end

function table.map(t, func)
    local res = {};
    for i = 1, #t do
        res[i] = func(t[i]);
    end
    return res;
end

function table.filter(t, func)
    local res = {};
    for i = 1, #t do
        local item = t[i];
        if (func(item)) then
            table.insert(res, item);
        end
    end
    return res;
end

function table.indexOf(t, val)
    for i = 1, #t do
        if (t[i] == val) then
            return i;
        end
    end
    return 0;
end

--- hash

function table.entries(hash)

    local res = {}
    for i, v in pairs(hash) do
        local temp = {};
        table.insert(temp, i);
        table.insert(temp, v);
        table.insert(res, temp);
    end
    return res;

end

function table.keys(hash)
    local res = {}
    for i, v in pairs(hash) do
        res[#res + 1] = i;
    end
    return res;
end

function table.values(hash)

    local res = {}
    for i, v in pairs(hash) do
        res[#res + 1] = v;
    end
    return res;
end

function table.hasOwnProperty(hash, key)
    for i, v in pairs(hash) do
        if (i == key) then
            return true;
        end
    end
    return false;
end