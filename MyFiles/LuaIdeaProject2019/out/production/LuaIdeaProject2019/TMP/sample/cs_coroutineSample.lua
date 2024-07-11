
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local function test()
    local txtGo = GameObject.Find("Canvas/Text");
    local txt = txtGo:GetComponent("Text");
    txt.text = "hello lua";
    print(txt);
end;

do
    cs_coroutine.start(function()
        coroutine.yield(WaitForSeconds(5))
        local go = GameObject.Instantiate(loadGo("Sample/Cube"));
        go.name = "bigCube";
        go.transform:DOMove(Vector3(3, 2, 0), 2):OnComplete(function()
            print("move over");
        end)
        print("delay 5s ");
    end)
end ;

cs_coroutine.start(function()
    print("second start");
    coroutine.yield(WaitForSeconds(1));
    print("second wait 1s over");

    coroutine.yield(cs_coroutine.start(function()
        print("three start");
        coroutine.yield(WaitForSeconds(1));
        print("three wait 1s over")
    end));
    coroutine.yield(WaitForSeconds(5));
    print("four final over");
end)

cs_coroutine.start(function()
    print(" five start")
    coroutine.yield(WaitForSeconds(8));
    print("five wait 8s over")
    local go = GameObject.Find("bigCube");
    local t = go.transform:DOMove(Vector3(3, 0, 0), 5);

    coroutine.yield(t:WaitForCompletion());
    print("five wait fianl domove over");
end)