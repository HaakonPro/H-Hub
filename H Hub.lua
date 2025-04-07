local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local placeId = game.PlaceId

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
		Info = Window:CreateTab("Info", 4483362458),
	}

	local Toggles = {
		AutoMoney = false,
	}

	Tabs.Main:CreateToggle({
		Name = "Auto Money",
		CurrentValue = false,
		Flag = "Toggle1",
		Callback = function(Value)
			Toggles.AutoMoney = Value

			if Toggles.AutoMoney then
				while Toggles.AutoMoney do
					game.ReplicatedStorage.BobuxEvent:FireServer()
					wait(0.0001)
				end
			end
		end,
	})

	Tabs.Info:CreateLabel("Info")
	Tabs.Info:CreateParagraph({Title = "Creator", Content = "Haakon"})
	Tabs.Info:CreateParagraph({Title = "Created/Updated", Content = "24/1/2025 | 18/3/2025"})
	Tabs.Info:CreateParagraph({Title = "Discord", Content = "haakonyt"})
end



-- Game selection
if placeId == 66288359212 then
	setupMoneySimulatorX()
elseif placeId == 6193882657 then
	setupMoneySimulator1_4_0()
else
	local Tab = Window:CreateTab("Unsupported Game", 4483362458)
	Tab:CreateLabel("This game isn't supported yet.")
	Tab:CreateLabel("Contact haakonyt on discord if you want to see it added!")
end

