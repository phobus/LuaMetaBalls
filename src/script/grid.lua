local lines_color = {0, 63,0}
local corner_color = {15, 191, 15}
local background_color = {0, 0, 0}

local coners
local points

local screen_width, screen_height
local map_cols, map_rows
local tile_size
local bound

local function init(sw, sh, mc, mr, ts) 
  screen_width, screen_height = sw, sh
  map_cols, map_rows = mc, mr
  tile_size = ts  
end

local function update(dt)  
  for r=1, map_rows do
    for c=1, map_cols do
      coners[r][c] = points[r][c] >= bound or false            
    end
  end
end

local function draw()  
  local lg = love.graphics
  lg.clear(background_color)
  
  lg.setColor(lines_color)  
  for r=0, screen_width, tile_size do lg.line(r, 0, r, screen_height) end
  for c=0, screen_height, tile_size do lg.line(0, c, screen_width, c) end
  
  lg.setColor( corner_color )
  for r=1, map_rows do
    y = (r-1) * tile_size
    for c=1, map_cols do
      x = (c-1) * tile_size      
      if coners[r][c] then lg.rectangle( "fill", x-2, y-1, 3, 3 ) end      
    end
  end
  
end

local Grid= {
  init= init,
  update= update,
  draw= draw,
  
  setBound = function(value) bound = value end,
  setPoints = function(value)    
    points = value     
    coners = {}
    for r=1, map_rows do coners[r] = {} end
  end,
}

return Grid