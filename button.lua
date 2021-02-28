
local monitor = peripheral.find("monitor")
local object = require("classic")
function terminate(required)
    print( required.. " not found! Terminating in 3 seconds! ")
    sleep(3)

    os.queueEvent("terminate")
end



if monitor then
   oldTerm =  term.redirect(monitor)
else
    terminate("Monitor")
end




local buttons = {}




function button:new(name, text, func, xmin, ymin, xmax, ymax,  colour)
    buttons[name] = {}
    buttons[name]["func"] = func
    buttons[name]["xmin"] = xmin
    buttons[name]["ymin"] = ymin
    buttons[name]["xmax"] = xmax
    buttons[name]["ymax"] = ymax
    buttons[name]["colour"] = colour
    buttons[name]["text"] = text


    self.name = name
    self.text = text
    self.func = func
    self.xmin = xmin
    self.ymin = ymin
    self.xmax = xmax
    self.ymax = ymax
    self.colour = colour

end






function button:render()

    local name = self.name
    

    local func = buttons[name]["func"]
    local xmin = buttons[name]["xmin"]
    local ymin = buttons[name]["ymin"]
    local xmax = buttons[name]["xmax"]
    local ymax = buttons[name]["ymax"]
    local colour = buttons[name]["colour"]
    local text = buttons[name]["text"]

    
    self.text = text
    self.func = func
    self.xmin = xmin
    self.ymin = ymin
    self.xmax = xmax
    self.ymax = ymax
    self.colour = colour



    local xspot = math.floor(xmin +xmax)/2
    local yspot = math.floor(ymin + ymax)/2
    monitor.setTextScale(1)
    for x = xmin, xmax + string.len(text) do
       for y = ymin, ymax do
              paintutils.drawPixel(x,y, colour)
       end 
    end
    term.setCursorPos(xspot, yspot)
    print(text)
    monitor.setBackgroundColour(colors.black)
end

function button:press()
    self.func()
end



function button:unrender()
    local background =  term.getBackgroundColor()
    local name = self.name

    local func = buttons[name]["func"]
    local xmin = buttons[name]["xmin"]
    local ymin = buttons[name]["ymin"]
    local xmax = buttons[name]["xmax"]
    local ymax = buttons[name]["ymax"]
    local colour = buttons[name]["colour"]
    local text = buttons[name]["text"]

    for x = xmin, xmax + string.len(text) do
        for y = ymin, ymax do
               paintutils.drawPixel(x,y, background)
               term.setCursorPos(15,15)
               
               
        end 
    end
    monitor.setBackgroundColour(background)


end

function button:destroy()
    local name = self.name
    table.remove(buttons[name])

    self = nil
end

function clickButton(name, ...)
    local pressedbutton = findButton(name)
    pressedbutton["func"](...)
end


function findButton(name)
    return buttons[name]
end

function findButtonFromPixel(x,y)
    for i, button in pairs(buttons) do
        local xmin = button["xmin"]
        local xmax = button["xmax"]
        local ymin = button["ymin"]
        local ymax = button["ymax"]
        local text = button["text"]
        local name = i

        for a = xmin, xmax + string.len(text) do
            for b = ymin, ymax do
                if a==x and b==y then
                    return name
                end
            end 
         end
    end
end

return button


--[[

function setButton(name, text, func, xmin, ymin, xmax, ymax, visible, colour)
    buttons[name] = {}
    buttons[name]["func"] = func
    buttons[name]["xmin"] = xmin
    buttons[name]["ymin"] = ymin
    buttons[name]["xmax"] = xmax
    buttons[name]["ymax"] = ymax
    buttons[name]["colour"] = colour
    buttons[name]["text"] = text


end






function fillButton(name)
    local button = findButton(name)
    local xmin = button["xmin"]
    local xmax = button["xmax"]
    local ymin = button["ymin"]
    local ymax = button["ymax"]
    local colour = button["colour"]
    local text = button["text"]

    local xspot = math.floor(xmin +xmax)/2
    local yspot = math.floor(ymin + ymax)/2
    monitor.setTextScale(1)
    for x = xmin, xmax + string.len(text) do
       for y = ymin, ymax do
              paintutils.drawPixel(x,y, colour)
       end 
    end
    term.setCursorPos(xspot, yspot)
    print(text)
    monitor.setBackgroundColour(colors.black)
end
]]--







--name, text, func, xmin, ymin, xmax, ymax,  colour


--print("buttonevent")

--print("buttonevent2")

--for k, b in pairs(buttons) do
--    for i, val in pairs(b) do
--       print(val) 
--    end
--end