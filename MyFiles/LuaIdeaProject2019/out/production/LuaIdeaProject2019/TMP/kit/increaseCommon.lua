
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

function string.serialize(obj)
    local lua = ""
    local t = type(obj)
    if t == "number" then
        lua = lua .. obj
    elseif t == "boolean" then
        lua = lua .. tostring(obj)
    elseif t == "string" then
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then
        lua = lua .. "{\n"
        for k, v in pairs(obj) do
            lua = lua .. "[" .. string.serialize(k) .. "]=" .. string.serialize(v) .. ",\n"
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                lua = lua .. "[" .. string.serialize(k) .. "]=" .. string.serialize(v) .. ",\n"
            end
        end
        lua = lua .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end
    return lua
end

function string.unserialize(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = loadstring(lua);
    if func == nil then
        return nil
    end
    return func()
end

function string.get_pure_number(str)
    local temp = string.gsub(str, "%D+", "");
    if temp == "" then
        return 0;
    else
        return tonumber(temp);
    end
end

function string.toStr(t)--这个方法有局限性，针对cs的数组就会有问题。
    local strTable = {};
    if (t[1]) then
        strTable[#strTable + 1] = "[";
        for i, v in ipairs(t) do
            local item = v;
            if (i ~= #t) then
                item = tostring( item) .. ","
            end
            strTable[#strTable + 1] = item;
        end
        strTable[#strTable + 1] = "]";
        return table.concat(strTable);
    else
        strTable[#strTable + 1] = "{";
        local tCounter =0;
        for i, v in pairs(t) do
            local item = string.format("%s=%s", i, v);

            if(tCounter~=#t) then
                item =item ..","
            end
            strTable[#strTable + 1] = item;

            tCounter=tCounter+1;
        end
        strTable[#strTable + 1] = "}";
        return table.concat(strTable);
    end
end