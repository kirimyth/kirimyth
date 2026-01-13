local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local localplayer = game.Players.LocalPlayer
local wspeed = false

local Options = Fluent.Options
local Window = Fluent:CreateWindow({
    Title = "kirimyth",
    SubTitle = "Script Version: 0.0.1-DEV",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Movement = Window:AddTab({ Title = "Movement", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}


----- Main Tab -----
--- Player section ---
local sectionplayer = Tabs.Main:AddSection("Player")
local sectionjumpempty = Tabs.Main:AddSection(" ")
local walkspeedslider = sectionplayer:AddSlider("walkspeedslider", {
    Title = "Walkspeed",
    Description = "Change your walkspeed.",
    Default = 16,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value)
        if wspeed and localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
            localplayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})
local walkspeedtoggle = sectionplayer:AddToggle("walkspeedtoggle", {
    Title = "Enable Speed Hack",
    Default = false,
    Callback = function(Value)
        wspeed = Value
        if wspeed then
            if wspeed and localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
            localplayer.Character.Humanoid.WalkSpeed = Options.walkspeedslider.Value
            Fluent:Notify({
                Title = "kirimyth",
                Content = "Speed turned on!",
                Duration = 1
            })
            end
        else
            if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
                localplayer.Character.Humanoid.WalkSpeed = 16
                Fluent:Notify({
                Title = "kirimyth",
                Content = "Speed turned off!", 
                Duration = 1
            })
            end
        end
    end
})
local walkspeedkeybind = sectionplayer:AddKeybind("walkspeedkeybind", {
    Title = "Toggle Speed Keybind",
    Mode = "Toggle",
    Default = "X",
    Callback = function(Value)
        wspeed = Value
        if wspeed then
            walkspeedtoggle:SetValue(true)
        else
            walkspeedtoggle:SetValue(false)
        end
    end
})

local jumppowertoggle = sectionjumpempty:AddToggle("jumppowertoggle", {
    Title = "Enable Jump Power Hack",
    Default = false,
})
--- Player section ---
----- Main Tab -----


local destroyscript = Tabs.Settings:AddSection("Destroy kirimyth")
destroyscript:AddButton({
    Title = "Destroy kirimyth",
    Callback = function()
        Window:Dialog({
            Title = "Are you sure?",
            Buttons = {
                {
                    Title = "Yes!",
                    Callback = function()
                        Fluent:Destroy()
                    end
                }, {
                    Title = "No!",
                    Callback = function()
                        Fluent:Notify({
                            Title = "kirimyth",
                            Content = "Destruction canceled!",
                            SubContent = "Thanks for keeping kirimyth!",
                            Duration = 3
                        })
                    end
                }
            }
        })
    end
})

do

end
Fluent:Notify({
    Title = "kirimyth",
    Content = "Script successfully injected!",
    SubContent = "You are using the DEV version of the script! Thanks for being a supporter!",
    Duration = 5
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
