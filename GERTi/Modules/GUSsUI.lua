local shell = require("shell")
local component = require("component")
local GUS = require("GERTUpdateServer")
local term = require("term")
local computer = require("computer")
local thread = require("thread")

local args, opts = shell.parse(...)

local function Beep(freq,rep)
    if not opts.m then
        computer.beep(freq,rep)
    end
end

local function Jingle () 
    Beep(450,0.15)
    Beep(380,0.15)
    Beep(600,0.25)
end

thread.create(Jingle)
term.write("Initiating GERT Update Server User Interface")