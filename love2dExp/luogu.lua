function func3(reversed_str)

    -- 大小写反转
    local case_swapped_str = reversed_str:gsub('.', function(c)
        if c >= 'a' and c <= 'z' then
            return string.upper(c)
        elseif c >= 'A' and c <= 'Z' then
            return string.lower(c)
        else
            return c
        end
    end)
    return case_swapped_str;
end

function func2(str)
    return string.reverse(str);
end

local charTable ={}
for i=97,97+25 do
    charTable[#charTable+1] = string.char(i);
end

function shiftChar(char)
    local c =char;
    if c >= 'a' and c <= 'z' then
        c=true;
    else
        c=false;
    end

    char=char:lower();
    local idx =0;
    for index, value in ipairs(charTable) do
        if value==char then
           idx = index;
           break; 
        end
    end
    idx =idx -3;
    if(idx<1)then
        idx =idx +26;
    end
    for index, value in ipairs(charTable) do
        if index==idx then

            if not c then
                return value:upper();
            end

            return value;
        end
    end
end


str2=io.read("*l");


function strItem(str,func)
    local res =""
    for i=1,string.len(str) do
        local cha =func(string.sub(str,i,i));
        res =res .. cha;
    end
    return res;
end

local str3=""
for i=1, #str2 do
    local char =shiftChar(string.sub(str2,i,i))
    str3=str3 .. char;
end

--print("str3",str3);
--str2=str3;
--str2=str2:reverse();
--str2=func3(str2);
print(str3);