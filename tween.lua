


local Tween = {}
Tween.tweens = {} 


local easing = {
    
    linear = function(t) return t end,
    
    easeInOutQuad = function(t)
        if t < 0.5 then
            return 2 * t * t
        else
            t = t * 2 - 1
            return -0.5 * (t * (t - 2) - 1)
        end
    end
}







function Tween.new(target, property, to, duration, easeFunc)
    local tween = {
        target = target,
        property = property,
        from = target[property],
        to = to,
        duration = duration,
        progress = 0,
        easeFunc = easing[easeFunc] or easing.linear
    }
    table.insert(Tween.tweens, tween)
    return tween
end


function Tween.update(dt)
    for i = #Tween.tweens, 1, -1 do
        local t = Tween.tweens[i]
        t.progress = t.progress + dt

        if t.progress >= t.duration then
            
            t.target[t.property] = t.to
            table.remove(Tween.tweens, i)
        else
            
            local time = t.progress / t.duration
            local easeValue = t.easeFunc(time)
            t.target[t.property] = t.from + (t.to - t.from) * easeValue
        end
    end
end

return Tween
