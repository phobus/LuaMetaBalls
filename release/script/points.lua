local color= { 0, 63, 0 }
local text_color= { 127, 127, 127 }
local smallFont

local instances
local circles

local map_cols, map_rows
local tile_size
local hts

local function init(mc, mr, ts, c)    
  map_cols, map_rows = mc, mr
  tile_size = ts
  circles = c
  hts = tile_size * 0.5  
    
  smallFont = love.graphics.newFont(8)
end

local function update(dt)  
  local d, x, y
  for r=1, map_rows do    
    for c=1, map_cols do
      x, y = (c -1) * tile_size, (r - 1) * tile_size      
      instances[r][c] = 0
      for k, circle in ipairs( circles ) do        
        d =  circle.r ^2  / ( ( x - circle.px ) ^2 + ( y - circle.py ) ^2 )        
        --d =  circle.r * circle.r  / ( ( x - circle.px ) * ( x - circle.px ) + ( y - circle.py ) * ( y - circle.py ) )
        instances[r][c] = instances[r][c] + d
      end
    end
  end
end

local function draw()    
  local lg = love.graphics
  local x, y, v
  lg.setFont(smallFont)
  for r=1, map_rows do    
    for c=1, map_cols do
      x, y = (c -1) * tile_size, (r - 1) * tile_size
      x, y = x + hts, y + hts
      lg.setColor( color )      
      lg.rectangle( "fill", x-2, y, 3, 3)      
      lg.setColor( text_color )
      if instances[r][c] < 1 then v = instances[r][c] else v = 1 end  
      lg.print( string.format( "%.2f", v ), x - 10, y + 6 )
    end
  end
end

local Points= {
  init= init,
  update= update,
  draw= draw,
  
  getInstances = function() return instances end,
  setCircles = function(value) 
    circles = value 
    instances = {}
    for r=1, map_rows do instances[r] = {} end
  end,
}

return Points