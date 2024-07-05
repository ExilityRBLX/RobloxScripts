local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Script Toggle UI", "DarkTheme")

local Tab = Window:NewTab("Type Race")

local Section = Tab:NewSection("Main")

local scriptRunning = false
local toggleConnection

local function startScript()
    local sb = workspace.SelectionBox
    local vim = game:GetService("VirtualInputManager")
    toggleConnection = game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            if workspace.SelectionBox.Adornee and workspace.SelectionBox.Adornee ~= workspace.Baseplate then
                local key = (sb.Adornee.SurfaceGui.TextLabel.Text ~= " " and sb.Adornee.SurfaceGui.TextLabel.Text:upper() or "Space")
                vim:SendKeyEvent(true, Enum.KeyCode[key], false, nil)
                wait()
                vim:SendKeyEvent(false, Enum.KeyCode[key], false, nil)
            end
        end)
    end)
end

local function stopScript()
    if toggleConnection then
        toggleConnection:Disconnect()
        toggleConnection = nil
    end
end

Section:NewToggle("Autotype", "Did you even read the title?", function(state)
    if state then
        scriptRunning = true
        startScript()
    else
        scriptRunning = false
        stopScript()
    end
end)
