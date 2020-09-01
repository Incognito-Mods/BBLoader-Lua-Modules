local GfxPlus = {}

--This is the start of the constant definitions
do 
  GfxPlus.width = Gui.getScreenSize().x
  GfxPlus.height = Gui.getScreenSize().y
  GfxPlus.defaultColor = {r = 0, g = 0, b = 0, a = 255}
  
end
--This is the end of the constant definitions


--This is the start of the color related commands 
do
  --This is the beginning of the Color class
  GfxPlus.Color = {r = 0, g = 0, b = 0, a = 255}

  function GfxPlus.Color:new(a, b, c, d)
    --Set up the new object
    local newColorObj = {}
    setmetatable(newColorObj, self)
    self.__index = self
    
    --Set color values to the defaultColor values
    newColorObj.r = GfxPlus.defaultColor.r
    newColorObj.g = GfxPlus.defaultColor.g
    newColorObj.b = GfxPlus.defaultColor.b
    newColorObj.a = GfxPlus.defaultColor.a
    
    --If a is undefined, return the default color
    if (type(a) == "nil") then
      return newColorObj
    end
    --If a isn't a number, throw an error.
    if not (type(a) == "number") then
      return nil, "Expected number, got a " .. type(a)
    end
    
    
    --If a was the only number passed, then return a brightness-only color.
    if (type(b) == "nil") then
      newColorObj.r = a
      newColorObj.g = a
      newColorObj.b = a
      return newColorObj
      
    --If b is an invalid type, throw an error.
    elseif not (type(b) == "number") then
      return nil, "Expected number, got a " .. type(b)
    end
    
    
    --If a and b were the only numbers passed, then return a brightness + alpha color.
    if (type(c) == "nil") then
      newColorObj.r = a
      newColorObj.g = a
      newColorObj.b = a
      newColorObj.a = b
      return newColorObj
      
    --If c is an invalid type, throw an error.
    elseif not (type(c) == "number") then
      return nil, "Expected number, got a " .. type(c)
    end
    
    
    --If a, b and c were the only numbers passed, then return a rgb color.
    if (type(d) == "nil") then
      newColorObj.r = a
      newColorObj.g = b
      newColorObj.b = c
      return newColorObj
      
    --If d is an invalid type, throw an error.
    elseif not (type(d) == "number") then
      return nil, "Expected number, got a " .. type(d)
    end
    
    
    --Since all 4 parameters were defined as numbers, return a rgba color.
    newColorObj.r = a
    newColorObj.g = b
    newColorObj.b = c
    newColorObj.a = d
    return newColorObj
  end

  function GfxPlus.Color:setColor(a, b, c, d)
    --Set color values to the defaultColor values
    self.r = GfxPlus.defaultColor.r
    self.g = GfxPlus.defaultColor.g
    self.b = GfxPlus.defaultColor.b
    self.a = GfxPlus.defaultColor.a
    
    --If a is undefined, set to the default color
    if (type(a) == "nil") then
      return
    end
    --If a isn't a number, throw an error.
    if not (type(a) == "number") then
      return nil, "Expected number, got a " .. type(a)
    end
    
    
    --If a was the only number passed, then set to a brightness-only color.
    if (type(b) == "nil") then
      self.r = a
      self.g = a
      self.b = a
      return
      
    --If b is an invalid type, throw an error.
    elseif not (type(b) == "number") then
      return nil, "Expected number, got a " .. type(b)
    end
    
    
    --If a and b were the only numbers passed, then set to a brightness + alpha color.
    if (type(c) == "nil") then
      self.r = a
      self.g = a
      self.b = a
      self.a = b
      return
      
    --If c is an invalid type, throw an error.
    elseif not (type(c) == "number") then
      return nil, "Expected number, got a " .. type(c)
    end
    
    
    --If a, b and c were the only numbers passed, then set to a rgb color.
    if (type(d) == "nil") then
      self.r = a
      self.g = b
      self.b = c
      return
      
    --If d is an invalid type, throw an error.
    elseif not (type(d) == "number") then
      return nil, "Expected number, got a " .. type(d)
    end
    
    
    --Since all 4 parameters were defined as numbers, set to a rgba color.
    self.r = a
    self.g = b
    self.b = c
    self.a = d
  end

  function GfxPlus.Color:toGfxColorObj()
    return Gfx.RGBA8(self.r, self.g, self.b, self.a)
  end
  
  function GfxPlus.Color:__debug__printColor()
    print("r: " .. self.r .. "  g: " .. self.g .. "  b: " .. self.b .. "  a: " .. self.a)
  end
  
  --This is the end of the Color class
  
  --This function color() is just an shortcut for Color.new()
  function GfxPlus.color(color_a, color_b, color_c, color_d)
    return GfxPlus.Color:new(color_a, color_b, color_c, color_d)
  end
  
  --This is the end of the Color class
  

  GfxPlus.__strokeColor = GfxPlus.Color:new()
  GfxPlus.__strokeWeight = 2
  
  --This is the beginning of the stroke commands
  function GfxPlus.stroke(color_a, color_b, color_c, color_d)
    if GfxPlus.isColor(color_a) then
      GfxPlus.__strokeColor = color_a
      return
    end
    return GfxPlus.__strokeColor:setColor(color_a, color_b, color_c, color_d)
  end

  function GfxPlus.noStroke()
    return GfxPlus.__strokeColor:setColor(0, 0)
  end

  function GfxPlus.strokeWeight(strokeWeightIn)
    if not (type(weight) == "number") then
      if (type(strokeWeightIn) == "nil") then
        return nil, "strokeWeight() takes 1 numerical parameter!"
      end
      return nil, "Expected number, got a " .. type(a)
    end
  end

  --This is the end of the stroke commands


  GfxPlus.__fillColor = GfxPlus.Color:new(255)
  
  --This is the beginning of the fill commands
  function GfxPlus.fill(color_a, color_b, color_c, color_d)
    if GfxPlus.isColor(color_a) then
      GfxPlus.__fillColor = color_a
      return
    end
    
    return GfxPlus.__fillColor:setColor(color_a, color_b, color_c, color_d)
  end

  function GfxPlus.noFill()
    return GfxPlus.__fillColor:setColor(0, 0)
  end

  --This is the end of the fill commands
  
  
  --These are a few extra functions for ease of use.
  function GfxPlus.isColor(possibleColor)
    return (type(possibleColor) == "table") and (type(possibleColor.r) == "number") and (type(possibleColor.g) == "number") and (type(possibleColor.b) == "number") and (type(possibleColor.a)) == "number"
  end
  
  function GfxPlus.background(color_a, color_b, color_c, color_d)
    if GfxPlus.isColor(color_a) then
      GfxPlus.rect(0, 0, GfxPlus.width, GfxPlus.width, color_a, GfxPlus.color(0, 0), 0)
      return
    end
    
    GfxPlus.rect(0, 0, GfxPlus.width, GfxPlus.width, GfxPlus.color(color_a, color_b, color_c, color_d), GfxPlus.color(0, 0), 0) 
  end
  
  function GfxPlus.lerpColor(color1, color2, amount)
    local newRed   = color1.r * amount + color2.r * (1 - amount)
    local newGreen = color1.g * amount + color2.g * (1 - amount)
    local newBlue  = color1.b * amount + color2.b * (1 - amount)
    local newAlpha = color1.a * amount + color2.a * (1 - amount)
    
    return(GfxPlus.color(newRed, newGreen, newBlue, newAlpha))
  end
