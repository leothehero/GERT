-- GUS Server UI - Beta 1 
print("Initiating GERT Update Suite User Interface - Server Edition")
print()
print("Preparing Modules...")

print("Loading shell API...")
local shell = require("shell")
local args, opts = shell.parse(...)
print("Loading component API...")
local component = require("component")
print("Loading term API...")
local term = require("term")
print("Loading hardware interface...")
local computer = require("computer")
print("Loading thread API...")
local thread = require("thread")

print("Preparing Internal Variables...")
local gpu = component.gpu
local screenWidth,screenHeight = gpu.getResolution()
local PrimaryColour = 0xfc9414


gpu.setForeground(0xfc9414)
print("Complete!")

local function Beep(freq,rep)
    if not opts.m then
        computer.beep(freq,rep)
    end
end

local function AestheticSleep(duration)
    if not opts.f then
        os.sleep(duration)
    end
end

local function Jingle () 
    os.sleep(0.05) -- if I dont do this the thread becomes blocking for some reason
    Beep(450,0.15)
    Beep(380,0.15)
    Beep(600,0.5)
end

local function GetCenterOffsets (textLen,screenWidth)
    local TextOffset = textLen/2+1
    local Middle = screenWidth/2
    local StartPoint = Middle-TextOffset
    return StartPoint
end

local function DrawMainScreen(Title,SubTitle)
    term.clear()
    AestheticSleep(0.2)    
    local TopWidth = math.max(string.len(Title),string.len(SubTitle))
    local startPoint = GetCenterOffsets(TopWidth,screenWidth)
    term.setCursor(startPoint,1)
    term.write("╔"..string.rep("═",TopWidth).."╗")
    local joinString = "╔" .. string.rep("═",(screenWidth-TopWidth)/2-4) .. "╩" .. string.rep("═",TopWidth) .. "╩" .. string.rep("═",(screenWidth-TopWidth)/2-4)
    local i = 2
    while i < screenHeight do
        AestheticSleep(0.05)
        if i == 3 then
            term.setCursor(1,3)
            term.write("╠"..string.rep("═",screenWidth-2).."╣")
        else
            gpu.set(1,i,"║")
            gpu.set(screenWidth,i,"║")
        end
        i = i + 1
    end
    AestheticSleep(0.05)
    term.setCursor(1,screenHeight)
    term.write("╚"..string.rep("═",screenWidth-2).."╝")
    AestheticSleep(0.05)
    term.setCursor()
end



thread.create(Jingle)
AestheticSleep(0.5)
term.write("Rendering User Interface\n")
AestheticSleep(0.5)
term.clear()
AestheticSleep(0.5)



DrawMainScreen("GERT Update Server","Main Menu")