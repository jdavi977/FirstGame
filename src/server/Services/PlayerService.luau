local ServerScriptService = game:GetService("ServerScriptService")
local PlayerClass = require(ServerScriptService.Server.Classes.Player)

local Players = game:GetService("Players")
local PlayerService = {}
local playerStates = {}

function PlayerService.getPlayerState(player)
	return playerStates[player]
end

function PlayerService.start()
	Players.PlayerAdded:Connect(function(player)
		local state = PlayerClass.new(player)
		playerStates[player] = state
		print("Player added: " .. state:getDisplayName())
	end)

	Players.PlayerRemoving:Connect(function(player)
		playerStates[player] = nil
	end)
end

function PlayerService.death(player)
	local name = player.DisplayName
	local character = workspace[name]
	local humanoid = character:FindFirstChild("Humanoid")
	humanoid.Health = 0
end

return PlayerService
