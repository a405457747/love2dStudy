_RELEASE_MODE = true
_DEMO = false

function love.conf(t)
	t.console = not _RELEASE_MODE
	t.title = 'Balatro'
	t.window.width = 800
    t.window.height = 600
	t.window.minwidth = 800
	t.window.minheight = 600
end 
