
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

UnityEngine = CS.UnityEngine;
Canvas = CS.UnityEngine.Canvas
GameObject = CS.UnityEngine.GameObject;
Transform = CS.UnityEngine.Transform;
RectTransform = CS.UnityEngine.RectTransform;
Vector3 = CS.UnityEngine.Vector3;
Vector2 = CS.UnityEngine.Vector2;
CanvasGroup = CS.UnityEngine.CanvasGroup;
Time = CS.UnityEngine.Time;
Random = CS.UnityEngine.Random;
Quaternion = CS.UnityEngine.Quaternion;
Physics2D = CS.UnityEngine.Physics2D;
AudioSource = CS.UnityEngine.AudioSource;
Resources = CS.UnityEngine.Resources;
Color = CS.UnityEngine.Color;
SpriteRenderer = CS.UnityEngine.SpriteRenderer;
UI = CS.UnityEngine.UI;
Button = CS.UnityEngine.UI.Button;
Text = CS.UnityEngine.UI.Text;
InputField = CS.UnityEngine.UI.InputField;
Input = CS.UnityEngine.Input;
Image = CS.UnityEngine.UI.Image;
Text = CS.UnityEngine.UI.Text;
Slider = CS.UnityEngine.UI.Slider;
WaitForSeconds = CS.UnityEngine.WaitForSeconds;
WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame;
WaitUntil = CS.UnityEngine.WaitUntil;
Application = CS.UnityEngine.Application;
SceneManager = CS.UnityEngine.SceneManagement.SceneManager;

--dotween
Tweening = CS.DG.Tweening;
RotateMode = Tweening.RotateMode;
Ease = Tweening.Ease;
DOTween = CS.DG.Tweening.DOTween

--expand
loadGo = function(path)
    return Resources.Load(path,typeof(GameObject));
end;

loadAll=function(path,loadType)
    loadType =loadType or UnityEngine.GameObject;
    local all=Resources.LoadAll(path,typeof(loadType));

    local l =list{};
    for i in range(0,all.Length) do
        l:append(all[i]);
    end


    return l;
end

loadSp=function(path)
    return Resources.Load(path,typeof( UnityEngine.Sprite));
end

loadAudio = function(path)
    error("wait audio");
end

loadScene = function(name)
    SceneManager.LoadScene(name);
end

showGo = function(go)
    go:SetActive(true);
end

hideGo = function(go)
    go:SetActive(false);
end


transChilds = function(transParent)--这个不包括自己的呢，不要多用哦
    local transList = list {};
    for i in range(0, transParent.childCount) do
        transList:append(transParent:GetChild(i));
    end
    return transList,transList:dataTable();
end

getComps=function(transParent, compType,containSelf)
    containSelf=containSelf or true;

    local childs = transChilds(transParent);

    local res =list{transParent:GetComponent(typeof(compType))};
    for i,item in enumerate(childs)do
        res:append(item:GetComponent(typeof(compType)))
    end

    return res;
end

--递归这样定义才对哦
local function findTransRecursion(transParent, targetName)
    local transList = transChilds(transParent)
    for i, item in enumerate(transList) do
        if item.name == targetName then
            return item;
        else
            local result = findTransRecursion(item, targetName);
            if (result ~= nil) then
                return result;
            end
        end
    end
    return nil;
end
findComp = function(transParent, targetName, compoentName)
    --这个方法2D sprite也会用到的
    compoentName = compoentName or "transform";

    local resTrans = nil
    if (transParent.name == targetName) then
        resTrans = transParent;
    else
        resTrans = findTransRecursion(transParent, targetName);
    end

    return getComp(resTrans,compoentName);-- resTrans:GetComponent(compoentName);
end

getComp = function(go, comName)--这个应该只支持字符串
    return go:GetComponent(comName);
end

newComp = function()
    error("wait newComp")--为了和UGUI不一样做区分呢
end

--全局函数克制下
u3d ={
    getComp=getComp,
    hideGo=hideGo,
};


--FGUI
--require("kit.fgui");