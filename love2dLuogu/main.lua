if arg[2] == "debug" then
    require("lldebugger").start()
end


function love.load()
    local t ={'a',"a",'b','c',"a","e",'a','k'}


    for i=#t,1,-1 do
        local item =t[i];
        if item =='a' then
            table.remove(t,i);
        end;
    end;
    print(unpack(t));
end;

