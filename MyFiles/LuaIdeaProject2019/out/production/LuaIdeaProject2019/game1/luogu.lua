
local function initMatrix(row,col)
    local res={};
    for i=1,row do
        local t ={};
        for j=1,col do
            t[#t+1]=0;
        end
        res[#res+1]=t;
    end
    return res,row,col;
end

local function subTable(t,l,r)
    local res ={};
    for i=l,r do
        res[#res+1]=t[i];
    end
    return res;
end

local function changeType(item,enum)
    enum =enum or 1;
    if(enum==1) then
        return tonumber(item);
    elseif (enum==2) then
        return tostring(item);
    else
        return item;
    end
end

local function getArgs(enum,isOne)
    isOne =isOne or 1;
    enum =enum or 1;
    local iptStr= io.stdin:read("*line")
    local args={};
    for item in iptStr:gmatch("%S+") do
        args[#args+1]=changeType(item,enum);
    end
    if(isOne==1) then
        return args[1];
    else
        return args;
    end
end

local function printTable(t)
    print(table.concat(t," "));
end

local function printMatrix(t)
    for i, v in ipairs(t) do
        printTable(v);
    end
end

local function initList(count,initNum)
    local t={};
    initNum =initNum or 0;
    for i=1,count do
        t[#t+1]=initNum;
    end
    return t;
end

local function debug()
    package.cpath = package.cpath .. ';C:/Users/skyAllen/.IntelliJIdea2019.3/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll';
    dbg = require('emmy_core')
    dbg.tcpConnect('localhost', 9966)
end
local function int(n)
   return math.floor(n);
end

local function gcd(a,b)
    if(b==0) then
        return a;
    end
    return gcd(b,a%b)

end

local function sum(t)
    local res =0;
    for i, v in ipairs(t) do
       res =res+v;
    end
    return res;
end

local function inRange(l,r,val)
    if(val>=l and val <=r)then
        return true;
    else
        return false;
    end
end

--debug();
local function main()
    local t =getArgs(1,0);

    local states =initList(t[1],false);

    for i, v in ipairs(states) do
        if(v%2==0)then
            states[i]=true;
        end
        if(v%v==0)then
            states[i]=not states[i];
        end
    end

    for i, v in ipairs(states) do
        print(i,v);
    end
end

main();






