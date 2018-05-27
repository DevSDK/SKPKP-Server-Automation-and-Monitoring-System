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





function run(hostname, targets)
    calltargets = targets
    if calltargets == nil then
        print("[Error] Check Target Argument ")
        return
    end
    rednet.host("rttp", hostname)
    print("Rttp Server has been started at \""..hostname.."\"")
    while true do
        local id, message, protocal = rednet.receive()
        local target_data = __parse_header_body(tostring(message))
        local isFoundTarget = false
        if tostring(protocal) == "rttp" then
            for key, value in pairs(targets) do
                if key == target_data[0] then
                    isFoundTarget = true
                    local res = value(target_data[1])
                    __receive(id, key, res)
                    break
                end
            end
            if isFoundTarget == false then
                rednet.send(id, "<".. target_data[0] .. "><-2><Cannot found logic>", "rttp")
            end
        end
    end 
end

function get(--[[required]]address, --[[required]]location, --[[required]]data, --[[optional]]timeout)
    id = rednet.lookup("rttp", address)
    timeout = timeout or 60
    if id == nil then
        return 0, nil
    end

    rednet.send(id, "<" .. location .. "><" .. data .. ">" , "rttp")
    local id, message, protocal = rednet.receive("rttp",timeout)
    local arr = __parse_header_body(tostring(message))

    return arr[1], arr[2]

end

function __receive(id, location, res)
    if res == nil then
        rednet.send(id, "<"..location..">".."<-1><UNDEFINED RESPONSE>", "rttp")
        return
    end
    rednet.send(id, "<"..location..">".."<"..res[0]..">" .. "<"..res[1] ..">", "rttp")
end
function receive(code, data)
        local dat = {}
        dat[0] = code
        dat[1] = data
        return dat
end

function open(side)
    rednet.open(side)
end

function close(side)
    rednet.close(side)
end


-- <TARGET ADDRESS> ---- HEADER
-- <DATA>           ---- BODY
-- Target Address   : this is set of Header group and target address like http's /index stuffs
-- Data             : this is set of body; data what we want to send (JSON)
--
function __parse_header_body(str)
    local stack  = 0
    local result = {}
    local index = 0
    local temp = ""
    for i = 1, string.len(str) do
        local c = string.sub(str,i,i)
        if c == '<' then
            if stack ~= 0 then
                temp = temp .. c
            end
            stack = stack + 1
        elseif c == '>' then
            stack= stack - 1
            if stack ~= 0 then
                temp = temp .. c
            end
        else
            temp = temp .. c
        end
        if stack == 0 then
            result[index] = temp
            temp =""
            index = index + 1

        end
    end

    return result
end
