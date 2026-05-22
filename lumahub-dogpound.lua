-- i got the bang script from infinite yield so credits to infinite yield
local url = "https://p19-comment-sign-sg.tiktokcdn.com/tos-alisg-i-zt8igodiya-sg/df667e20e84643759dd9ca98a21af1ff~tplv-jj85edgx6n-image-medium.jpeg?dr=8569&refresh_token=51c4b55c&x-expires=1781794800&x-signature=suxL1B5DHdAzoSFA7W4Ajkk9dVs%3D&t=67a6c45e&ps=a0626fcd&shp=ff37627b&shcp=ff37627b&idc=my"
local _, result = pcall(function()
	writefile("dogpound.png", game:HttpGet(url))
end)
local ic= {}
function ic.antisit()
local hum = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
	hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

function ic.desync()
	local  lp = game:GetService("Players").LocalPlayer.Character
	local ds = lp:Clone()
	ds.HumanoidRootPart.Anchored = false
	ds.Parent = workspace
	ds.Name = "dfgkglrketlh"
	lp = ds
	local currentcamera = workspace.CurrentCamera
	currentcamera.CameraSubject = ds.Humanoid
	local lphum = lp.Humanoid
	local chum= ds.Humanoid
	lphum = chum
end
function ic.unDesync()
	local lp = game:GetService("Players").LocalPlayer.Character
	local ds = workspace.dfgkglrketlh
	local currentcamera = workspace.CurrentCamera
	ds:Destroy()
	currentcamera.CameraSubject = lp.Humanoid
local hrp = lp.HumanoidRootPart
	lp.HumanoidRootPart.Anchored = false
	local lphum = lp.Humanoid
	local chum= lp.Humanoid
	chum = lphum
end
function ESP()
for i,v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer then
			local char = v.Character
			if char then
				 local team = v.TeamColor
			
				local hh = Instance.new("Highlight")
				hh.Parent = char
				hh.FillColor = team.Color 
				hh.FillTransparency = 0.5
				hh.OutlineTransparency = 0
				hh.OutlineColor = Color3.new(1, 0, 0)
				hh.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				hh.Adornee = char
				hh.Enabled = true
			end
		end
	end