end

--This is the end of the color related commands



--This is the start of the shape drawing commands
do
  function GfxPlus.rect(x, y, rectWidth, rectheight, optFill, optStroke, optStrokeWeight)
    local rectFill
    if GfxPlus.isColor(optFill) then
      rectFill = optFill:toGfxColorObj()
    else
      rectFill = GfxPlus.__fillColor:toGfxColorObj()
    end
    
    local rectStroke
    if GfxPlus.isColor(optStroke) then
      rectStroke = optStroke:toGfxColorObj()
    else
      rectStroke = GfxPlus.__strokeColor:toGfxColorObj()
    end
    
    local rectStrokeWeight = optStrokeWeight or GfxPlus.__strokeWeight
    
    --Rectangle fill
    Gfx.drawRectangle(x, y, rectWidth, rectheight, rectFill)
    
    
    --Rectangle outline/stroke
    if not rectStrokeWeight == 0 then
      Gfx.drawRectangle(x      -strokeWeight/2,         y       -strokeWeight/2,         rectWidth+strokeWeight,                   strokeWeight,        rectStroke)  -- top    line
      Gfx.drawRectangle(x      -strokeWeight/2,         y       -strokeWeight/2,                   strokeWeight,        rectHeight+strokeWeight,        rectStroke)  -- left   line
      Gfx.drawRectangle(x+width-strokeWeight/2,         y       -strokeWeight/2,                   strokeWeight,        rectHeight+strokeWeight,        rectStroke)  -- right  line
      Gfx.drawRectangle(x      -strokeWeight/2,         y+height-strokeWeight/2,         rectWidth+strokeWeight,                   strokeWeight,        rectStroke)  -- bottom line
    end
    
  end
  
  function GfxPlus.triangle(x1, y1, x2, y2, x3, y3, optFill, optStroke, optStrokeWeight)
    local triangleFill
    if GfxPlus.isColor(optFill) then
      triangleFill = optFill:toGfxColorObj()
    else
      triangleFill = GfxPlus.__fillColor:toGfxColorObj()
    end
    
    local triangleStroke
    if GfxPlus.isColor(optStroke) then
      triangleStroke = optStroke:toGfxColorObj()
    else
      triangleStroke = GfxPlus.__strokeColor:toGfxColorObj()
    end
    
    local triangleStrokeWeight = optStrokeWeight or GfxPlus.__strokeWeight
    
    sideLengths = {GfxPlus.Math.pointDist(x1, y1, x2, y2), GfxPlus.Math.pointDist(x1, y1, x3, y3), GfxPlus.Math.pointDist(x2, y2, x3, y3)}
    cornerAltitudes = {GfxPlus.Math.distPoint2Line(x1, y1, x2, y2, x3, y3), GfxPlus.Math.distPoint2Line(x2, y2, x1, y1, x3, y3), GfxPlus.Math.distPoint2Line(x3, y3, x2, y2, x1, y1)}
    --math.abs(a * x0 + b * y0 + c) / math.sqrt(a*a + b*b)
    
    local baseAngle
    local relativeAngle
    local newPointPositions = {line = {{x = 0, y = 0}, {x = 0, y = 0}}, point = {x = 0, y = 0}}
    if cornerAltitudes[1] <= cornerAltitudes[2] and cornerAltitudes[1] <= cornerAltitudes[3] then
      baseAngle = GfxPlus.Math.points2Angle(x2, y2, x3, y3)
      relativeAngle = (baseAngle - GfxPlus.Math.points2Angle(x2, y2, x1, y1)) % (math.pi * 2)
      Gfx.rotate(x2, y2, math.deg(baseAngle))
      
      newPointPositions.line[1].x = x2
      newPointPositions.line[1].y = y2
      newPointPositions.line[2].x = x2 + sideLengths[3]
      newPointPositions.line[2].y = y2
      newPointPositions.point.x = math.cos(relativeAngle) * sideLengths[1] + x2
      newPointPositions.point.y = -math.sin(relativeAngle) * sideLengths[1] + y2
      
    elseif cornerAltitudes[2] <= cornerAltitudes[1] and cornerAltitudes[2] <= cornerAltitudes[3] then
      baseAngle = GfxPlus.Math.points2Angle(x3, y3, x1, y1)
      relativeAngle = (baseAngle - GfxPlus.Math.points2Angle(x3, y3, x2, y2)) % (math.pi * 2)
      Gfx.rotate(x3, y3, math.deg(baseAngle))
      
      newPointPositions.line[1].x = x3
      newPointPositions.line[1].y = y3
      newPointPositions.line[2].x = x3 + sideLengths[2]
      newPointPositions.line[2].y = y3
      newPointPositions.point.x = math.cos(relativeAngle) * sideLengths[3] + x3
      newPointPositions.point.y = -math.sin(relativeAngle) * sideLengths[3] + y3
      
    else
      baseAngle = GfxPlus.Math.points2Angle(x1, y1, x2, y2)
      relativeAngle = (baseAngle - GfxPlus.Math.points2Angle(x1, y1, x3, y3)) % (math.pi * 2)
      Gfx.rotate(x1, y1, math.deg(baseAngle))
      
      newPointPositions.line[1].x = x1
      newPointPositions.line[1].y = y1
      newPointPositions.line[2].x = x1 + sideLengths[1]
      newPointPositions.line[2].y = y1
      newPointPositions.point.x = math.cos(relativeAngle) * sideLengths[2] + x1
      newPointPositions.point.y = -math.sin(relativeAngle) * sideLengths[2] + y1
      
    end
    
    local triangleLineIterator = 0
    
    while triangleLineIterator <= 1 do
      
      local currentRectPoints = {
        GfxPlus.Math.pointLerp(newPointPositions.line[1].x, newPointPositions.line[1].y, newPointPositions.point.x, newPointPositions.point.y, triangleLineIterator), 
        GfxPlus.Math.pointLerp(newPointPositions.line[2].x, newPointPositions.line[2].y, newPointPositions.point.x, newPointPositions.point.y, triangleLineIterator)
      }
      currentRectPoints[2].y = currentRectPoints[2].y + 2
      
      currentRectArgs = {xPos = GfxPlus.Math.round(currentRectPoints[1].x ), yPos = GfxPlus.Math.round(currentRectPoints[1].y), width = GfxPlus.Math.round(currentRectPoints[2].x - currentRectPoints[1].x), height = 2}
      
      
      Gfx.drawRectangle(currentRectArgs.xPos, currentRectArgs.yPos, currentRectArgs.width, currentRectArgs.height, triangleFill)
      triangleLineIterator = triangleLineIterator + 1/math.abs(newPointPositions.point.y - newPointPositions.line[1].y)
    end
    Gfx.popMatrix()
  end
  
  
  GfxPlus.__ellipseMode = {horizAlign = 1, vertAlign = 1}
  function GfxPlus.ellipseMode(horiz, vert)
    if type(horiz) == "number" then
      if not horiz % 1 then
        GfxPlus.__ellipseMode.horizAlign = horiz % 3
      end
    else
      if type(horiz) == "string" then
        if horiz:lower() == "left" then
          GfxPlus.__ellipseMode.horizAlign = 0
          
        elseif horiz:lower() == "center" then
          GfxPlus.__ellipseMode.horizAlign = 1
          
        elseif horiz:lower() == "right" then
          GfxPlus.__ellipseMode.horizAlign = 2
          
        end
      end
    end
    
    
    if type(vert) == "number" then
      if not vert % 1 then
        GfxPlus.__ellipseMode.vertAlign = vert % 3
      end
    else
      if type(vert) == "string" then
        if vert:lower() == "top" then
          GfxPlus.__ellipseMode.vertAlign = 0
          
        elseif vert:lower() == "center" then
          GfxPlus.__ellipseMode.vertAlign = 1
          
        elseif vert:lower() == "bottom" then
          GfxPlus.__ellipseMode.vertAlign = 2
          
        end
      end
    end
    
  end
  
  function GfxPlus.ellipse(x, y, ellipseWidth, ellipseHeight, optFill, optStroke, optStrokeWeight)
    local ellipseFill
    local ellipseFillTemp
    if GfxPlus.isColor(optFill) then
      ellipseFill = optFill:toGfxColorObj()
      ellipseFillTemp = optFill
    else
      ellipseFill = GfxPlus.__fillColor:toGfxColorObj()
      ellipseFillTemp = GfxPlus.__fillColor
    end
    
    
    
    local ellipseStroke
    if GfxPlus.isColor(optStroke) then
      ellipseStroke = optStroke:toGfxColorObj()
    else
      ellipseStroke = GfxPlus.__strokeColor:toGfxColorObj()
    end
    
    local ellipseStrokeWeight = optStrokeWeight or GfxPlus.__strokeWeight
    
    
    startingPoint = {x = x - (GfxPlus.__ellipseMode.horizAlign - 1) * (ellipseWidth / 2), y = y - GfxPlus.__ellipseMode.vertAlign * (ellipseHeight / 2)}
    
    
    local currEllipRectIndex = 0
    
    while currEllipRectIndex <= ellipseHeight do
      local currEllipRectTrueWidth = math.sqrt(ellipseHeight^2 - (currEllipRectIndex*2-ellipseHeight)^2) * ellipseWidth / ellipseHeight
      
      --And now for anti-aliasing calculations on the CPU.
      local currEllipSolidRectX = startingPoint.x - math.floor(currEllipRectTrueWidth / 2)
      local currEllipTranspRectX = startingPoint.x - math.ceil(currEllipRectTrueWidth / 2)
      local currEllipSolidRectWidth = math.floor(currEllipRectTrueWidth / 2) * 2
      local currEllipTranspRectWidth = math.ceil(currEllipRectTrueWidth / 2) * 2
      local currEllipTranspColor = GfxPlus.color(
        ellipseFillTemp.r,
        ellipseFillTemp.g,
        ellipseFillTemp.b,
        GfxPlus.Math.round(ellipseFillTemp.a * (currEllipRectTrueWidth - currEllipSolidRectWidth) / 3 * (currEllipSolidRectX - currEllipTranspRectX)) 
      ):toGfxColorObj()
      
      Gfx.drawRectangle(currEllipTranspRectX, startingPoint.y + currEllipRectIndex, currEllipTranspRectWidth, 1, currEllipTranspColor)
      Gfx.drawRectangle(currEllipSolidRectX, startingPoint.y + currEllipRectIndex, currEllipSolidRectWidth, 1, ellipseFill)
      
      currEllipRectIndex = currEllipRectIndex + 1
    end
  end
  
