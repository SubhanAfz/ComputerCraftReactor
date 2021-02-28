local monitor = peripheral.find("monitor")
local object = require("classic")

function terminate(required)
    print( required.. " not found! Terminating in 3 seconds! ")
    sleep(3)

    os.queueEvent("terminate")
end


if monitor then
     oldterm = term.redirect(monitor)
else
    terminate("Monitor")
end

local progressbar = object:extend()



function progressbar:new(name, text, progressmade, colour, defaultcolour ,xmin, xmax, ymin, ymax)
    self.name = name
    self.text = text
    self.progressmade = progressmade
    self.colour = colour
    self.defaultcolour = defaultcolour

    self.xmin = xmin
    self.xmax =  xmax
    self.ymin = ymin
    self.ymax = ymax
end


function progressbar:changeText(text)
    self.text = text
end
function progressbar:changeProgress(prog)
    if prog >1 then
        self.progressmade = 1
    else
        self.progressmade = prog
    end
    
end
function progressbar:changeColour(colour)
    self.colour = colour
end



function progressbar:render()
    local name = self.name
    local text = self.text
    local progressmade = self.progressmade
    local colour = self.colour
    local defaultcolour = self.defaultcolour

    local xmin = self.xmin
    local xmax = self.xmax
    local ymin = self.ymin
    local ymax = self.ymax


    local length = (xmax + string.len(text)) - xmin

    local xspot = math.floor(xmin +xmax)/2
    local yspot = math.floor(ymin + ymax)/2
    paintutils.drawFilledBox(xmin, ymin, xmax+string.len(text), ymax, defaultcolour)

 --[[
    for x = xmin, xmax + string.len(text) do
        for y = ymin, ymax do
               paintutils.drawPixel(x,y, defaultcolour)
        end 
    end
 ]]


    local lengthperpx = 100/length
    local percentage = progressmade*100
    local pixelsdraw = math.floor(percentage/lengthperpx)

    local coordinate = xmin +pixelsdraw
     

    for x = xmin, coordinate do
        for y = ymin, ymax do
               paintutils.drawPixel(x,y, colour)
        end 
    end
    if percentage <50 then
        monitor.setBackgroundColour(defaultcolour)
    else
        monitor.setBackgroundColour(colour)
    end
    term.setCursorPos(xspot, yspot)
    print(text)
    monitor.setBackgroundColour(colors.black)
end


return progressbar