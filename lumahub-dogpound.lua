-- i got the bang script from infinite yield so credits to infinite yield
local url = "https://p19-comment-sign-sg.tiktokcdn.com/tos-alisg-i-zt8igodiya-sg/df667e20e84643759dd9ca98a21af1ff~tplv-jj85edgx6n-image-medium.jpeg?dr=8569&refresh_token=51c4b55c&x-expires=1781794800&x-signature=suxL1B5DHdAzoSFA7W4Ajkk9dVs%3D&t=67a6c45e&ps=a0626fcd&shp=ff37627b&shcp=ff37627b&idc=my"
local _, result = pcall(function()
	writefile("dogpound.png", game:HttpGet(url))
end)
local getcustomasset = getcustomasset or getsynasset
dp = getcustomasset("dogpound.png")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local BangSpeed = 3 -- default speed

function getRoot(chr)
	local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
	return hum and hum.RootPart
end

function getTorso(chr)
	return chr and (chr:FindFirstChild("HumanoidRootPart") or chr:FindFirstChild("Torso"))
end

function getPlayer(name)
	local list = {}
	for _, plr in pairs(Players:GetPlayers()) do
		if string.sub(string.lower(plr.Name), 1, #name) == string.lower(name) then
			table.insert(list, plr)
		end
	end
	return list
end

function r15(player)
	local hum = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
	return hum and hum.RigType == Enum.HumanoidRigType.R15
end

function Bang(speaker, args)
	local char = speaker.Character
	local hum = char and char:FindFirstChildWhichIsA("Humanoid")
	if not hum then return end

	local anim = Instance.new("Animation")
	anim.AnimationId = r15(speaker) and "rbxassetid://5918726674" or "rbxassetid://148840371"

	local track = hum:LoadAnimation(anim)
	track:Play(0.1, 1, 1)
	track:AdjustSpeed(args[2] or BangSpeed)

	local diedConn, loopConn
	diedConn = hum.Died:Connect(function()
		track:Stop()
		anim:Destroy()
		if diedConn then diedConn:Disconnect() end
		if loopConn then loopConn:Disconnect() end
	end)

	if args[1] then
		local targets = getPlayer(args[1])
		for _, plr in pairs(targets) do
			local offset = CFrame.new(0, 0, 1.1)
			loopConn = RunService.Stepped:Connect(function()
				pcall(function()
					local targetChar = plr.Character
					local targetRoot = getTorso(targetChar)
					local myRoot = getRoot(char)
					if targetRoot and myRoot then
						myRoot.CFrame = targetRoot.CFrame * offset
					end
				end)
			end)
		end
	end
end

isnetted = newcclosure(function(part) -- Needs to be a basepart
	if not part:IsA("BasePart") then return warn("Needs To be a BasePart not nil") end
	return (part.ReceiveAge == 0 and gethiddenproperty(part, "NetworkIsSleeping") == false)
end)
local Players = game:GetService("Players")
local rs = game:GetService("RunService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "luma hub | dog pound",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "by luma",
	LoadingSubtitle = "dog pound",
	ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

	-- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub"
	},

	Discord = {
		Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
		Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
		RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
	},

	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
		FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
	}
})
local Tab = Window:CreateTab("some game breakers", 4483362458) -- Title, Image
Tab:CreateButton({
	Name = "give guard weapons to all dogs",
	Callback = function()
		local MainRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Miscs"):WaitForChild("JoinTeam")
		for _, ply in ipairs(Players:GetPlayers()) do
			pcall(function() MainRemote:FireServer("Dogs", ply) end)
			pcall(function() MainRemote:FireServer("Guards", ply) end)
		end
	end,
})

Tab:CreateButton({
	Name = "turn all into dog",
	Callback = function()
		local MainRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Miscs"):WaitForChild("JoinTeam")
		for _, ply in ipairs(Players:GetPlayers()) do
			pcall(function() MainRemote:FireServer("Dogs", ply) end)
		end
	end,
})
Tab:CreateButton({
	Name = "turn all into guard",
	Callback = function()
		local MainRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Miscs"):WaitForChild("JoinTeam")
		for _, ply in ipairs(Players:GetPlayers()) do
			pcall(function() MainRemote:FireServer("Guards", ply) end)
		end
	end,
})

