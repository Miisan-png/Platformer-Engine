



function love.conf(t)
    t.identity = "PlatformerEngine"    
    t.version = "11.5"                 
    t.window.title = "Platformer Engine" 
    t.window.icon = nil                

    
    t.window.width = 320
    t.window.height = 180

    
    t.window.minwidth = 960
    t.window.minheight = 540

    t.window.resizable = true          
    t.window.vsync = 1                 

    
    t.modules.graphics = true
    t.window.msaa = 0
end
