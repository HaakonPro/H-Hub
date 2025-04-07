-- Delte old rayfield ui's
for _, ui in game.CoreGui.HUI:GetChildren() do
	if ui:IsA("ScreenGui") then
		if ui.Name == "KeyUI-Old" or ui.Name == "Rayfield-Old" then
			ui:Destroy()
		end
	end
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local placeId = game.PlaceId
local player = game:GetService("Players").LocalPlayer

local Window = Rayfield:CreateWindow({
	Name = "H Hub",
	Icon = 0,
	LoadingTitle = "H Hub",
	LoadingSubtitle = "by Haakon",
	Theme = "Default",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = true,
		FolderName = true,
		FileName = "H Hub"
	},

	Discord = {
		Enabled = false,
		Invite = "noinvitelink",
		RememberJoins = true
	},

	KeySystem = true,
	KeySettings = {
		Title = "H Hub",
		Subtitle = "Key System",
		Note = "Just know the key :)",
		FileName = "HHubKey",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"HaakonIsPro"}
	}
})

-- Games
local function setupMoneySimulatorX()
	local Tabs = {
		Main = Window:CreateTab("Main", 4483362458),
		Mine = Window:CreateTab("Mine", 4483362458),
		Misc = Window:CreateTab("Misc", 4483362458),
		Info = Window:CreateTab("Info", 4483362458),
	}

	local Toggles = {
		AutoMoney = false,
		AutoFillBag = false,
		AutoPower = false,
		AutoBag = false,
		AutoRank = false,
		AutoTier = false,
		AutoMine = false,
	}

	Tabs.Main:CreateToggle({
		Name = "Auto Money",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoMoney = Value

			if Toggles.AutoMoney then
				while Toggles.AutoMoney do
					game.ReplicatedStorage.GetMoney:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	Tabs.Main:CreateToggle({
		Name = "Auto Fill Bag",
		CurrentValue = false,
		Flag = "Toggle2",
		Callback = function(Value)
			Toggles.AutoFillBag = Value

			if Toggles.AutoFillBag then
				while Toggles.AutoFillBag do
					game.ReplicatedStorage.FillMoney:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	Tabs.Main:CreateLabel("Auto Buys")
	
	Tabs.Main:CreateToggle({
		Name = "Auto Power",
		CurrentValue = false,
		Flag = "Toggle3",
		Callback = function(Value)
			Toggles.AutoPower = Value

			if Toggles.AutoPower then
				while Toggles.AutoPower do
					game.ReplicatedStorage.UpgradePower:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	Tabs.Main:CreateToggle({
		Name = "Auto Bag",
		CurrentValue = false,
		Flag = "Toggle4",
		Callback = function(Value)
			Toggles.AutoBag = Value

			if Toggles.AutoBag then
				while Toggles.AutoBag do
					game.ReplicatedStorage.UpgradeBag:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	Tabs.Main:CreateToggle({
		Name = "Auto Rank",
		CurrentValue = false,
		Flag = "Toggle5",
		Callback = function(Value)
			Toggles.AutoRank = Value

			if Toggles.AutoRank then
				while Toggles.AutoRank do
					game.ReplicatedStorage.UpgradeRank:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	Tabs.Main:CreateToggle({
		Name = "Auto Tier",
		CurrentValue = false,
		Flag = "Toggle6",
		Callback = function(Value)
			Toggles.AutoTier = Value

			if Toggles.AutoTier then
				while Toggles.AutoTier do
					game.ReplicatedStorage.TierUp:FireServer()
					wait(0.0001)
				end
			end
		end,
	})
	
	local OreNames = {
		"ALL", "Silver", "Gold", "Diamond", "Ruby", "Gem", "Uranium", "Kryptonite", "Obsidian", "Unobtainium", "Bedrock", "Pumpkin", "Gift", "Egg"
	}
	
	local SelectedOre = nil

	Tabs.Mine:CreateDropdown({
		Name = "Select Ore",
		Options = OreNames, 
		CurrentOption = "Silver",
		MultipleOptions = false,
		Flag = "Dropdown1",
		Callback = function(Options)
			local SelectedOption = type(Options) == "table" and Options[1] or Options 

			print("Selected Option: " .. tostring(SelectedOption)) 

			SelectedOre = SelectedOption

			if SelectedOre then
				print("Selected Ore: " .. SelectedOre)
			else
				print("Error: Ore not found!")
			end
		end
	})
	
	Tabs.Mine:CreateToggle({
		Name = "Auto Mine",
		CurrentValue = false,
		Flag = "Toggle7",
		Callback = function(Value)
			Toggles.AutoMine = Value

			if Toggles.AutoMine then
				while Toggles.AutoMine do
					wait(0.0001)
					local last = math.huge
					local closest = "nil"
					local hrp = player.Character.HumanoidRootPart
					for i,v in pairs(game.Workspace.Ores:GetChildren()) do
						if v:FindFirstChild("TouchIntrest") and v.Transparency < 0.81 and string.match(v.Gui.HPBar.HP.Text, '%d+') ~= "0" and not(string.find(string.lower(v.Gui.HPBar.HP.Text), "wait")) then
							if string.find(string.lower(v.Name), string.lower(SelectedOre) or SelectedOre == "ALL") then
								local mag = (hrp.Position - v.Position).magnitude
								if mag > last then
									last = mag
									closest = v
								end
							end
						end
					end
					if closest ~= "nil" then
						firetouchinterest(hrp, closest, 1)
						firetouchinterest(hrp, closest, 0)
						firetouchinterest(hrp, closest, 1)
						firetouchinterest(hrp, closest, 0)
					end
				end
			end
		end,
	})
	
	
	Tabs.Misc:CreateButton({
		Name = "Collect RainbowBucks",
		Callback = function()
			for _, buck in game.Workspace:GetChildren() do
				if string.match(buck.Name, "RainbowBuck%d+") then
					player.Character.HumanoidRootPart.CFrame = buck.CFrame + Vector3.new(0, 1, 0)
					wait(0.5)
				end
			end
		end,
	})
	
	Tabs.Misc:CreateButton({
		Name = "Redeem all Codes",
		Callback = function()
			local Codes = {
				"1millionrobloxians", -- 1.25x Money
				"typicalmoneysimulatorxcode", -- 500 Gems + 25 Research Points
				"10000", -- 1.25x money + 25 Research Points
				"freegemsplease", -- 500 Gems
				"newcode", -- 1.25x Money
				"justonebuck", -- 1.5x Money
				"rainbow colours", -- Rainbow Buck
				"omgsecretcode", -- 1.2x Money
				"dontresetmygold", -- Tier 6 Needed 2.5k Gold + 25 Diamond Crystals
				"ThanksForHalfMillionVisits", -- 1.25x Money
				"yay new layout", -- 2.5k Click Points + 25 Research Points
				"homesweethome", -- 600s Played Required 1.3x Money + 500$ + 30 Research Points
				"moneysimxawesome" -- 1.25x Money

			}
			for i = 1, 13, 1 do
				game:GetService("ReplicatedStorage").RedeemCode:FireServer(Codes[i])
				wait(0.1)
			end
		end,
	})
	
	Tabs.Misc:CreateSlider({
		Name = "WalkSpeed",
		Range = {16, 50},
		Increment = 1,
		Suffix = "WalkSpeed",
		CurrentValue = 16,
		Flag = "Slider1",
		Callback = function(Value)
			player.Character.Humanoid.WalkSpeed = Value
		end,
	})
	
	Tabs.Misc:CreateSlider({
		Name = "JumpPower",
		Range = {50, 250},
		Increment = 5,
		Suffix = "JumpPower",
		CurrentValue = 50,
		Flag = "Slider1",
		Callback = function(Value)
			player.Character.Humanoid.JumpPower = Value
		end,
	})
	

	Tabs.Info:CreateLabel("Info")
	Tabs.Info:CreateParagraph({Title = "Creator", Content = "Haakon"})
	Tabs.Info:CreateParagraph({Title = "Created/Updated", Content = "24/1/2025 | 18/3/2025"})
	Tabs.Info:CreateParagraph({Title = "Discord", Content = "haakonyt"})
end



local function setupMoneySimulator1_4_0()
	local pad = workspace:WaitForChild("SellPad")
	pad.CanCollide = false

	local Tabs = {
		Main = Window:CreateTab("Main", 4483362458),
		AutoOres = Window:CreateTab("Auto Ores", 4483362458),
		Misc = Window:CreateTab("Misc", 4483362458),
		Info = Window:CreateTab("Info", 4483362458),
	}

	local Toggles = {
		AutoMoney = false,
		AutoOre = false,
		AutoOreAll = false,
		AutoMine = false,
		AutoPackage = false,
		AutoIron = false,
		AutoGold =  false,
		AutoEvent = false,
		AutoMinigame = false,
		AntiAFK = false
	}

	local function formatNumber(n)
		local suffixes = {"", "K", "M", "B", "T", "Qa", "Qi"} -- Extend as needed
		local index = 1

		while n >= 1000 and index < #suffixes do
			n = n / 1000
			index = index + 1
		end

		return string.format("%.2f%s", n, suffixes[index])
	end

	Tabs.Main:CreateToggle({
		Name = "Auto Money",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoMoney = Value -- Update the toggle value

			if Toggles.AutoMoney then
				while Toggles.AutoMoney do
					game.ReplicatedStorage.BobuxEvent:FireServer()
					local req = 10 * 1.25 ^ game.Players.LocalPlayer.stats.Level.Value
					game.Players.LocalPlayer.PlayerGui.ScreenGui.LevelBar.Bar.Size = UDim2.new(game.Players.LocalPlayer.stats.XP.Value / req, 0, 1, 0)
					game.Players.LocalPlayer.PlayerGui.ScreenGui.LvlTxt.Text = "Level "..game.Players.LocalPlayer.stats.Level.Value.." ("..math.floor(game.Players.LocalPlayer.stats.XP.Value / req * 100).."%) "..formatNumber(game.Players.LocalPlayer.stats.XP.Value).."/"..formatNumber(req)
					game.Players.LocalPlayer.PlayerGui.ScreenGui.ClickPoints.Text = formatNumber(game.Players.LocalPlayer.stats.ClickPoints.Value)
					wait(0.0001)
				end   
			end
		end,
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Package Broken",
		CurrentValue = false,
		Flag = "Toggle2",
		Callback = function(Value)
			Toggles.AutoPackage = Value -- Update the toggle value

			if Toggles.AutoPackage then
				while Toggles.AutoPackage do
					local package = workspace:WaitForChild("CreatePackage", 5) -- Wait up to 5 seconds
					if package then
						local clickDetector = package:FindFirstChild("ClickDetector")
						if clickDetector then
							fireclickdetector(clickDetector)
						else
							warn("ClickDetector not found in CreatePackage!")
						end
					else
						warn("CreatePackage not found!")
					end
					wait(0.0001)
				end   
			end
		end
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Iron Block Broken",
		CurrentValue = false,
		Flag = "Toggle3",
		Callback = function(Value)
			Toggles.AutoIron = Value -- Update the toggle value

			if Toggles.AutoIron then
				while Toggles.AutoIron do
					local ironBlock = workspace:WaitForChild("SmeltIron", 5) -- Wait up to 5 seconds
					if ironBlock then
						local clickDetector = ironBlock:FindFirstChild("ClickDetector")
						if clickDetector then
							fireclickdetector(clickDetector)
						else
							warn("ClickDetector not found in SmeltIron!")
						end
					else
						warn("SmeltIron not found!")
					end
					wait(0.0001)
				end   
			end
		end
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Gold Block Broken",
		CurrentValue = false,
		Flag = "Toggle4",
		Callback = function(Value)
			Toggles.AutoGold = Value -- Update the toggle value

			if Toggles.AutoGold then
				while Toggles.AutoGold do
					local goldBlock = workspace:WaitForChild("CraftGold", 5) -- Wait up to 5 seconds
					if goldBlock then
						local clickDetector = goldBlock:FindFirstChild("ClickDetector")
						if clickDetector then
							fireclickdetector(clickDetector)
						else
							warn("ClickDetector not found in CraftGold!")
						end
					else
						warn("CraftGold not found!")
					end
					wait(0.0001)
				end   
			end
		end
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Event Click Broken",
		CurrentValue = false,
		Flag = "Toggle5",
		Callback = function(Value)
			Toggles.AutoEvent = Value -- Update the toggle value

			if Toggles.AutoEvent then
				while Toggles.AutoEvent do
					-- Ensure the UpgradeEvent1 and ClickDetector exist before attempting to click
					local upgradeEvent = workspace:WaitForChild("UpgradeEvent1", 5) -- Wait up to 5 seconds for the UpgradeEvent1 to appear

					if upgradeEvent then
						local clickDetector = upgradeEvent:FindFirstChild("ClickDetector")

						if clickDetector then
							-- Fire the click detector if it exists
							fireclickdetector(clickDetector)
						else
							warn("ClickDetector not found in UpgradeEvent1!")
						end
					else
						warn("UpgradeEvent1 not found!")
					end

					-- Add a small wait to avoid excessive checks
					wait(0.0001)
				end   
			end
		end
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Minigame Broken",
		CurrentValue = false,
		Flag = "Toggle6",
		Callback = function(Value)
			Toggles.AutoMinigame = Value -- Update the toggle value

			if Toggles.AutoMinigame then
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
				local originalPosition = humanoidRootPart.Position -- Store the original position

				while Toggles.AutoMinigame do
					-- Check if the minigame has already started
					local gameStarted = workspace.Minigames.SaveThePackages:FindFirstChild("Started") and workspace.Minigames.SaveThePackages.Started.Value

					if not gameStarted then
						-- Fire the event to start the minigame
						game:GetService("ReplicatedStorage").StartMinigame:FireServer("SaveThePackages")

						-- Wait a short amount of time to allow the teleport to happen
						wait(1)

						-- Teleport back to the original position after the minigame starts
						humanoidRootPart.CFrame = CFrame.new(originalPosition + Vector3.new(0, 3, 0)) -- Slight vertical offset
					else
						local originalPosition = humanoidRootPart.Position
						-- If the game has started, start clicking packages
						local packages = workspace.Minigames.SaveThePackages.Packages

						-- Continuously check for new packages and click
						for _, package in pairs(packages:GetChildren()) do
							-- Ensure the package has a ClickDetector
							if package:IsA("BasePart") and package:FindFirstChild("ClickDetector") then
								-- Fire the ClickDetector (use the way you were doing it)
								fireclickdetector(package.ClickDetector)
								print("Clicked package: " .. package.Name)

								-- Exit after clicking the first package to prevent continuous clicking
								break
							end
						end
					end

					-- Wait for a short period before checking again
					wait(0.00001)
				end   
			end
		end
	})

	local OreMapping = {
		["Crystal"] = "BobuxCrystal1",
		["Gems 1"] = "BobuxGems1",
		["Gems 2"] = "BobuxGems2",
		["Gems 3"] = "BobuxGems3",
		["Gems 4"] = "BobuxGems4",
		["Dark Bobux"] = "DarkBobux1",
		["Gold 1"] = "GoldBobux1",
		["Gold 2"] = "GoldBobux2",
		["Neon 1"] = "NeonBobux1",
		["Neon 2"] = "NeonBobux2",
		["Rainbow"] = "RainbowBobux1"
	}

	local CustomNames = {
		"Crystal",
		"Gems 1",
		"Gems 2",
		"Gems 3",
		"Gems 4",
		"Dark Bobux",
		"Gold 1",
		"Gold 2",
		"Neon 1",
		"Neon 2",
		"Rainbow"
	}

	local SelectedOre = nil

	-- Add a Dropdown to the Tab for Ore Selection
	Tabs.AutoOres:CreateDropdown({
		Name = "Select Ore",
		Options = CustomNames, -- Pass options correctly
		CurrentOption = "Rainbow", -- Must exist in `CustomNames`
		MultipleOptions = false,
		Flag = "Dropdown1",
		Callback = function(Options)
			-- If Rayfield is passing a table, extract the first value
			local SelectedOption = type(Options) == "table" and Options[1] or Options 

			print("Selected Option: " .. tostring(SelectedOption)) 

			-- Get the internal ore name based on the selected custom name
			SelectedOre = OreMapping[SelectedOption]

			if SelectedOre then
				print("Selected Ore: " .. SelectedOre)
			else
				print("Error: Ore not found!")
			end
		end
	})

	Tabs.AutoOres:CreateToggle({
		Name = "Auto Ore",
		CurrentValue = false,
		Flag = "Toggle7",
		Callback = function(Value)
			Toggles.AutoOre = Value -- Update the toggle value

			local originalPosition -- To store the player's original position

			if Toggles.AutoOre then
				-- Get player info
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

				-- Save the original position
				originalPosition = humanoidRootPart.Position

				-- Start teleport loop based on selected ore
				while Toggles.AutoOre do
					print("Teleporting to selected ore parts...")

					-- Check for existence of ores
					local oreFolder = game.Workspace:FindFirstChild("BobuxOres")
					local oreParts = oreFolder and oreFolder:FindFirstChild(SelectedOre)
					if not oreParts then
						warn(SelectedOre .. "Ores or " .. SelectedOre .. " not found!")
						break
					end

					-- Iterate through parts and teleport
					for _, part in ipairs(oreParts:GetChildren()) do
						if not Toggles.AutoOre then
							print("Toggle turned off, stopping teleportation...")
							break
						end

						if part:IsA("BasePart") then
							if part.Transparency == 1 then
								print(part.Name .. " is transparent, skipping...")
								wait(0.5) -- Wait and move to the next part
							else
								print("Teleporting to: " .. part.Name .. " at position " .. tostring(part.Position))

								-- Teleport the player to the part
								humanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0)) -- Use Position directly
								wait(1) -- Wait before teleporting to the next part
							end
						end
					end

					-- Break the outer loop if the toggle is turned off
					if not Toggles.AutoOre then
						print("Toggle turned off, exiting loop...")
						break
					end
				end

				-- After teleportation completes or toggle is disabled, teleport back to the original position
				if originalPosition then
					print("Returning to original position...")
					humanoidRootPart.CFrame = CFrame.new(originalPosition + Vector3.new(0, 3, 0)) -- Offset slightly above the original position
				end
			end
		end
	})

	Tabs.AutoOres:CreateToggle({
		Name = "Auto All Ores",
		CurrentValue = false,
		Flag = "Toggle100",
		Callback = function(Value)
			Toggles.AutoOreAll = Value -- Update the toggle value

			if Toggles.AutoOreAll then
				while Toggles.AutoOreAll do
					local oresFolder = workspace:WaitForChild("BobuxOres")
					local player = game:GetService("Players").LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					local hrp = character:WaitForChild("HumanoidRootPart") -- Ensure HRP is loaded

					if oresFolder then
						for _, ore in ipairs(oresFolder:GetDescendants()) do  -- Ensure we iterate over children
							if ore:IsA("BasePart") then  -- Only interact with BaseParts
								ore.CanCollide = false
								print("Touching: " .. ore.Name)
								firetouchinterest(ore, hrp, 0)
								task.wait(0.01) -- Small delay to ensure touch registers
								firetouchinterest(ore, hrp, 1)
							end
						end
					else
						warn("RainbowBobux1 folder not found in BobuxOres")
					end
				end   
			end
		end,
	})


	local CurrentOreLabel = Tabs.AutoOres:CreateLabel("Auto Mine Disabled", 4483362458, Color3.fromRGB(35,35,35), false) -- Title, Icon, Color, IgnoreTheme

	local function findOreWithPriority()
		local orePriority = {
			"Meteorite", "Diamond", "Platinum", "Topaz", "Sapphire", "Event Ore",
			"Opal", "Emerald", "Ruby", "Gold", "Silver", "Amethyst",
			"Copper", "Iron", "Coal", "Slate", "Stone", "Dirt", "Clay", "Grass"
		}

		-- Check if Chunk-1 exists, mine one block from Chunk-0 if necessary
		local chunk1 = workspace.BobuxQuarry:FindFirstChild("Chunk-1")
		if not chunk1 then
			local chunk0 = workspace.BobuxQuarry:FindFirstChild("Chunk0")
			if chunk0 then
				for _, selectedOre in ipairs(chunk0:GetChildren()) do
					if selectedOre:IsA("BasePart") and selectedOre.Name ~= "Bedrock" then
						local args = { [1] = selectedOre }
						game:GetService("ReplicatedStorage").MineBlock:FireServer(unpack(args))
						task.wait(0.5) -- Small delay for Chunk-1 to load
						break
					end
				end
			end
			chunk1 = workspace.BobuxQuarry:FindFirstChild("Chunk-1")
		end

		-- Helper function to find the best ore in a chunk
		local function findBestOreInChunk(chunk)
			if not chunk then
				return nil
			end

			-- Create a mapping of ore names to priority
			local orePriorityMap = {}
			for priority, oreName in ipairs(orePriority) do
				orePriorityMap[oreName] = priority
			end

			local bestOre = nil
			local bestPriority = math.huge -- Lower value indicates higher priority

			for _, ore in ipairs(chunk:GetChildren()) do
				if ore:IsA("BasePart") and ore.Name ~= "Bedrock" then
					local orePriorityValue = orePriorityMap[ore.Name]
					if orePriorityValue and orePriorityValue < bestPriority then
						bestOre = ore
						bestPriority = orePriorityValue
					end
				end
			end

			return bestOre
		end

		-- Search for the best ore in Chunk-1
		if chunk1 then
			local bestOre = findBestOreInChunk(chunk1)
			if bestOre then
				return bestOre
			end
		end

		-- If no suitable ore found in Chunk-1, search Chunk-0
		local chunk0 = workspace.BobuxQuarry:FindFirstChild("Chunk0")
		if chunk0 then
			return findBestOreInChunk(chunk0)
		end

		return nil -- No valid ore found
	end

	Tabs.AutoOres:CreateToggle({
		Name = "Auto Mine",
		CurrentValue = false,
		Flag = "Toggle8",
		Callback = function(value)
			Toggles.AutoMine = value

			-- Start the auto-mine loop when toggled on
			while Toggles.AutoMine do

				local ore = findOreWithPriority()
				if ore then
					if CurrentOreLabel and ore:FindFirstChild("Health") then
						CurrentOreLabel:Set(ore.Name .. ": " .. tostring(ore.Health.Value) .. " HP", 4483362458, Color3.fromRGB(35,35,35), false)
					else
						CurrentOreLabel:Set(ore.Name .. ": N/A HP", 4483362458, Color3.fromRGB(35,35,35), false)
					end

					local args = { [1] = ore }
					game:GetService("ReplicatedStorage").MineBlock:FireServer(unpack(args))

					local pad = workspace:WaitForChild("SellPad")
					local player = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
					local hrp = player:FindFirstChildWhichIsA("BasePart")
					firetouchinterest(pad,hrp,0)
					task.wait()
					firetouchinterest(pad,hrp,1)

				elseif CurrentOreLabel then
					CurrentOreLabel:Set("No valid ore found!", 4483362458, Color3.fromRGB(35,35,35), false)
				end

				-- Wait a short interval before the next loop
				task.wait(0.1)
			end

			-- Reset label when toggled off
			if not Toggles.AutoMine and CurrentOreLabel then
				CurrentOreLabel:Set("Auto Mine Disabled", 4483362458, Color3.fromRGB(35,35,35), false)
			end
		end
	})

	Tabs.Info:CreateLabel("Info", 4483362458, Color3.fromRGB(35,35,35), false)
	Tabs.Info:CreateParagraph({Title = "Creator", Content = "Haakon"})
	Tabs.Info:CreateParagraph({Title = "Created/Updated", Content = "24/1/2025 | 18/3/2025"})
	Tabs.Info:CreateParagraph({Title = "Discord", Content = "haakonyt"})

	loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
end



local function setupMoneySimulatorZ()
	local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

	local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
	local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
	local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

	local player = game:GetService("Players").LocalPlayer
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local events = ReplicatedStorage:WaitForChild("Events")

	--for _,v in next, getconnections(player.Idled) do 
	--	v:Disable()
	--end

	Window = Library:CreateWindow({
		Title = 'Money Simulator Z',
		Center = true,
		AutoShow = true,
		TabPadding = 8,
		MenuFadeTime = 0.2
	})

	local Tabs = {
		Factory = Window:AddTab("Factory"),
		Mining = Window:AddTab("Mining"),
		["Rune World"] = Window:AddTab("Rune World"),
		Joy = Window:AddTab("Joy"),
		Teleports = Window:AddTab("Teleports"),
		["Auto Buy"] = Window:AddTab("Auto Buy"),
		miscellaneous = Window:AddTab("Misc"),
		['UI Settings'] = Window:AddTab('UI Settings'),
	}


	for _,lockedItem in next, game:GetService("ReplicatedStorage").LockedStuff:GetChildren() do
		lockedItem.Parent = workspace
	end
	for _,v in next, workspace:GetChildren() do
		if string.match(v.Name, "Lock") then
			v:Destroy()
		end
	end
	local FactoryLeftBox = Tabs.Factory:AddLeftGroupbox('Clicking')
	local FactoryRightBox = Tabs.Factory:AddRightGroupbox('Factory Upgrades')
	local TreeLeftBox = Tabs.Factory:AddRightGroupbox('Tree')

	FactoryLeftBox:AddToggle('BoostMachines', {
		Text = 'Boost Machines',
		Default = false, 
		Tooltip = 'Automatically boosts machines for you.',

		Callback = function(Value)
			while Toggles.BoostMachines.Value do 
				wait() 
				fireclickdetector(workspace:WaitForChild("MachineBoost")["MachineBoost1"].ClickDetector)
			end
		end
	})

	FactoryLeftBox:AddToggle('BoostGems', {
		Text = 'Boost Gems',
		Default = false, 
		Tooltip = 'Automatically boosts gems for you.',

		Callback = function(Value)
			while Toggles.BoostGems.Value do 
				wait() 
				for _,v in next, game:GetService("Workspace").Factory.Gems:GetChildren() do
					fireclickdetector(v.ClickDetector)
				end
			end
		end
	})

	FactoryLeftBox:AddToggle("CollectGems", {
		Text = 'Collect Gems',
		Default = false,
		Tooltip = 'Automatically collects gems for you (no need to use if you have the research)',

		Callback = function(value)
			while Toggles.CollectGems.Value do 
				task.wait() 
				for _,v in next, game:GetService("Workspace").Factory.Gems:GetChildren() do 
					fireclickdetector(v.ClickDetector)
				end
			end 
		end
	})

	local function formatGrid()
		local grid = {}

		local gridValue = player.Stats.GemGrid.Value 

		for _,v in next, gridValue:split(":") do 
			table.insert(grid, v)
		end
		return grid
	end

	FactoryLeftBox:AddToggle('MergeGems', {
		Text = 'Merge Gems',
		Default = false, 
		Tooltip = 'Automatically merges gems for you.',

		Callback = function(Value)
			while Toggles.MergeGems.Value do 
				wait() 
				local grid = formatGrid()
				for i = 1, #grid do
					for j = i + 1, #grid do
						if i ~= j and grid[i] == grid[j] then
							events.GemGrid:FireServer(i, j)
							wait(.1)
							break
						end
					end
				end
			end
		end
	})

	TreeLeftBox:AddToggle('ClickTree', {
		Text = 'Click Tree',
		Default = false, 
		Tooltip = 'Automatically clicks the tree for you.',

		Callback = function(Value)
			while Toggles.ClickTree.Value do 
				wait() 
				events.HitTree:FireServer()
			end
		end
	})

	TreeLeftBox:AddToggle('CollectTree', {
		Text = 'Collect Tree',
		Default = false, 
		Tooltip = 'Automatically collects the money dropped from the tree for you.',

		Callback = function(Value)
			while Toggles.CollectTree.Value do 
				wait() 
				if player.Character and player.Character.PrimaryPart then
					for _,v in next, game:GetService("Workspace").Factory.TreeObjects:GetChildren() do 
						v.CanCollide = false
						v.CFrame = player.Character.HumanoidRootPart.CFrame
					end
				end
			end
		end
	})

	local function shouldPrestigeTree()
		local gain = string.gsub(string.gsub(game:GetService("Workspace").PrestigeBoard.SurfaceGui.About.PrestigeFrame.PowderGain.Text, "+", ""), ",", "")
		local unabbreviatedGain = 0
		local suffix = string.sub(gain, -1)
		local number = tonumber(string.sub(gain, 1, -2))
		if suffix == "M" then
			unabbreviatedGain = number * 1000000
		elseif suffix == "B" then
			unabbreviatedGain = number * 1000000000
		elseif suffix == "T" then
			unabbreviatedGain = number * 1000000000000
		else
			unabbreviatedGain = number
		end
		if unabbreviatedGain and getgenv().PrestigeTreePercentage and (unabbreviatedGain/player.Stats.TreePrestigePoints.Value) * 100 > getgenv().PrestigeTreePercentage then
			return true
		else
			return false
		end
	end

	function shouldRebirthTree()
		local gain = string.gsub(string.gsub(game:GetService("Workspace").TreeRebirth.RebirthBoard.SurfaceGui.About.PrestigeFrame.PowderGain.Text, "+", ""), ",", "")
		local unabbreviatedGain = 0
		local suffix = string.sub(gain, -1)
		local number = tonumber(string.sub(gain, 1, -2))
		if suffix == "M" then
			unabbreviatedGain = number * 1000000
		elseif suffix == "B" then
			unabbreviatedGain = number * 1000000000
		elseif suffix == "T" then
			unabbreviatedGain = number * 1000000000000
		else
			unabbreviatedGain = number
		end
		if unabbreviatedGain and getgenv().RebirthTreePercentage and (unabbreviatedGain/player.Stats.TreeRebirthPoints.Value) * 100 > getgenv().RebirthTreePercentage then
			return true
		else
			return false
		end
	end

	TreeLeftBox:AddToggle('PrestigeTree', {
		Text = 'Auto Prestige Tree',
		Default = false, 
		Tooltip = 'Automatically prestige the tree for you.',

		Callback = function(Value)
			while Toggles.PrestigeTree.Value do
				wait() 
				if shouldPrestigeTree() then
					events.TreePrestige:FireServer()
				end
			end
		end
	})

	prioritySlider = TreeLeftBox:AddSlider('PrestigeTreePercentage', {
		Text = 'Percentage to prestige tree',
		Default = 50,
		Min = 0,
		Max = 1000,
		Rounding = 0,
		Compact = false,
		HideMax = true, 

		Callback = function(value)
			getgenv().PrestigeTreePercentage = value
		end
	})

	TreeLeftBox:AddToggle('RebirthTree', {
		Text = 'Auto Rebirth Tree',
		Default = false, 
		Tooltip = 'Automatically rebirth the tree for you.',

		Callback = function(Value)
			while Toggles.RebirthTree.Value do
				wait() 
				if shouldRebirthTree() then
					events.TreeRebirth:FireServer()
				end
			end
		end
	})

	prioritySlider = TreeLeftBox:AddSlider('RebirthTreePercentage', {
		Text = 'Percentage to rebirth tree',
		Default = 50,
		Min = 0,
		Max = 1000,
		Rounding = 0,
		Compact = false,
		HideMax = true, 

		Callback = function(value)
			getgenv().RebirthTreePercentage = value
		end
	})


	FactoryLeftBox:AddToggle("PrestigeUpgrades", {
		Text = "Purchase Prestige Upgrades",
		Default = false,
		Tooltip = "Automatically buys prestige upgrades for you.",

		Callback = function(value)
			while Toggles.PrestigeUpgrades.Value do 
				wait(.25)
				for _,v in next, ReplicatedStorage.PrestigeData:GetChildren() do 
					if not player.Stats:FindFirstChild("PrestigeUpgrade"..v.NeedToUnlock.Value) or player.Stats:FindFirstChild("PrestigeUpgrade"..v.Name) and player.Stats["PrestigeUpgrade"..v.Name].Value < v.UpgradeLimit.Value or player.Stats["PrestigeUpgrade"..v.NeedToUnlock.Value].Value > 0 and player.Stats["PrestigeUpgrade"..v.Name].Value < v.UpgradeLimit.Value then 
						events.PrestigeUpgrade:FireServer(tonumber(v.Name), 50)
					end
				end
			end
		end
	})

	FactoryLeftBox:AddToggle("RebirthUpgrades", {
		Text = "Purchase Rebirth Upgrades",
		Default = false,
		Tooltip = "Automatically buys rebirth upgrades for you.",

		Callback = function(value)
			while Toggles.RebirthUpgrades.Value do 
				wait(.25)
				for _,v in next, ReplicatedStorage.RebirthData:GetChildren() do 
					if not player.Stats:FindFirstChild("RebirthUpgrade"..v.NeedToUnlock.Value) or player.Stats:FindFirstChild("RebirthUpgrade"..v.Name) and player.Stats["RebirthUpgrade"..v.Name].Value < v.UpgradeLimit.Value or player.Stats["RebirthUpgrade"..v.NeedToUnlock.Value].Value > 0 and player.Stats["RebirthUpgrade"..v.Name].Value < v.UpgradeLimit.Value then 
						events.RebirthUpgrade:FireServer(tonumber(v.Name), 50)
					end
				end
			end
		end
	})

	local factoryUpgradeLimits = {
		[1] = 20,
		[2] = 18,
		[3] = math.huge,
		[4] = 9,
		[5] = 20,
	}


	FactoryRightBox:AddToggle("UpgradeFactory", {
		Text = 'Upgrade Factory',
		Default = false,
		Tooltip = 'Automatically upgrades everything in the "Factory" tab.',

		Callback = function(value)
			while Toggles.UpgradeFactory.Value do 
				wait() 
				for i = 1 , 5 , 1 do 
					if player.Stats["FactoryUpgrade"..tostring(i)].Value < factoryUpgradeLimits[i] then
						events.FactoryUpgrade:FireServer(i,true)
						wait(.5)
					end
				end
			end
		end
	})

	FactoryRightBox:AddToggle("UpgradeMachines", {
		Text = 'Upgrade Machines',
		Default = false,
		Tooltip = 'Automatically upgrades all your machines.',

		Callback = function(value)
			while Toggles.UpgradeMachines.Value do 
				wait() 
				for i = 1 , 10 ,1 do 
					events.UpgradeMachine:FireServer(i,2,true)
				end 
			end
		end
	})

	FactoryRightBox:AddToggle("BuyMachines", {
		Text = 'Buy machines',
		Default = false,
		Tooltip = 'Automatically buys all machines possible.',

		Callback = function(value)
			while Toggles.BuyMachines.Value do 
				wait() 
				for i = 1 , 10 , 1 do 
					events.BuyMachine:FireServer(i,true)
					events.BuyMoreMachines:FireServer(i,2,true)
				end
				wait(.5)
			end
		end
	})



	local MiningLeftBox = Tabs.Mining:AddLeftGroupbox('Mining')
	local QuarryLeftBox = Tabs.Mining:AddLeftGroupbox('Quarry')

	local MiningRightBox = Tabs.Mining:AddRightGroupbox('Crafting')

	do
		local ores = {}
		local function getOreList()
			local stringOreList = {}

			local oreList = {}
			local sortedOres = {}

			for _,ore in next, ReplicatedStorage.OresPrices:GetChildren() do
				oreList[ore.Name] = ore.Value
				table.insert(stringOreList, ore.Name)
			end

			for oreName, _ in pairs(oreList) do
				table.insert(sortedOres, oreName)
			end

			table.sort(sortedOres, function(a, b)
				return oreList[a] < oreList[b]
			end)

			local priorityOres = {}
			for i, oreName in ipairs(sortedOres) do
				priorityOres[oreName] = i
			end

			local priorityOresStrings = {}
			local amount = 0
			for _, oreName in ipairs(sortedOres) do
				table.insert(priorityOresStrings, oreName)
				amount += 1
			end

			return priorityOres, priorityOresStrings, amount
		end
		local oreList, stringOreList, totalOres = getOreList()


		local function getDepth(position)
			return math.abs(math.floor(position.Y / 6))
		end
		if not getgenv().miningDepth then
			getgenv().miningDepth = 100
		end

		for _, child in next, workspace.MineChunks:GetChildren() do
			child.ChildAdded:Connect(function(child)
				if oreList[child.Name] then
					table.insert(ores, child)
					table.sort(ores, function(a,b)
						local priorityA = oreList[a.Name] or 0
						local priorityB = oreList[b.Name] or 0
						return priorityA > priorityB
					end)
				end
			end)
		end

		workspace.MineChunks.ChildAdded:Connect(function(child)
			wait()
			child.ChildAdded:Connect(function(child)
				if oreList[child.Name] then
					table.insert(ores, child)
					table.sort(ores, function(a,b)
						local priorityA = oreList[a.Name] or 0
						local priorityB = oreList[b.Name] or 0
						return priorityA > priorityB
					end)
				end
			end)
		end)

		local function getAllAttackableOres(ignoreStone, range, enforceDepth)
			if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
				return
			end

			local attackableOres = {}
			local distance = range or (18 + player.Stats.MiningUpgrade4.Value * 6)
			local rootPartPosition = player.Character.HumanoidRootPart.Position

			for _, chunk in ipairs(workspace.MineChunks:GetChildren()) do 
				for _, ore in ipairs(chunk:GetChildren()) do
					if ore:IsA("BasePart") and ore.Name ~= "Bedrock" and ore:FindFirstChild("Health") and ore.Health.Value > 0 then
						local orePosition = ore.Position
						local distanceToOre = (orePosition - rootPartPosition).Magnitude

						if ignoreStone then
							if oreList[ore.Name] then
								table.insert(attackableOres, ore)
							end
						else
							if distanceToOre <= distance then
								if enforceDepth then
									if getDepth(orePosition) == getgenv().miningDepth then
										table.insert(attackableOres, ore)
									end
								else
									table.insert(attackableOres, ore)
								end
							end
						end
					end
				end
			end

			if not ignoreStone and #attackableOres == 0 and range == math.huge and enforceDepth then
				local lowestY = math.huge
				local lowestOre = nil
				for _, chunk in ipairs(workspace.MineChunks:GetChildren()) do 
					for _, ore in ipairs(chunk:GetChildren()) do
						local orePosition = ore.Position
						local oreY = orePosition.Y
						if oreY < lowestY and ore.Name ~= "Bedrock" then
							lowestY = oreY
							lowestOre = ore
						end
					end
				end
				return {lowestOre}

			elseif ignoreStone and #attackableOres == 0 then
				return getAllAttackableOres(false, math.huge, enforceDepth)
			end

			return attackableOres
		end

		local function getNextMiningOre(bool, distance, rec)
			local found = false
			for _,v in next, ores do
				found = true
				break
			end
			if not found and not rec then
				ores = getAllAttackableOres(bool, distance, true)
				table.sort(ores, function(a,b)
					local priorityA = oreList[a.Name] or 0
					local priorityB = oreList[b.Name] or 0
					return priorityA > priorityB
				end)
				return getNextMiningOre(bool, distance, true)
			end
			return ores[1]
		end

		local highlight = Instance.new("Highlight")
		highlight.FillColor = Color3.new(0,255,0)
		QuarryLeftBox:AddToggle('AutoMineQuarry', {
			Text = 'Auto Mine Quarry',
			Default = false,
			Tooltip = 'Automatically mines quarry for you.',

			Callback = function(Value)
				while Toggles.AutoMineQuarry.Value do
					task.wait()
					local ore = getNextMiningOre(true, math.huge)
					if ore then
						highlight.Enabled = true
						highlight.Parent = ore
						task.spawn(function()
							repeat
								getgenv().isMiningQuarry = true
								if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
									player.Character.HumanoidRootPart.CFrame = ore.CFrame
								else
									break
								end
								task.wait()
							until not ore or not ore.Parent or not Toggles.AutoMineQuarry.Value
						end)
						if ore:FindFirstChild("Health") then
							local health = ore.Health.Value
							local t = tick()
							repeat
								game:GetService("ReplicatedStorage").Events.Mine:FireServer(ore)
								if ore:FindFirstChild("Health") then
									if ore.Health.Value ~= health then
										health = ore.Health.Value
									elseif tick() - t > 1 then
										highlight.Parent = game:GetService("CoreGui")
										highlight.Enabled = false
										ore:Destroy()
										break
									end
								end
								wait()
							until not ore.Parent or not Toggles.AutoMineQuarry.Value
							table.remove(ores, table.find(ores, ore))

							getgenv().isMiningQuarry = false
							if not Toggles.AutoMineQuarry.Value then
								break
							end
						end
					else
						player.Character.HumanoidRootPart.CFrame = CFrame.new(19.9446526, 7.64234638, 2525.29077, 0.999993265, -4.27085887e-08, -0.00367515767, 4.28989821e-08, 1, 5.17268433e-08, 0.00367515767, -5.18841539e-08, 0.999993265)
					end
				end
			end
		})

		local prioritySlider
		QuarryLeftBox:AddDropdown('MiningQuarryDropdown', {
			Values = stringOreList,
			Default = 0,
			Multi = false,

			Text = 'Ore Priority',
			Tooltip = 'Allows you to change the priority of attacking ores.',
			Callback = function(value)
				getgenv().selectedQuarryOre = value
				local priority = oreList[value] or 0
				prioritySlider:SetValue(priority)
			end
		})

		prioritySlider = QuarryLeftBox:AddSlider('MiningPriority', {
			Text = 'Priority',
			Default = 0,
			Min = 0,
			Max = totalOres,
			Rounding = 0,
			Compact = false,
			HideMax = true, 

			Callback = function(value)
				if not getgenv().selectedQuarryOre and value > 0 then
					prioritySlider:SetValue(0)
				else
					oreList[getgenv().selectedQuarryOre] = value
				end 
			end
		})


		QuarryLeftBox:AddInput('DepthTextbox', {
			Default = '100',
			Numeric = true, 
			Finished = false, 

			Text = 'Depth',
			Tooltip = 'The depth to mine at!',

			Placeholder = 'e.g 100',

			Callback = function(value)
				getgenv().miningDepth = tonumber(value)
			end
		})

		QuarryLeftBox:AddButton('Buy Crit Dmg 2 100x', function()
			game:GetService("ReplicatedStorage").Events.OreUpgrade2:FireServer(16, 100)
		end)
	end

	function getNextOre()
		local ores = {}

		for _, ore in next, workspace.Ores:GetChildren() do
			if tonumber(ore.Name) ~= 0 then
				local oreName = ore:FindFirstChild("OreName")
				if oreName and not getgenv().miningBlacklist[oreName.Value] then
					local priority = getgenv().miningPriority[oreName.Value] or 0
					table.insert(ores, {ore = ore, priority = priority})
				end
			end
		end

		table.sort(ores, function(a, b)
			return a.priority > b.priority
		end)

		if ores[1] then 
			return ores[1].ore
		else
			return false
		end
	end


	MiningLeftBox:AddToggle('AutoMine', {
		Text = 'Auto Mine',
		Default = false,
		Tooltip = 'Automatically mines rocks for you.',

		Callback = function(Value)
			while Toggles.AutoMine.Value do 
				task.wait() 
				local ore = getNextOre() 
				if ore then 
					local oldParent = ore.Parent
					events.MineOre:FireServer(tonumber(ore.Name))
					events.EnterMine:FireServer(1)
					local t = tick()
					repeat 
						task.wait() 
						if tick() - t > 1 then 
							t = tick() 
							events.MineOre:FireServer(tonumber(ore.Name))
						end
					until ore.Parent ~= oldParent or not Toggles.AutoMine.Value
				end
			end
		end
	})



	do 
		getgenv().miningBlacklist = {}
		getgenv().miningPriority = {}
		local prioritySlider
		local blacklistedToggle
		local MiningDropdown
		MiningDropdown = MiningLeftBox:AddDropdown('MiningDropdown', {
			Values = {},
			Default = 1,
			Multi = false,

			Text = 'Ore Priority',
			Tooltip = 'Allows you to change the priority of attacking ores.',
			Callback = function(value)
				getgenv().selectedOre = value 
				local priority = getgenv().miningPriority[value] or 0
				local blacklisted = getgenv().miningBlacklist[value] or false
				prioritySlider:SetValue(priority)
				blacklistedToggle:SetValue(blacklisted)
			end
		})

		prioritySlider = MiningLeftBox:AddSlider('MiningPriority', {
			Text = 'Priority',
			Default = 0,
			Min = 0,
			Max = 5,
			Rounding = 0,
			Compact = false,
			HideMax = true, 

			Callback = function(value)
				if not getgenv().selectedOre and value > 0 then
					prioritySlider:SetValue(0)
				else 
					getgenv().miningPriority[getgenv().selectedOre] = value 
				end 
			end
		})

		blacklistedToggle = MiningLeftBox:AddToggle('MiningBlacklist', {
			Text = 'Blacklist Ore',
			Default = false, 

			Callback = function(value)
				if not getgenv().selectedOre and value then 
					blacklistedToggle:SetValue(false)
				else 
					getgenv().miningBlacklist[getgenv().selectedOre] = value
				end
			end
		})

		local tree = {
			[0] = {

			},
			[1] = {
				"Coal",
				"RuneStone",
				"OreEssence"
			},
			[2] = {
				"Iron",
				"RuneStone",
				"OreEssence"
			},
			[3] = {
				"Copper",
				"RuneStone",
				"OreEssence"
			},
			[4] = {
				"Silver",
				"RuneStone",
				"OreEssence"
			},
			[5] = {
				"Gold",
				"RuneStone",
				"OreEssence"
			},
			[6] = {
				"Crystal",
				"Opal",
				"Lapis",
				"Jasper",
				"Jade",
				"Topaz",
				"RuneStone",
				"OreEssence"
			},
			[7] = {
				"Silicon",
				"RuneStone",
				"OreEssence"
			},
			[8] = {
				"Diamond",
				"RedDiamond",
				"GreenDiamond",
				"YellowDiamond",
				"BlackDiamond",
				"RuneStone",
				"OreEssence"
			},
			[9] = {
				"MegaStone",
				"RuneStone",
				"OreEssence"
			}
		}

		if game.Players.LocalPlayer.Stats.Mine.Value ~= 0 then
			MiningDropdown:SetValues(tree[game.Players.LocalPlayer.Stats.Mine.Value])
		end
		game.Players.LocalPlayer.Stats.Mine.Changed:Connect(function()
			MiningDropdown:SetValues(tree[game.Players.LocalPlayer.Stats.Mine.Value])
		end)

		MiningLeftBox:AddButton('Break Mining Animation', function()
			events.EnterMine:FireServer(1)
			repeat task.wait() until getNextOre()
			local ore = getNextOre()
			events.MineOre:FireServer(tonumber(ore.Name))
			wait()
			player.Character:BreakJoints()
			events.EnterMine:FireServer(0)
		end)

		local mineTierLabel = MiningLeftBox:AddLabel('Mine Tier: ' .. player.Stats.MineTier.Value)

		-- Auto-update the label
		game.Players.LocalPlayer.Stats.MineTier:GetPropertyChangedSignal("Value"):Connect(function()
			mineTierLabel:SetText('Mine Tier: ' .. player.Stats.MineTier.Value)
		end)
	end

	local function getCraftRequirements(itemName, amount)
		local requirements = {}

		local itemFolder = ReplicatedStorage.CraftData.CraftList:FindFirstChild(itemName)
		if not itemFolder then
			return requirements
		end

		for _, child in ipairs(itemFolder:GetChildren()) do
			if child:IsA("NumberValue") then
				requirements[child.Name] = child.Value * amount
			end
		end

		return requirements
	end

	local function topologicalSort(itemName, visited, stack, result)
		if visited[itemName] then
			return
		end

		visited[itemName] = true
		local requirements = getCraftRequirements(itemName, 1) 

		for ingredient, _ in pairs(requirements) do
			topologicalSort(ingredient, visited, stack, result)
		end

		table.insert(stack, itemName)
	end

	local function calculateCrafting(itemName, amount, result)
		local requirements = getCraftRequirements(itemName, amount)

		for ingredient, requiredAmount in pairs(requirements) do
			if ReplicatedStorage.CraftData.CraftList:FindFirstChild(ingredient) then
				calculateCrafting(ingredient, requiredAmount, result)
			end

			result[ingredient] = (result[ingredient] or 0) + requiredAmount
		end
	end

	local function getCraftingOrderAndAmount(itemName, amount)
		local result = {}
		calculateCrafting(itemName, amount, result)
		local visited = {}
		local stack = {}
		topologicalSort(itemName, visited, stack, result)

		return result, stack
	end

	function getAmount(name)
		if game.Players.LocalPlayer.Stats:FindFirstChild(name) then
			return game.Players.LocalPlayer.Stats:FindFirstChild(name).Value 
		else 
			local craftInventory = game.Players.LocalPlayer.Stats.CraftInventory.Value
			for _,v in next, craftInventory:split(":") do
				local split = v:split(">")
				local n,am = split[1], split[2]
				if n == name then 
					return tonumber(am)
				end
			end
		end
		return 0
	end

	local function craft(itemName, amount)
		local pos = player.PlayerGui.GameGui.CraftFrame.Content.CraftList.CraftList:FindFirstChild(itemName).Position
		local itemIndex = math.floor(pos.X.Scale / 0.333) + (math.floor(pos.Y.Scale / 0.1) * 3) + 1
		local ownedAmount = getAmount(itemName)
		amount = math.max(amount-ownedAmount, 0)
		if amount > 0 then
			game:GetService("ReplicatedStorage").Events.Craft:FireServer(itemIndex, amount)
		end
	end

	function getOrderedCraftingItems()
		local items = {}
		for _,item in next, ReplicatedStorage.CraftData.CraftList:GetChildren() do 
			local pos = player.PlayerGui.GameGui.CraftFrame.Content.CraftList.CraftList:FindFirstChild(item.Name).Position
			local itemIndex = math.floor(pos.X.Scale / 0.333) + (math.floor(pos.Y.Scale / 0.1) * 3) + 1
			items[itemIndex] = item.Name 
		end

		return items
	end

	MiningRightBox:AddDropdown('CraftItems', {
		Values = getOrderedCraftingItems(),
		Default = 1,
		Multi = false,

		Text = 'Select Items To Craft',
		Tooltip = 'Allows you to automatically craft everything needed for certain items.',
		Callback = function(value)
			getgenv().craftingItem = value
		end
	})


	getgenv().craftAmount = 1
	MiningRightBox:AddSlider('CraftAmount', {
		Text = 'Craft Amount', 
		Default = 1,
		Min = 1,
		Max = 1000,
		Rounding = 0,
		Compact = false,
		HideMax = true,

		Callback = function(value)
			getgenv().craftAmount = value 
		end
	})

	MiningRightBox:AddButton('Craft', function()
		local craftBlacklist = {
			["OreEssence"] = true,
			["RedDiamond"] = true,
			["ResearchPoints"] = true
		}

		local craftAmounts, craftOrder = getCraftingOrderAndAmount(getgenv().craftingItem, getgenv().craftAmount)

		pcall(function()
			for _, ingredient in ipairs(craftOrder) do
				if not rawget(craftBlacklist, ingredient) and not ReplicatedStorage.Ores:FindFirstChild(ingredient.."1") then
					craft(ingredient, craftAmounts[ingredient] + 1)
				end
			end
		end)
		craft(getgenv().craftingItem, getAmount(getgenv().craftingItem) + getgenv().craftAmount)
	end)

	local DiamondMineBox = Tabs.Mining:AddRightGroupbox('DiamondUpgs')

	DiamondMineBox:AddToggle('YellowDiamond', {
		Text = 'Yellow Diamond Upg',
		Default = false, 
		Tooltip = 'Automatically upgrades yellow diamond upgrade for you.',

		Callback = function(Value)
			while Toggles.YellowDiamond.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.RareDiamond:FireServer(1)
			end
		end
	})

	DiamondMineBox:AddToggle('GreenDiamond', {
		Text = 'Green Diamond Upg',
		Default = false, 
		Tooltip = 'Automatically upgrades green diamond upgrade for you.',

		Callback = function(Value)
			while Toggles.GreenDiamond.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.RareDiamond:FireServer(2)
			end
		end
	})

	DiamondMineBox:AddToggle('RedDiamond', {
		Text = 'Red Diamond Upg',
		Default = false, 
		Tooltip = 'Automatically upgrades red diamond upgrade for you.',

		Callback = function(Value)
			while Toggles.RedDiamond.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.RareDiamond:FireServer(3)
			end
		end
	})

	DiamondMineBox:AddToggle('BlackDiamond', {
		Text = 'Black Diamond Upg',
		Default = false, 
		Tooltip = 'Automatically upgrades black diamond upgrade for you.',

		Callback = function(Value)
			while Toggles.BlackDiamond.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.RareDiamond:FireServer(4)
			end
		end
	})

	local PickaxeMineBox = Tabs.Mining:AddRightGroupbox('PickaxeUpgs')

	PickaxeMineBox:AddToggle('PickDmgII', {
		Text = 'Pickaxe Damage 2',
		Default = false, 
		Tooltip = 'Automatically upgrades pickaxe damage 2 for you.',

		Callback = function(Value)
			while Toggles.PickDmgII.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.PickaxeUpgrade:FireServer(6)
			end
		end
	})

	PickaxeMineBox:AddToggle('RareDiamondsUpg', {
		Text = 'Rare Diamond',
		Default = false, 
		Tooltip = 'Automatically upgrades rare diamond for you.',

		Callback = function(Value)
			while Toggles.RareDiamondsUpg.Value do 
				task.wait(0.01)
				game:GetService("ReplicatedStorage").Events.PickaxeUpgrade:FireServer(9)
			end
		end
	})



	local RuneWorldRightBox = Tabs["Rune World"]:AddLeftGroupbox('Rune Auto Buys')

	RuneWorldRightBox:AddToggle('CollectRunes', {
		Text = 'Collect Runes',
		Default = false, 
		Tooltip = 'Automatically collects runes for you.',

		Callback = function(Value)
			while Toggles.CollectRunes.Value do 
				wait() 
				if player.Character and player.Character.PrimaryPart then
					for _, v in next, game:GetService("Workspace").Factory.RuneWorld:GetChildren() do
						v.CanCollide = false
						v.CFrame = player.Character.HumanoidRootPart.CFrame
					end
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('RuneUpgrade1', {
		Text = 'Auto Rune Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades rune upgrades for you.',

		Callback = function(Value)
			while Toggles.RuneUpgrade1.Value do 
				wait(0.1)
				for i = 1, 6 do
					local args = {
						[1] = i,
						[2] = true
					}
					events.CollectRuneCrystal["RuneUpgrade1"]:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('RuneUpgrade2', {
		Text = 'Auto Rune Prestige Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades rune prestige upgrades for you.',

		Callback = function(Value)
			while Toggles.RuneUpgrade2.Value do 
				wait(0.1)
				for i = 1, 4 do
					local args = {
						[1] = i,
						[2] = true
					}
					events.CollectRuneCrystal["RuneUpgrade2"]:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('RuneUpgrade3', {
		Text = 'Auto Rune Rebirth Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades rune rebirth upgrades for you.',

		Callback = function(Value)
			while Toggles.RuneUpgrade3.Value do 
				wait(0.1)
				for i = 1, 6 do
					local args = {
						[1] = i,
						[2] = true
					}
					events.CollectRuneCrystal["RuneUpgrade3"]:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('ResourceUpgrade', {
		Text = 'Auto Rune Resource Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades Resource Upgrades for you.',

		Callback = function(Value)
			while Toggles.ResourceUpgrade.Value do 
				wait(0.1)
				for i = 1, 2 do
					local args = {
						[1] = i,
					}
					game:GetService("ReplicatedStorage").Events.CollectRuneCrystal.ResourceUpgrade:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('AutoSilverUpgs', {
		Text = 'Auto Rune Silver Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades 3 Silver Upgrades for you.',

		Callback = function(Value)
			while Toggles.AutoSilverUpgs.Value do 
				wait(0.1)
				for i = 1, 3 do
					local args = {
						[1] = i,
					}
					game:GetService("ReplicatedStorage").Events.CollectRuneCrystal.SilverUpgrade:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('RuneStatsUpgrade', {
		Text = 'Auto RuneStats Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades RuneStats Upgrades for you.',

		Callback = function(Value)
			while Toggles.RuneStatsUpgrade.Value do 
				wait(0.1)
				for i = 1, 5 do
					local args = {
						[1] = i,
					}
					game:GetService("ReplicatedStorage").Events.CollectRuneCrystal.RuneStatsUpgrade:FireServer(unpack(args))
				end
			end
		end
	})

	RuneWorldRightBox:AddToggle('RunePerk', {
		Text = 'Auto Rune Perks',
		Default = false, 
		Tooltip = 'Automatically upgrades rune perks for you.',

		Callback = function(Value)
			while Toggles.RunePerk.Value do 
				wait(0.1)
				for i = 1, 4 do
					local args = {
						[1] = i,
					}
					events.CollectRuneCrystal["RunePerk"]:FireServer(unpack(args))
				end
			end
		end
	})

	local JoyLeftBox = Tabs["Joy"]:AddLeftGroupbox('Auto')

	JoyLeftBox:AddToggle('AutoJoy', {
		Text = 'Click Joy',
		Default = false, 
		Tooltip = 'Automatically gets joy for you.',

		Callback = function(Value)
			while Toggles.AutoJoy.Value do 
				wait(0.1)
				events.GetJoy:FireServer()
			end
		end
	})

	JoyLeftBox:AddToggle('JoyUpgs', {
		Text = 'Auto Joy Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades joy upgrades for you.',

		Callback = function(Value)
			while Toggles.JoyUpgs.Value do 
				wait(0.1)
				for i = 1, 4 do
					local args = {
						[1] = i,
					}
					events["JoyUpgrade"]:FireServer(unpack(args))
				end
			end
		end
	})

	JoyLeftBox:AddToggle('CoolUpgs', {
		Text = 'Auto Cool Upgrades',
		Default = false, 
		Tooltip = 'Automatically upgrades cool upgrades for you.',

		Callback = function(Value)
			while Toggles.CoolUpgs.Value do 
				wait(0.1)
				for i = 1, 3 do
					local args = {
						[1] = i,
					}
					events["CoolJoyUpgrades"]:FireServer(unpack(args))
				end
			end
		end
	})

	JoyLeftBox:AddToggle('JoyPoF', {
		Text = 'Auto Power of Friendship',
		Default = false, 
		Tooltip = 'Automatically does power of friendship for you.',

		Callback = function(Value)
			while Toggles.JoyPoF.Value do 
				wait(0.1)
				events.JoyMultiply:FireServer(1)
			end
		end
	})

	JoyLeftBox:AddToggle('JoyMine', {
		Text = 'Auto Mine Joy',
		Default = false, 
		Tooltip = 'Automatically mines joy for you.',

		Callback = function(Value)
			while Toggles.JoyMine.Value do 
				wait(0.025)
				events.JoyMine:FireServer()
			end
		end
	})

	JoyLeftBox:AddToggle('RockyUpgs', {
		Text = 'Auto Upg Rocky',
		Default = false, 
		Tooltip = 'Automatically upgrades Rocky Upgrades for you.',

		Callback = function(Value)
			while Toggles.RockyUpgs.Value do 
				wait(0.1)
				events.RockyUpgrade:FireServer(1)
			end
		end
	})

	local runestoneLabel = JoyLeftBox:AddLabel('Funny Runestone: ' .. game.Players.LocalPlayer.Stats.FunnyRunestone.Value)

	-- Auto-update the label
	game.Players.LocalPlayer.Stats.FunnyRunestone:GetPropertyChangedSignal("Value"):Connect(function()
		runestoneLabel:SetText('Funny Runestone: ' .. game.Players.LocalPlayer.Stats.FunnyRunestone.Value)
	end)





	do
		local box = Tabs.Teleports:AddLeftGroupbox('Teleports')

		box:AddButton('Factory', function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame + Vector3.new(0,2,0)
		end)

		box:AddButton('City', function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(704.513245, 7.64234734, 134.697647, 0.955939233, -4.1481659e-08, 0.293564647, 4.18234904e-08, 1, 5.11283016e-09, -0.293564647, 7.390343e-09, 0.955939233)
		end)

		box:AddButton('Mine', function()
			events.EnterMine:FireServer(1)
		end)

		box:AddButton('Exit Mine', function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(704.513245, 7.64234734, 134.697647, 0.955939233, -4.1481659e-08, 0.293564647, 4.18234904e-08, 1, 5.11283016e-09, -0.293564647, 7.390343e-09, 0.955939233)
			events.EnterMine:FireServer(0)
		end)
	end

	do 
		local leftAutoBuyGroup = Tabs["Auto Buy"]:AddLeftGroupbox('Factory')
		local rightAutoBuyGroup = Tabs["Auto Buy"]:AddRightGroupbox('Mine')
		local rightQuarryAutoBuyGroup = Tabs["Auto Buy"]:AddRightGroupbox('Quarry')

		local leftTreeAutoBuyGroup = Tabs["Auto Buy"]:AddLeftGroupbox('Tree')

		local tmp = function(aa, name)
			local arr = {}
			for _,v in next, aa:GetChildren() do 
				if v:FindFirstChild(name) then 
					table.insert(arr, v[name].Text)
				end
			end 
			return arr
		end


		leftTreeAutoBuyGroup:AddDropdown('Tree', {
			Values = tmp(game:GetService("Workspace").TreeUpgrades.SurfaceGui.UpgradesList, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Tree Upgrades',
			Tooltip = 'Automatically upgrade the tree for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.Tree.Value do 
					ind += 1 
				end
				while Options.Tree.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.Tree.Value do 
						local ind 
						for _2,v2 in next, game:GetService("Workspace").TreeUpgrades.SurfaceGui.UpgradesList:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.TreeUpgrade:FireServer(ind)
						wait(.1)
					end 
				end
			end
		})

		leftTreeAutoBuyGroup:AddDropdown('MoreTreeUpgrades', {
			Values = tmp(player.PlayerGui.GameGui.TreeUpgrades.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade More Tree Upgrades',
			Tooltip = 'Automatically upgrade the tree for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.MoreTreeUpgrades.Value do 
					ind += 1 
				end
				while Options.MoreTreeUpgrades.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.MoreTreeUpgrades.Value do 
						local ind 
						for _2,v2 in next, player.PlayerGui.GameGui.TreeUpgrades.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.MoreTreeUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftTreeAutoBuyGroup:AddDropdown('GoldTree', {
			Values = tmp(game:GetService("Workspace"):WaitForChild("GoldUpgrades").TreeUpgrades.SurfaceGui.UpgradesList, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Gold Tree Upgrades',
			Tooltip = 'Automatically upgrade the gold tree for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.GoldTree.Value do 
					ind += 1 
				end
				while Options.GoldTree.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.GoldTree.Value do 
						local ind 
						for _2,v2 in next, game:GetService("Workspace").GoldUpgrades.TreeUpgrades.SurfaceGui.UpgradesList:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.GoldTreeUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftTreeAutoBuyGroup:AddDropdown('TreePrestigeUpgrades', {
			Values = tmp(game:GetService("Workspace").TreePrestige.TreeUpgrades.SurfaceGui.UpgradesList, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Prestige Tree Upgrades',
			Tooltip = 'Automatically upgrade the tree for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.TreePrestigeUpgrades.Value do 
					ind += 1 
				end
				while Options.TreePrestigeUpgrades.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.TreePrestigeUpgrades.Value do 
						local ind 
						for _2,v2 in next, game:GetService("Workspace").TreePrestige.TreeUpgrades.SurfaceGui.UpgradesList:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.PrestigeTreeUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftTreeAutoBuyGroup:AddDropdown('RootsUpgrades', {
			Values = tmp(game:GetService("Workspace").TreeRebirthUpgrades.TreeUpgrades.SurfaceGui.UpgradesList, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Tree Root Upgrades',
			Tooltip = 'Automatically upgrade the tree roots for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.RootsUpgrades.Value do 
					ind += 1 
				end
				while Options.RootsUpgrades.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.RootsUpgrades.Value do 
						local ind 
						for _2,v2 in next, game:GetService("Workspace").TreeRebirthUpgrades.TreeUpgrades.SurfaceGui.UpgradesList:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.RebirthTreeUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftAutoBuyGroup:AddDropdown('Factory', {
			Values = tmp(game.Players.LocalPlayer.PlayerGui.GameGui.UpgradesFrame.Content.FactoryUpgrades.List, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Factory',
			Tooltip = 'Automatically upgrade the factory for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.Factory.Value do 
					ind += 1 
				end
				while Options.Factory.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.Factory.Value do 
						local ind 
						for _2,v2 in next, game.Players.LocalPlayer.PlayerGui.GameGui.UpgradesFrame.Content.FactoryUpgrades.List:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.FactoryUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftAutoBuyGroup:AddDropdown('Gems', {
			Values = tmp(game.Players.LocalPlayer.PlayerGui.GameGui.UpgradesFrame.Content.GemsFrame.List, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Gems',
			Tooltip = 'Automatically upgrade the gem upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.Gems.Value do 
					ind += 1 
				end
				while Options.Gems.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.Gems.Value do 
						local ind 
						for _2,v2 in next, game.Players.LocalPlayer.PlayerGui.GameGui.UpgradesFrame.Content.GemsFrame.List:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.GemUpgrade:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		leftAutoBuyGroup:AddDropdown('MergeGems', {
			Values = tmp(player.PlayerGui.GameGui.GridUpgrades.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Merge Gems',
			Tooltip = 'Automatically upgrade the merge gem upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.MergeGems.Value do 
					ind += 1 
				end
				while Options.MergeGems.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.MergeGems.Value do 
						local ind 
						for _2,v2 in next, player.PlayerGui.GameGui.GridUpgrades.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.UpgradeGemGrid:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		rightAutoBuyGroup:AddDropdown('OreUpgrades', {
			Values = tmp(player.PlayerGui.GameGui.OresUpgrades.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Ore Upgrades',
			Tooltip = 'Automatically upgrade the ore upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.OreUpgrades.Value do 
					ind += 1 
				end
				while Options.OreUpgrades.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.OreUpgrades.Value do 
						local ind 
						for _2,v2 in next, player.PlayerGui.GameGui.OresUpgrades.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.OreUpgrade:FireServer(ind, 999)
						wait(.4)
					end 
				end
			end
		})

		rightAutoBuyGroup:AddDropdown('RareDiamonds', {
			Values = tmp(player.PlayerGui.GameGui.RareDiamonds.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Upgrade Rare Diamonds',
			Tooltip = 'Automatically upgrade the rare diamonds upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.RareDiamonds.Value do 
					ind += 1 
				end
				while Options.RareDiamonds.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.RareDiamonds.Value do 
						local ind 
						for _2,v2 in next, player.PlayerGui.GameGui.RareDiamonds.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.RareDiamond:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

		rightQuarryAutoBuyGroup:AddDropdown('OreUpgradesII', {
			Values = tmp(player.PlayerGui.GameGui.OresUpgrades2.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Ore Upgrades II',
			Tooltip = 'Automatically upgrade the ore upgrades II upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.OreUpgradesII.Value do 
					ind += 1 
				end
				while Options.OreUpgradesII.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.OreUpgradesII.Value do 
						local ind 
						for _2,v2 in next, player.PlayerGui.GameGui.OresUpgrades2.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.OreUpgrade2:FireServer(ind, 1)
						wait(.4)
					end 
				end
			end
		})

		rightQuarryAutoBuyGroup:AddDropdown('MiningUpgreades', {
			Values = tmp(game:GetService("Players").LocalPlayer.PlayerGui.GameGui.MiningUpgrades.Content.List1, "UpgradeName"),
			Default = 0,
			Multi = true,

			Text = 'Mining Upgrades',
			Tooltip = 'Automatically upgrade the ore upgrades II upgrades for you.',
			Callback = function(value)
				local ind = 0 
				for _,v in next, Options.MiningUpgreades.Value do 
					ind += 1 
				end
				while Options.MiningUpgreades.Value == value and ind > 0 do 
					task.wait()

					for _,v in next, Options.MiningUpgreades.Value do 
						local ind 
						for _2,v2 in next, game:GetService("Players").LocalPlayer.PlayerGui.GameGui.MiningUpgrades.Content.List1:GetChildren() do 
							if v2:FindFirstChild("UpgradeName") and v2.UpgradeName.Text == _ then 
								ind = tonumber(string.split(v2.Name, "Upgrade")[2])
								break 
							end
						end 

						events.MiningUpgrades:FireServer(ind)
						wait(.4)
					end 
				end
			end
		})

	end

	do 
		local rightMiscGroup = Tabs.miscellaneous:AddRightGroupbox('Auto Ascend')

		rightMiscGroup:AddToggle('AutoAscend', {
			Text = 'Auto Ascend',
			Default = false, 
			Tooltip = 'Automatically ascends every 2 minutes.',

			Callback = function(Value)
				while Toggles.AutoAscend.Value do 
					wait(1)
					game:GetService("ReplicatedStorage").Events.Ascend:FireServer()
				end
			end
		})

		rightMiscGroup:AddButton('RedRuneStoneMoneyUpg', function()
			game:GetService("ReplicatedStorage").Events.RedRuneUpgrade:FireServer(1,100_000)
		end)

		rightMiscGroup:AddButton('BasicOreMultiUpg', function()
			game:GetService("ReplicatedStorage").Events.RedRuneUpgrade:FireServer(2,100_000)
		end)

		rightMiscGroup:AddButton('MegaEUpg', function()
			game:GetService("ReplicatedStorage").Events.RedRuneUpgrade:FireServer(4,10_000)
		end)

		local leftMiscGroup = Tabs.miscellaneous:AddLeftGroupbox('Miscellaneous')

		leftMiscGroup:AddButton('Collect Secret Bucks', function()
			local cf = player.Character.HumanoidRootPart.CFrame 
			local defs = {}
			for _,v in next, workspace.SecretBucks:GetChildren() do 
				defs[v.Name] = v.CFrame
				v.CFrame = player.Character.HumanoidRootPart.CFrame
			end
			wait()
			for _,v in next, workspace.SecretBucks:GetChildren() do 
				v.CFrame = defs[v.Name]
			end
		end)

		leftMiscGroup:AddSlider('Walkspeed', {
			Text = 'Walkspeed',
			Default = player.Character.Humanoid.WalkSpeed,
			Min = 16,
			Max = 200,
			Rounding = 0,
			Compact = false,
			HideMax = true, 

			Callback = function(value)
				while task.wait() and Options.Walkspeed.Value == value do
					if player.Character and player.Character:FindFirstChild("Humanoid") then
						player.Character.Humanoid.WalkSpeed = value
					end
				end 
			end
		})

	end 


	Library:SetWatermarkVisibility(true)

	local frameHistory = table.create(60, 0)
	local index = 0

	local function ComputeAverage()
		local average = 0

		for _, deltaTime in ipairs(frameHistory) do
			average += deltaTime
		end

		return average / 60
	end

	local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function(dt)
		index = (index + 1) % 61
		frameHistory[index] = dt

		Library:SetWatermark(('funny Script | %s fps | %s ms'):format(
			math.floor(1/ComputeAverage()),
			math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
			));
	end);

	Library.KeybindFrame.Visible = false; 

	Library:OnUnload(function()
		WatermarkConnection:Disconnect()

		print('Unloaded!')
		Library.Unloaded = true
	end)

	local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

	MenuGroup:AddButton('Unload', function() Library:Unload() end)
	MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'B', NoUI = true, Text = 'Menu keybind' })

	Library.ToggleKeybind = Options.MenuKeybind 


	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)


	SaveManager:IgnoreThemeSettings()


	SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })


	ThemeManager:SetFolder('Proton')
	SaveManager:SetFolder('Proton/Money-Simulator-Z')

	SaveManager:BuildConfigSection(Tabs['UI Settings'])

	ThemeManager:ApplyToTab(Tabs['UI Settings'])

	SaveManager:LoadAutoloadConfig()

end



local function setupMoneyClickerInc()
	local Tabs = {
		Main = Window:CreateTab("Main", 4483362458),
		AutoOres = Window:CreateTab("Auto Ores", 4483362458),
		Misc = Window:CreateTab("Misc", 4483362458),
		Info = Window:CreateTab("Info", 4483362458),
	}

	local Toggles = {
		AutoMoney = false,
		AutoGem = false,
		AutoMine = false,
		AutoLand = false,
		AutoRune = false
	}

	Tabs.Main:CreateParagraph({Title = "Info", Content = "You can only have 1 auto at a time"})

	Tabs.Main:CreateToggle({
		Name = "Auto Money",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoMoney = Value -- Update the toggle value

			if Toggles.AutoMoney then
				while Toggles.AutoMoney do
					game:GetService("ReplicatedStorage").Events.ClickMoney:FireServer()
					wait(0.0001)
				end   
			end
		end,
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Gems",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoGem = Value -- Update the toggle value

			if Toggles.AutoGem then
				while Toggles.AutoGem do	    	
					game:GetService("ReplicatedStorage").Events.ClickMoney.ClickGem:FireServer()
					wait(0.0001)
				end   
			end
		end,
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Mine",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoMine = Value -- Update the toggle value

			if Toggles.AutoMine then
				while Toggles.AutoMine do
					game:GetService("ReplicatedStorage").Events.ClickMoney.ClickMining:FireServer()
					wait(0.0001)
				end   
			end
		end,
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Land",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoLand = Value -- Update the toggle value

			if Toggles.AutoLand then
				while Toggles.AutoLand do
					game:GetService("ReplicatedStorage").Events.ClickMoney.ClickLand:FireServer()
					wait(0.0001)
				end   
			end
		end,
	})

	Tabs.Main:CreateToggle({
		Name = "Auto Rune",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoRune = Value -- Update the toggle value

			if Toggles.AutoRune then
				while Toggles.AutoRune do
					game:GetService("ReplicatedStorage").Events.ClickMoney.CreateRunestone:FireServer()
					wait(0.0001)
				end   
			end
		end,
	})



	Tabs.Info:CreateLabel("Info", 4483362458, Color3.fromRGB(35,35,35), false)
	Tabs.Info:CreateParagraph({Title = "Creator", Content = "Haakon"})
	Tabs.Info:CreateParagraph({Title = "Created/Updated", Content = "24/1/2025 | 18/3/2025"})
	Tabs.Info:CreateParagraph({Title = "Discord", Content = "haakonyt"})

	loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
end


-- Game selection
if placeId == 6628835921 then
	setupMoneySimulatorX()
elseif placeId == 6193882657 then
	setupMoneySimulator1_4_0()
elseif placeId == 14082247421 then
	setupMoneySimulatorZ()
elseif placeId == 18408132742 then
	setupMoneyClickerInc()
else
	local Tab = Window:CreateTab("Unsupported Game", 4483362458)
	Tab:CreateLabel("This game isn't supported yet.")
	Tab:CreateLabel("Contact haakonyt on discord if you want to see it added!")
end

