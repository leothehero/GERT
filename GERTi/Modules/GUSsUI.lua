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
print("Loading event API...")
local event = require("event")
print("Loading GERT Update Server API...")
local GUS = require("GERTUpdateServer")

print("Preparing Internal Variables...")
local gpu = component.gpu
local oldResolution = {gpu.getResolution()}
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

local function DrawMenuResize(Title,Options)
    local Width = string.len(Title) + 2
    local Height = 3
    for k,v in pairs(Options) do
        if type(v) ~= "function" then
            k = "$"..k
        end
        Width = math.max(Width,string.len(k)+4)
        Height = Height + 1
    end
    gpu.setResolution(Width,Height)
    term.clear()
    term.write(" " ..Title)
    term.setCursor(1,2)
    term.write("╔"..string.rep("═",Width-2).."╗")
    local i = 3
    for k,v in pairs(Options) do
        if type(v) ~= "function" then
            k = "$"..k
        end
        gpu.set(1,i,"║")
        gpu.set(Width,i,"║")
        gpu.set(3,i,k)
        i = i + 1
    end
    term.setCursor(1,Height)
    term.write("╚"..string.rep("═",Width-2).."╝")
    return Width, Height
end

local function MenuSelect(Width,Height,Options)
    local cursor = 1
    local WidthTable = {}
    for k,v in pairs(Options) do
        if type(v) ~= "function" then
            k = "$"..k
        end
        WidthTable[cursor] = string.len(k)
        cursor = cursor + 1
    end
    cursor = 1
    local selected = false
    gpu.set(2,3,">")
    gpu.set(2+WidthTable[cursor]+1,3,"<")
    --[[repeat
        gpu.set(2,cursor+2," ")
        gpu.set(2,cursor+WidthTable[cursor]+2," ")
    until selected]]
    
end












thread.create(Jingle)
AestheticSleep(0.5)
term.write("Rendering User Interface\n")
AestheticSleep(0.5)
term.clear()
AestheticSleep(0.5)


local Width, Height = DrawMenuResize("Main Menu",GUS)
local result = MenuSelect(Width, Height, GUS)
os.sleep(1)
event.pull()
gpu.setResolution(oldResolution[1],oldResolution[2])

