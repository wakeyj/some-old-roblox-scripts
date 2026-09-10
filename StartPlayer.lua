-- super duper basic team create join script that can probably be improved but im lazyy
-- might need fixing a bit i dunno i havent tested some of this

---- options ----
local name = "wakeyj" -- your name
local colour = BrickColor.Red() -- your player colour
local ip = "127.0.0.1" -- ip to join
local port = "53640" -- port of the ip to join


---- the code i think ----

local Visit = game:service("Visit")
local Players = game:service("Players")
local NetworkClient = game:service("NetworkClient")

local function onConnectionRejected()
	game:SetMessage("This game is not available. Please try another")
end

local function onConnectionFailed(_, id, reason)
	game:SetMessage("Failed to connect to the Game. (ID=" .. id .. ", " .. reason .. ")")
end

local function onConnectionAccepted(peer, replicator)
	local worldReceiver = replicator:SendMarker()
	local received = false
	
	local function onWorldReceived()
		received = true
	end
	
	worldReceiver.Received:connect(onWorldReceived)
	game:SetMessageBrickCount()
	
	while not received do
		workspace:ZoomToExtents()
		wait(0.5)
	end
	
	game:ClearMessage()
	
	local player = Players.LocalPlayer
	local mchar = Instance.new("Model")
	local hum = Instance.new("Humanoid")
	local char = Instance.new("Part")
	
	mchar.Name = player.Name
	mchar.Parent = game.Workspace
	
	hum.Parent = mchar
	
	char.TopSurface = 0
	char.BottomSurface = 0
	char.FrontSurface = 6
	char.Shape = 0
	char.Size = Vector3.new(4, 4, 4)
	char.Locked = true
	char.CanCollide = false
	char.Anchored = true
	char.Name = "Head"
	char.BrickColor = colour
	char.Parent = mchar
	coroutine.wrap(function()
		while wait() do
			char.CFrame = game.Workspace.CurrentCamera.CoordinateFrame + (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * -3)
		end
	end)()
end

NetworkClient.ConnectionAccepted:connect(onConnectionAccepted)
NetworkClient.ConnectionRejected:connect(onConnectionRejected)
NetworkClient.ConnectionFailed:connect(onConnectionFailed)

game:SetMessage("Connecting to Server")

local success, errorMsg = pcall(function ()
	local player = Players.LocalPlayer
	
	if not player then
		player = Players:createLocalPlayer(0)
		player.Name = name
	end
	
	NetworkClient:connect(ip, port, 0)
end)

if not success then
	game:SetMessage(errorMsg)
end
