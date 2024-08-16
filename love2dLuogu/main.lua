
str =io.stdin:read("*line")

t={}
for item in str:gmatch("%S+") do
    t[#t+1]=tonumber(item);
end
local n,m =unpack(t);

local data={}
for i=1,n do
    local str =io.stdin:read("*line");
    local  t={}
    for item in str:gmatch("%S+") do
        t[#t+1]=tonumber(item);
    end
    data[#data+1]=t;
end;
local function printTable(t)
    print(table.concat(t," "));
end

local function printMatrix(t)
    for i, v in ipairs(t) do
        printTable(v);
    end
end

local function matrixT(data)
    local o_r=#data;
    local o_l=#data[1];
    local n_r =o_l;
    local n_l=o_r;
    local new_data={}
    for i=1,n_r do
        local new_data_item={}
        for j=1,n_l do
            table.insert(new_data_item,data[j][i]);
        end;
        new_data[#new_data+1]=new_data_item;
    end;
    return new_data;
end;

printMatrix(matrixT(data));