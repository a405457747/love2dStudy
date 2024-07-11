
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

local UIPanel =require("ui.UIPanel");
local FPanel =class("FPanel",UIPanel);

function FPanel:init(go,tier)
    FPanel.super.init(self,go,tier);
end

function FPanel:btnGet(name)

end

function FPanel:btnClick(btn, func)

end

function FPanel:txtGet(name)

end

function FPanel:txtText(txt, str)

end

function FPanel:imgGet(name)

end

function FPanel:show()

end

function FPanel:hide()

end

function FPanel:update()

end

function FPanel:free()

end


return FPanel;