end
function RandomString(s)
	local letters = "abcdefghijklmnopqrstuvwxyz0123456789"
	local result = ""
	for i = 1, s or 10 do
		local rand = math.random(1, #letters)
		result = result .. letters:sub(rand, rand)
	end
	return result
end
local LocalPlayer = game:GetService("Players").LocalPlayer
local char = LocalPlayer.Character
local cachedPrompts = {}
local function updatePromptCache()
	cachedPrompts = {}
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("ProximityPrompt") then table.insert(cachedPrompts, v) end
	end
end
updatePromptCache()
local function fireNearby(range)
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local rootPos = char.HumanoidRootPart.Position
		for i = #cachedPrompts, 1, -1 do
			local v = cachedPrompts[i]
			if v and v.Parent then
				local parent = v.Parent
				local pos = parent:IsA("BasePart") and parent.Position or (parent:IsA("Model") and parent:GetPivot().Position)
				if pos and (rootPos - pos).Magnitude <= (range or 15) then
					fireproximityprompt(v)
				end
			else
				table.remove(cachedPrompts, i)
			end
		end
	end
end
function muzzle_nearby()
	fireNearby(15)
end
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
	anim.Name =  RandomString(10)
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
spawn(function ()
	rs.Heartbeat:Connect(function ()
		local LocalPlayer = game:GetService("Players").LocalPlayer
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
	end)
end)
function move(p)
	local player = game.Players:FindFirstChild(p)
	if player == game.Players.LocalPlayer then return end
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if not hrp then
		warn("HumanoidRootPart not found!")
		return
	end

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Anchored == false  and not obj.Parent:FindFirstChild("Humanoid") then
			obj.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			-- Disable collisions to prevent flinging
			obj.CanCollide = false
			obj.AssemblyAngularVelocity = Vector3.new(99999,99999999,99999999999)

			-- Create BodyVelocity to move part toward HRP
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			bv.Velocity = (hrp.Position - obj.Position).Unit * 50
			bv.Parent = obj

			-- Cleanup BodyVelocity after 2 seconds
			game:GetService("Debris"):AddItem(bv, 2)
		end
	end
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "luma hub | dog pound",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "by luma",
	LoadingSubtitle = "dog pound",
	ShowText = "Luma hub", -- for mobile users to unhide Rayfield, change if you'd like
	Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

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
	Name = "desync",
	Callback = function()
		ic.desync()
	end,
})
Tab:CreateButton({
	Name = "sync",
	Callback = function()
		ic.unDesync()
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
InfoTab:CreateLabel("credits to heckman900 for some functions and to enadla2")
InfoTab:CreateLabel("and enadla2 for the get some needles function (i added a new needle)")
InfoTab:CreateButton({
	Name = "Copy heckman900's Channel Link",
	Callback = function() setclipboard("https://www.youtube.com/@heckman900") end,
})
InfoTab:CreateButton({
	Name = "Copy luma's Channel Link",
	Callback = function() setclipboard("https://www.youtube.com/@ADSKER-BHU-FAN") end,
})
InfoTab:CreateButton({
	Name = "Copy enadla2's scriptblox Link",
	Callback = function() setclipboard("https://scriptblox.com/u/enadla2") end,
})

local Tabcool = Window:CreateTab("cool", 4483362458) -- Title, Image
local Toggle = Tabcool:CreateToggle({
	Name = "Toggle noclip",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local jhf = Value
		while jhf and task.wait() do
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
				
				break
			end
			
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
	Name = "esp",
	Callback = function ()
		ESP() --k
	end,
})
Tabcool:CreateButton({
	Name = "Auto Collect Items",
	Callback = function()
		local LocalPlayer = game:GetService("Players").LocalPlayer
		
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			root.CFrame = CFrame.new(-61.264, 13.620, 158.479)
			local s1 = tick() while tick() - s1 < 2 do fireNearby(25) task.wait(0.1) end
			root.CFrame = CFrame.new(-57.490, 13.538, 124.575)
			local s2 = tick() while tick() - s2 < 2 do fireNearby(25) task.wait(0.1) end
			print("done")
		end
	end,
})
local Tle = Tabcool:CreateToggle({
	Name = "Toggle cantouch",
	CurrentValue = false,
	Flag = "Toggle3", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local euh = Value
			while euh and task.wait() do
			local LP = game.Players.LocalPlayer
			for _, part in ipairs(LP.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanTouch = not euh
					part.CanQuery = not euh
				end
			end
		end
	end,
})
local erwetwete = Tabcool:CreateToggle({
	Name = "muzzle nearby toggle",
	CurrentValue = false,
	Flag = "Toggle4", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local euh = Value
		while euh and task.wait() do
			muzzle_nearby()
		end
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
			workspace.Map.Vets.Important.ShrinkNeedleModel.ColorNeedleMain.ProximityPrompt,
			workspace.Map.Vets.Important.EyeNeedleModel.ColorNeedleMain.ProximityPrompt
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
local ssssss = Tabcool:CreateSlider({
	Name = "JumpPower",
	Range = {0, 100},
	Increment = 10,
	Suffix = "Jumppower",
	CurrentValue = 10,
	Flag = "Slider1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local lp = game:GetService("Players").LocalPlayer
		local char = lp.Character or lp.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid")
		hum.JumpPower = Value
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
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Teleport to a player's HumanoidRootPart
local function tptoplr(playerhrp)
	if playerhrp then
		root.CFrame = playerhrp.CFrame
	end
end

-- Teleport to a random player (not yourself)
local function tpRandom()
	local allPlayers = Players:GetPlayers()
	if #allPlayers > 1 then
		local randomIndex
		repeat
			randomIndex = math.random(1, #allPlayers)
		until allPlayers[randomIndex] ~= LocalPlayer

		local target = allPlayers[randomIndex]
		if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			tptoplr(target.Character.HumanoidRootPart)
		end
	end
end

-- Rayfield toggle

local Toggle = Tabcool:CreateToggle({
	Name = "Teleport to random players to attack them",
	CurrentValue = false,
	Flag = "ToggleTeleport",
	Callback = function(Value)
		local active = Value
		task.spawn(function()
			while active and task.wait(0.1) do
				tpRandom()
			end
		end)
	end,
})

local Input = troll:CreateInput({
	Name = "fling player with unanchored parts",
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
			move(targetPlayer.Name)
		else
			warn("No valid target found for fling")
		end

	end,
})
troll:CreateButton({
	Name = "anti sit",
	Callback = function ()
		 ic.antisit()
	end,
})
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
-- https://p16-common-sign.tiktokcdn.com/tos-alisg-avt-0068/2eaeaed6870abb0643cfac98bbe84fce~tplv-tiktokx-cropcenter:1080:1080.jpeg?dr=14579&refresh_token=a2b67698&x-expires=1779404400&x-signature=5NnvghUD7k0RE%2FYmkXIllqAW%2FCA%3D&t=4d5b0474&ps=13740610&shp=a5d48078&shcp=81f88b70&idc=my2
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
