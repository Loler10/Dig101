local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Grow A Garden | Script Hub",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by lolbnoy",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Create Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Create Sections
local MainSection = MainTab:CreateSection("Farming")
local MiscSection = MiscTab:CreateSection("Player Mods")

-- Auto Farm Toggle
MainTab:CreateToggle({
   Name = "Auto Farm",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoFarm = Value
      while getgenv().autoFarm do
         local plr = game.Players.LocalPlayer
         local garden = workspace:FindFirstChild(plr.Name .. "_Garden")
         if garden then
            local harvestRemote = game.ReplicatedStorage:FindFirstChild("HarvestCrop")
            for _, crop in ipairs(garden:GetChildren()) do
               if crop:IsA("Part") and crop:FindFirstChild("ReadyToHarvest") then
                  if harvestRemote then
                     harvestRemote:FireServer(crop)
                  end
               end
            end
         end
         wait(5) -- Adjust the wait time as needed
      end
   end,
})

-- Infinite Seeds Button
MainTab:CreateButton({
   Name = "Infinite Seeds",
   Callback = function()
      local plr = game.Players.LocalPlayer
      local backpack = plr:FindFirstChild("Backpack")
      if backpack then
         for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("seed") then
               item:Clone().Parent = backpack
            end
         end
      end
   end,
})

-- Sell All Button
MainTab:CreateButton({
   Name = "Sell All Crops",
   Callback = function()
      local sellRemote = game.ReplicatedStorage:FindFirstChild("SellAll")
      if sellRemote then
         sellRemote:FireServer()
      end
   end,
})

-- WalkSpeed Slider
MiscTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- JumpPower Slider
MiscTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 150},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})
