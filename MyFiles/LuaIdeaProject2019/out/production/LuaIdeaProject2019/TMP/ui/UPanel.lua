
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local UIPanel =require("ui.UIPanel");
local UPanel =class("UPanel",UIPanel);

function UPanel:init(go,tier)
    UPanel.super.init(self,go,tier);
end

function UPanel:btnGet(name)
    local btn = findComp(self.go.transform, name, "Button");
    return btn;
end

function UPanel:btnClick(btn, func)
    btn.onClick:AddListener(function()
        func();
    end);
end

function UPanel:txtGet(name)
    local txt = findComp(self.go.transform, name, "Text");
    return txt;
end

function UPanel:txtText(txt, str)
   txt.text=str;
end

function UPanel:imgGet(name)

end

function UPanel:show()
    self.go:SetActive(true)
end

function UPanel:hide()
    self.go:SetActive(false)
end

function UPanel:update()

end

function UPanel:free()

end


return UPanel;