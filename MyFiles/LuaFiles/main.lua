function printLog(tag,fmt,...)
    local t={
        "[",
        string.upper(tostring(tag)),
        "]",
        string.format(tostring(fmt),...)
    }
    print(table.concat(t));
end

function printError(fmt,...)
    printLog("ERR",fmt,...);
    print(debug.traceback("",2));
end

function printInfo(fmt,...)
    if type(DEBUG)~="number" or DEBUG<2 then return end;
    printLog("INFO",fmt,...);
end

local function dump_value_(v)
    if(type(v)=="string")then
        v="\"".. v .."\""
    end
    return tostring(v);
end

function dump(value,description,nesting)
    if type(nesting)~="number" then nesting=3 end;
    local lookupTable ={}
    local result ={}

    local traceback=string.split(debug.traceback("",2),"\n");
    print("dump from:"..string.trim(traceback[3]))

    local function dump_(value,description,indent,nest,kelen)
        description=description or "<var>"
        local spc=""
        if(type(kelen)=="number")then
            spc =string.rep(" ",kelen-string.len(dump_value_(description)))
        end
        if type(value)~="table" then
            result[#result+1]=string.format("%s%s%s %s",indent,dump_value_(description),spc,dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result+1]=string.format("%s%s%s =*REF",indent,dump_value_(description),spc);
        else
            lookupTable[tostring(value)]=true;
            if nest >nesting then
                result[#result+1]=string.format("%s%s = *MAX NESTING*",indent,dump_value_(description))
            else
                result[#result+1]=string.format("%s%s ={",indent,dump_value_(description))
                local indent2=indent.."   ";
                local keys={}
                local keylen=0;
                local values={}
                for k,v in pairs(value)do
                    keys[#keys+1]=k;
                    local vk=dump_value_(k);
                    local vkl =string.len(vk);
                    if vkl >kelen then  kelen=vkl end;
                    values[k]=v;
                end
                table.sort(keys,function (a,b)
                    if type(a)=="number" and type(b)=="number"then
                        return a<b
                    else
                        return tostring(a)<tostring(b);
                    end
                end)
                for i,k in  ipairs(keys) do
                    dump_(values[k],k,indent2,nest+1,kelen);
                end
                result[#result+1]=string.format("%s}",indent);
            end
        end
    end
    dump_(value,description,"- ",1);

    for i,line in ipairs(result) do
        print(line)
    end
end

function printf(fmt,...)
    print(string.format(tostring(fmt),...))
end

function checknumber(value,base)
    return tonumber(value,base) or 0
end

function checkint(value)
    return math.round(checknumber((value)))
end

function checkbool(value)
    return (value ~=nil and value ~=false)
end

function checktable(value)
    if type(value)~="table" then value={}end;
    return value;
end

function isset(hashtable,key)
    local t=type(hashtable);
    return (t=="table" or t=="userdata") and hashtable[key]~=nil
end

local setmetatableindex_;
setmetatableindex_=function(t,index)
    if (type(t)=="userdata")then
        local peer =tolua.getpeer(t);
        if not peer then
            peer={}
            tolua.setpeer(t,peer);
        end
        setmetatableindex_(peer,index)
    else
        local mt =getmetatable(t);
        if not mt then mt ={} end
        if not mt.__index then
            mt.__index=index;
            setmetatable(t,mt);
        elseif mt.__index ~=index then
            setmetatableindex_(mt,index)
        end
    end
end
setmetatableindex=setmetatableindex_
function clone(object)
    local lookup_table={}
    local function _copy(object)
        if type(object)~="table" then
            return object
        elseif lookup_table[object]then
            return lookup_table[object]
        end
        local newObject ={}
        lookup_table[object]=newObject
        for key,value in pairs(object) do
            newObject[_copy(key)]=_copy(value)
        end
        return setmetatable(newObject,getmetatable(object))
    end
    return _copy(object);
end

function string.split(input,delimiter)
    input=tostring(input)
    delimiter=tostring(delimiter)
    if (delimiter=='')then return false end;
    local pos,arr=0,{}
    for st,sp in function() return string.find(input,delimiter,pos,true) end do
        table.insert(arr,string.sub(input,pos,st-1))
        pos=sp+1;
    end
    table.insert(arr,string.sub(input,pos))
end

function string.ltrim(input)
    return string.gsub(input,"^[ \t\n\r]+","")
end

function string.rtrim(input)
    return string.gsub(input,"[ \t\n\r]+$","")
end


function string.formatnumberthousands(num)
    local formatted=tostring(checknumber(num))
    local k
    while true do
        formatted,k =string.gsub(formatted,"^(-?%d+)(%d%d%d)","%1,%2");
        if k==0 then break end;
    end
    return formatted;
end
