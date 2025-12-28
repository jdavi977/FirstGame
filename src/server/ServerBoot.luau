local ServerScriptService = game:GetService("ServerScriptService")
local PlayerService = require(ServerScriptService.Server.Services.PlayerService)
local MonsterService = require(ServerScriptService.Server.Services.MonsterService)
local BattleService = require(ServerScriptService.Server.Services.BattleService)

local Server = {}

function Server.start()
	print("Server is starting...")
	PlayerService.start()
	MonsterService.startSpawner(5, { "Slime", "Goblin" })
end

return Server
