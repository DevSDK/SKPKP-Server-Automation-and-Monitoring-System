--This program is used SPKPK management system
--
-- Copyright (c) 2018 Seokho Song
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.



function newLine(monitor, offset)
    local cX,cY = monitor.getCursorPos()
    monitor.setCursorPos(offset,cY+1)
end

function DrawDialog(monitor, offset)
    monitor.setCursorPos(offset, 1)
    monitor.write("#")
    newLine(monitor, offset)
    monitor.write("#")
    newLine(monitor, offset)
    monitor.write(" ")
    newLine(monitor, offset)
    monitor.write("#")
    newLine(monitor, offset)
    monitor.write("#")
    newLine(monitor, offset)
end

function DrawLargeNumber(monitor, offset, number)
    monitor.setCursorPos(offset, 1)
    if number == 0 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 1 then
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")        
    elseif number == 2 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#    ")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 3 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 4 then
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")        
    elseif number == 5 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#    ")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 6 then
        monitor.write("#    ")
        newLine(monitor, offset)
        monitor.write("#    ")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 7 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")        
    elseif number == 8 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")        
    elseif number == 9 then
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("#   #")
        newLine(monitor, offset)
        monitor.write("#####")
        newLine(monitor, offset)
        monitor.write("    #")
        newLine(monitor, offset)
        monitor.write("    #")        
    end
end

function PrintTime(monitor)
    local time = os.time()
    local first = math.floor(time/10)
    local second = math.floor(time%10)
    local min = ((time*1000%1000 / 1000) * 60)
    local min_first = math.floor(min / 10)
    local min_second = math.floor(min % 10)

    DrawLargeNumber(monitor,  padding + 1, first)
    DrawLargeNumber(monitor,padding+ 7, second)
    DrawDialog(monitor, padding+ 13)
    DrawLargeNumber(monitor, padding + 15, min_first)
    DrawLargeNumber(monitor, padding+ 21, min_second)
end

monitor1.setCursorPos(1,1)
monitor1.clear()
padding = 2

local monitor1 = peripheral.wrap("monitor_0")
print("The timer has been started, Press Ctrl + R to terminate program.")

while true do 
    PrintTime(monitor1)
    os.sleep(0.5)
end