end

--This is the end of the shape drawing commands




--This is the beginning of the GfxPlus.Math library
do
  GfxPlus.Math = {}
  
  function GfxPlus.Math.points2StandardForm(p1x, p1y, p2x, p2y)
    local xcoeff = p2y - p1y
    local ycoeff = p1x - p2x
    local variable_C = p1x * xcoeff + p1y * ycoeff
    return xcoeff, ycoeff, variable_C
    --Form is: xcoeff(x) + ycoeff(y) = variable_C
  end
  
  function GfxPlus.Math.standardForm2Slope(xcoeff, ycoeff, variable_C)
    if xcoeff == 0 then
      return nil
    end
    
    return xcoeff / (-ycoeff)
  end
  
  function GfxPlus.Math.points2Slope(p1x, p1y, p2x, p2y)
    if p1x == p2x then
      return nil
    end
    
    return (p2y - p1y) / (p2x - p1x)
  end
  
  function GfxPlus.Math.slope2Angle(slope)
    if slope == nil then
      return math.pi / 2
    end
    
    return math.atan(slope)
  end
  
  function GfxPlus.Math.points2Angle(p1x, p1y, p2x, p2y)
    local angleModPi = GfxPlus.Math.slope2Angle(GfxPlus.Math.points2Slope(p1x, p1y, p2x, p2y))
    
    if p2x < p1x or (p1x == p2x and p2y < p1y) then
      return angleModPi + math.pi
    end
    
    return angleModPi % (math.pi * 2)
  end
  
  function GfxPlus.Math.distPoint2Line(px, py, lx1, ly1, lx2, ly2)
    local a, b, c = GfxPlus.Math.points2StandardForm(lx1, ly1, lx2, ly2)
    
    return math.abs(a * px + b * py - c) / math.sqrt(a*a + b*b)
  end
  
  function GfxPlus.Math.pointDist(p1x, p1y, p2x, p2y)
    return math.sqrt((p1x - p2x)^2 + (p1y - p2y)^2)
  end
  
  function GfxPlus.Math.lerp(value1, value2, value)
    return value1 * (1 - value) + value2 * value
  end
  
  function GfxPlus.Math.pointLerp(p1x, p1y, p2x, p2y, value)
    return {x = GfxPlus.Math.lerp(p1x, p2x, value), y = GfxPlus.Math.lerp(p1y, p2y, value)}
  end
  
  function GfxPlus.Math.round(value)
    return math.floor(value + 0.5)
  end
  
end

--This is the end of the GfxPlus.Math library


return GfxPlus