local InfoTab = Window:CreateTab("Credits", 4483362458)
InfoTab:CreateLabel("credits to heckman900 for some functions")
InfoTab:CreateButton({
	Name = "Copy heckman900's Channel Link",
	Callback = function() setclipboard("https://www.youtube.com/@heckman900") end,
})
InfoTab:CreateButton({
	Name = "Copy luma's Channel Link",
	Callback = function() setclipboard("https://www.youtube.com/@ADSKER-BHU-FAN") end,
})
local Tabcool = Window:CreateTab("cool", 4483362458) -- Title, Image
local Toggle = Tabcool:CreateToggle({
	Name = "Toggle noclip",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local jhf = Value
		while jhf == true do
			local lp = game.Players.LocalPlayer
			local char = lp.Character or lp.CharacterAdded:Wait()
			for i,p in pairs(char:GetChildren()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
				end
			end
			
			
			if jhf == false then
				for i,p in pairs(char:GetChildren()) do
					if p:IsA("BasePart") then
						p.CanCollide = true
						if p . Name == "HumanoidRootPart" then
							p.CanCollide = true
						end
					end
				end
				task.wait(0.1)
				break
			end
			task.wait(0.01)
		end
	end,
})
Tabcool:CreateButton({
	Name = "jump",
	Callback = function()
		local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		local rp =h.RootPart
		if h and rp then
			local err,ok = pcall(function ()
				rp.CFrame = rp.CFrame + Vector3.new(0, 10, 0)
			end)
			if err then
				local hrp=game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.CFrame = hrp.CFrame + Vector3.new(0, 10, 0)
				end
			end
		end
	end,
})
Tabcool:CreateButton({
	Name = "skydive",
	Callback = function()
		local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		local rp =h.RootPart
		if h and rp then
			local err,ok = pcall(function ()
				rp.CFrame = rp.CFrame + Vector3.new(0, 50, 0)
				local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
				hum:ChangeState(Enum.HumanoidStateType.FallingDown)
			end)
			if err then
				local hrp=game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
					local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
					hum:ChangeState(Enum.HumanoidStateType.FallingDown)
				end
			end
		end
	end,
})

function fakesaizure()
	local player = game:GetService("Players").LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	local hum = character:WaitForChild("Humanoid")
	
	local bv = Instance.new("BodyVelocity",root)
	spawn(function ()
		while root and wait(0.1) do
			hum:ChangeState(Enum.HumanoidStateType.FallingDown)
			local random = math.random(-5, 5)
			bv.Velocity = Vector3.new(random,random,random)
		end
	end)
end
Tabcool:CreateButton({
	Name = "fake seizure",
	Callback = function ()
		fakesaizure()
	end,
})

Tabcool:CreateButton({
	Name = "get some syringes",
	Callback = function()
		local player = game:GetService("Players").LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")

		local prompts = {
			workspace.Map.Vets.Important.GrowNeedleModel.ColorNeedleMain.ProximityPrompt,
			workspace.Map.Vets.Important.FireNeedleModel.ColorNeedleMain.ProximityPrompt,
			workspace.Map.Vets.Important.ShrinkNeedleModel.ColorNeedleMain.ProximityPrompt
		}

		for _, prompt in ipairs(prompts) do
			if prompt and prompt:IsA("ProximityPrompt") and prompt.Enabled then
				local part = prompt.Parent
				if part and part:IsA("BasePart") then
					root.CFrame = part.CFrame + Vector3.new(0, 0, 3)
					task.wait(0.15)

					fireproximityprompt(prompt)
					task.wait(0.25)
				end
			end
		end
	end,
})
local Slider = Tabcool:CreateSlider({
	Name = "Speed",
	Range = {0, 100},
	Increment = 10,
	Suffix = "Speed",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local lp = game:GetService("Players").LocalPlayer
		local char = lp.Character or lp.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		hum.WalkSpeed = Value
	end,
})
local Inpt = Tab:CreateInput({
	Name = "tp to plr",
	CurrentValue = "",
	PlaceholderText = "input a player's name here... (can be shortended)",
	RemoveTextAfterFocusLost = false,
	Flag = "Input1",
	Callback = function(Text)
		local player = game:GetService("Players").LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")

		-- Search for a player whose name starts with or contains the input
		local targetPlayer
		for _, ply in ipairs(game:GetService("Players"):GetPlayers()) do
			if string.lower(ply.Name):sub(1, #Text) == string.lower(Text) 
				or string.find(string.lower(ply.Name), string.lower(Text)) then
				targetPlayer = ply
				break
			end
		end

		if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			root.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
		end
	end,
})
local troll = Window:CreateTab("trolling", 4483362458)

local Input = troll:CreateInput({
	Name = "bang player",
	CurrentValue = "",
	PlaceholderText = "input a player's name here... (can be shortended)",
	RemoveTextAfterFocusLost = false,
	Flag = "Input2",
	Callback = function(Text)
		local player = game:GetService("Players").LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")

		-- Search for a player whose name starts with or contains the input
		local targetPlayer
		for _, ply in ipairs(game:GetService("Players"):GetPlayers()) do
			if string.lower(ply.Name):sub(1, #Text) == string.lower(Text) 
				or string.find(string.lower(ply.Name), string.lower(Text)) then
				targetPlayer = ply
				break
			end
		end

		if targetPlayer 
			and targetPlayer.Character 
			and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			Bang(player, {targetPlayer.Name, BangSpeed})
		else
			warn("No valid target found for Bang")
		end

	end,
})
local wenleash = Window:CreateTab("when leashed", 4483362458)
wenleash:CreateButton({
	Name = "fling high method",
	Callback = function ()
		print("it will fling you very high and try to break the leash")
		local player = game:GetService("Players").LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")
		wait(0.1)
		local bodyvel = Instance.new("BodyVelocity",root)
		bodyvel.MaxForce = Vector3.new(100000,100000,100000)
		bodyvel.Velocity = Vector3.new(0,100000,0)
	end,
})
wenleash:CreateButton({
	Name = "humanoidrootpart clear children method",
	Callback = function ()
		print("it will fling you very high and try to break the leash")
		local player = game:GetService("Players").LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local root = character:WaitForChild("HumanoidRootPart")
		root:ClearAllChildren()
	end,
})
local BangTab = Window:CreateTab("Bang Settings", dp)

local Slider = BangTab:CreateSlider({
	Name = "Bang Animation Speed",
	Range = {1, 100}, -- min and max speed
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = BangSpeed,
	Flag = "Slider2",
	Callback = function(Value)
		BangSpeed = Value
	end,
})

