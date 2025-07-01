


local LevelLoader = {}



local SOLID_R, SOLID_G, SOLID_B = 0, 1, 0



function LevelLoader.load(imagePath)
    local imageData = love.image.newImageData(imagePath)
    local width = imageData:getWidth()
    local height = imageData:getHeight()

    local platforms = {}
    local processed = {} 

    
    for y = 0, height - 1 do
        processed[y] = {}
        for x = 0, width - 1 do
            processed[y][x] = false
        end
    end

    
    for y = 0, height - 1 do
        for x = 0, width - 1 do
            
            if not processed[y][x] and LevelLoader.isPixelSolid(imageData, x, y) then
                
                

                
                local rectWidth = 1
                while x + rectWidth < width and not processed[y][x + rectWidth] and LevelLoader.isPixelSolid(imageData, x + rectWidth, y) do
                    rectWidth = rectWidth + 1
                end

                
                local rectHeight = 1
                local canExpandDown = true
                while y + rectHeight < height and canExpandDown do
                    
                    for i = 0, rectWidth - 1 do
                        if processed[y + rectHeight][x + i] or not LevelLoader.isPixelSolid(imageData, x + i, y + rectHeight) then
                            canExpandDown = false
                            break
                        end
                    end

                    if canExpandDown then
                        rectHeight = rectHeight + 1
                    end
                end

                
                table.insert(platforms, {
                    x = x,
                    y = y,
                    width = rectWidth,
                    height = rectHeight
                })

                
                for j = 0, rectHeight - 1 do
                    for i = 0, rectWidth - 1 do
                        processed[y + j][x + i] = true
                    end
                end
            end
        end
    end

    print("Level loaded! Generated " .. #platforms .. " collision rectangles.")
    return platforms
end


function LevelLoader.isPixelSolid(imageData, x, y)
    local r, g, b, a = imageData:getPixel(x, y)
    
    
    return r == SOLID_R and g == SOLID_G and b == SOLID_B
end

return LevelLoader

