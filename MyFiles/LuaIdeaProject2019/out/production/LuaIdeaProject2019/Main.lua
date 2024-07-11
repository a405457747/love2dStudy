
local Main={};

local function init()
    print("Main init",_VERSION)
    require("lib.functions");
    if(nil)then
        package.cpath = package.cpath .. ';C:/Users/skyAllen/.IntelliJIdea2019.3/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll';
        dbg = require('emmy_core')
        dbg.tcpConnect('localhost', 9966)
    end

    setmetatable(_G, {
        __index = function(t, _)
            error("read nil value " .. _, 2)
        end,
        __newindex = function(t, _)
            error("write nil value " .. _, 2)
        end
    });
    CS.UnityEngine.SceneManagement.SceneManager.LoadScene("g1");
end

init();
return Main;