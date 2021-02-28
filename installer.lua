local w, h = term.getSize()

paintutils.drawFilledBox(1,1,w,h,colours.blue )

function centretext( message, ybool, yi)
    local x = math.floor((  w-string.len(message) )/2)
    local y = math.floor((h-string.len(message))/2)
    if ybool then
        term.setCursorPos(x,yi)
        term.clearLine()
        print(message)
        return
    end

    term.setCursorPos(x,y)
    term.clearLine()
    print(message)
end

centretext("Entering Installer! ", true, 2)

sleep(1)


centretext("Download prerequisite files", true, 3)

