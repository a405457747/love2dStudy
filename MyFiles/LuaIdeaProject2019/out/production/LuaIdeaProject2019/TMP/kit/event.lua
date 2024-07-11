
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen


local container = {};

function addEvent(event_type, callback)
    if container[event_type] == nil then
        local callbacks = list{};
        callbacks:append(callback);
        container[event_type] = callbacks;
    else
        local callbacks = container[event_type];
        callbacks:append(callback);
    end
end;

function delEvent(event_type, callback)
    if container[event_type] == nil then
        error("The event type is nil");
    else
        local callbacks = container[event_type];
        callbacks:remove(callback);
    end
end

function sendEvent(event_type, ...)
    local callbacks = container[event_type];

    for i, v in enumerate(callbacks) do
        v(...)
    end
end