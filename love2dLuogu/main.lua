str =io.stdin:read("*line");

local t ={}
for item in str:gmatch("%S+") do
    t[#t+1]=tonumber(item);
end

local function  isPrime(n)
    if n<=1 then
        return false;
    end

    for i=2,math.sqrt(n) do
    
        if(n%i==0)then
            return false;
        end
    end

    return true;

end

function reverse_number(n)
    local reversed=0;
    while n>0 do
    
        local digit =n%10;
        reversed =reversed*10+digit;
        n=math.floor(n/10);
    end
    return reversed;
end

local res ={}
for i=t[1],t[2] do
    if(isPrime(i) and isPrime( reverse_number(i))) then
        res[#res+1]=i;
    end
end
print(table.concat(res," "))
