
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

--唯一一个返回的全局table
Main ={}--不说了坚持用list。想想消消乐矩阵学，但是除了list,hash,str其他的不要封装了，不然就是走火入魔，fgui快速上手暂时还是先算了。--2D项目用lua稳妥点
require("kit.strict");

local sysList;
local uiList;
local rootGo;

local function addSys(name)
    local ins = require("sys." .. name)
    sysList:append(ins);
    ins.Init()
end

local function addUi( path, tier)

    tier = tier or UI_TIER.Default; --"Default";
    local tierKey = enumKey(UI_TIER, tier);

    local function getLast(pathStr)
        local splitResult = List.new({});
        for str in string.gmatch(pathStr, "([^/]+)") do
            splitResult:append(str);
        end
        return splitResult:get(splitResult:len() - 1);
    end

    local lastName = getLast(path);

    local tierTransform = GameObject.Find("GameRoot/Canvas/" .. tierKey).transform;
    local go = Main.GenerateGo(loadGo(path), tierTransform, lastName)

    local ui_class = require("ui." .. lastName);
    local ui_ins = ui_class.new();
    ui_ins:init(go, tier);

    uiList:append(ui_ins);
    return ui_ins;
end

function Main.OnBeginDrag(eventData, go)
    print("OnBeginDrag", go);
end;

function Main.OnDrag(eventData, go)
    print("OnDrag", go);
end;

function Main.OnEndDrag(eventData, go)
    print("OnEndDrag", go);
end;

function Main.OnMouseDown(go)
    print("OnMouseDown", go);
end;

function Main.OnMouseDrag(go)
    print("OnMouseDrag", go);
end;

function Main.OnMouseUp(go)
    print("OnMouseUp", go);
end;

function Main._SysListInitConfig()

    hotfix("config.set");--首先只有sys才需要重载配置，另外呢如果sys引用别的class这种变量，是不需要放在initConfig里面的，而就算放了也没关系。

    for i, item in enumerate(sysList) do
        if item.InitConfig then
            item.InitConfig();
        end
    end
end

function Main.Update()

    for i, item in enumerate(sysList) do
        if (item.Update) then
            item.Update();
        end
    end

    for i, item in enumerate(uiList) do
        if (item.update) then
            item.update(item);--这个是小写注意哦
        end
    end

    if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.R) then
        Main._SysListInitConfig();
        print("重载config.set")
    end

end

function Main.GenerateGo(loadGo, parentTrans, name)
    local go = GameObject.Instantiate(loadGo);
    local canvasTrans = parentTrans;
    go.transform:SetParent(canvasTrans, false);

    if (name ~= nil) then
        go.name = name;
    end

    return go;
end

function Main.RootGo()
    return rootGo;
end

function Main.HideDefaultCanvas()
    u3d.hideGo(rootGo.transform:Find("Canvas").gameObject);
end

local function testRun()
    require("test.algoTest");
    require("test.increasePythonTest");
end

local function sampleRun()
    --require("sample.cs_coroutineSample");
    --require("sample.temp");
    --require("sample.WoodenFish");
    require("g1.g1");
end

local function init()
    testRun();

    uiList = list {};
    sysList = list {};
    rootGo = GameObject.Find("GameRoot");
    Main.AddSys=addSys;
    Main.AddUi=addUi;

    addSys( "SaveManager");
    addSys( "AudioMgr");

    sampleRun();
end;

init();

return Main;