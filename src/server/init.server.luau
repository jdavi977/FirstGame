local ServerScriptService = game:GetService("ServerScriptService")
local PlayerClass = require(ServerScriptService.Server.Classes.Player)

-- Gets all players joining the game
local Players = game:GetService("Players")

local function onPlayerAdded(player)
	local state = PlayerClass.new(player)

	-- We use : to call methods that have self as the first parameter
	local displayName = state:getDisplayName()
	print(displayName)

	local stats = state:getStats()
	print(stats)

	print("Damage")
	state:takeDamage(30)
	state:addXp(50)
	stats = state:getStats()
	print(stats)

	print("Level Up")
	state:addXp(50)
	stats = state:getStats()
	print(stats)
end

Players.PlayerAdded:Connect(onPlayerAdded)
