
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

--[[
绝对实用主义。。。。。学习效率
lua 全局函数绝版了，系统级才能全局table
王信文的经验,js是不适用的，因为它的++i,i++,i+=1,i=i+1难顶。  我就用py掌控lua，lua的性能和不更新的学习成本，都是最适合的策划乱写的。
如果由于历史原因，封装的python返回值跟真python不一样，也不能重命名和修改返回值，只能另起炉灶，不完美就不完美，没有心智负担才是最好的。
命名尽量两个单词，我已经重构一版了，之后注意不要再搞了。
时序问题不管了，看看饥荒
api索引0用python的，索引1用js的
函数重命名不要省略括号一般
重构时候如果有反射调用，注意单和双引号。
重命名时候Projects和AllPlace的区别，务必小心第三方库的函数名不小心被替换掉。
严格控制全局变量，不要轻易重构，代价太大。代码烂无所谓，想想冒险岛
留意鼠标的滑动呢
经过我的测试全局，还有require的是能知道引用关系的，还是加了global的啥也不是。return {gcd=gcd} 这种引用关系也会隐藏，只找得到gcd，而且前面添加的全局变量也是会重命名改变的，只是模块里面没有改变，global更不用说
for和while在没有continute是等价的
注意false不等于nil
测试不要在旁边和内部测试，任何方法都不删除
--unity哪种组件形式，只不在外面带计算的东西都问题不大的。
动态语言别重命名，改名并注释说过时了用xx代替是最好的，还有绝对实用主义，这次看了一遍代码（git版本的标签就叫做maplestorylua1.0，下次千万别重命名了（甚至，全局查看都找不到的名字的函数，也不删除和重命名以及挪位置以及注释掉。）
--]]

--[[
ctrl+f12
--]]

---jit
do
    if jit then
        jit.off();
        jit.flush()
    end

    require("config.set")--注意时序哦

    --兼容性：5.1的函数优先
    unpack = _G.unpack or table.unpack
    loadstring = _G.loadstring or load;
    --注意//这个整除符号5.1是不支持的哦
    --运算符^5.1支持吗？math.pow这个被移除了吗?
end

---enum
do
    function enumKey(Enum,value)
        for key, enumValue in pairs(Enum) do
            if enumValue == value then
                return key
            end
        end
        return nil;
    end
end

---log
do
    local p = _G.print;
    local e = _G.error;
    local ass=_G.assert;

    local function pCommon(flag,args,enumVal)
        --if(enumVal==1)then return; end

        p(string.format("[%s]:",flag), table.unpack(args));
    end

    nobug = function(...)--这个方法为啥前面有空，有时候呢。
        local args = { ... };
        pCommon("NOBUG",args,1);
    end

    print = function(...)
        local args = { ... };
        pCommon("PRINT",args,2);
    end

    warn = function(...)
        local args = { ... };
        pCommon("WARN",args,3);
    end

    error = function(...)
        local args = { ... };
        pCommon("ERROR",args,4);
        e(...);
    end

    assert=function(condition,...)
        local args = { ... };

        if(not condition)then
            pCommon("ERROR",args,4);
        end

        ass(condition,...);
    end

    assertAll = function(...)
        local t = { ... };
        for i, v in ipairs(t) do
            assert(v);
        end
    end

    print("lua version is  ", _VERSION)
end

---public
do
    require("lib.functions");
    require("lib.hotReload");
    cs_coroutine = require("xlua.cs_coroutine");
    
    require("kit.const");
    require("kit.u3d")
    require("kit.event");



end

---global
do
    --tip common
    saveData = false;

    --tip py

    list = false;
    List = false;
    enumerate = false;
    --int = false;
    len = false;
    --str = false;--str(
    range = false;
    --[[    filter = false;
        map = false;
        all = false;
        any = false;]]
    sum = false;
    --reduce = false;
    max = false;
    min = false;
    --float = false;
    --sorted = false;
    py=false;

    dbg=false;
    if (APP.IS_DBG == true) then
        package.cpath = package.cpath .. ';C:/Users/skyAllen/.IntelliJIdea2019.3/config/plugins/intellij-emmylua/classes/debugger/emmy/windows/x64/?.dll';
        dbg = require('emmy_core')--这里定义个全局变量
        dbg.tcpConnect('localhost', 9966)
    end

    if (APP.IS_DBG == false) then
        setmetatable(_G, {
            __index = function(t, _)
                error("read nil value " .. _, 2)
            end,
            __newindex = function(t, _)
                error("write nil value " .. _, 2)
            end
        });
    end
end

---private
do
    require("kit.increaseCommon");
    require("kit.increasePython");
end