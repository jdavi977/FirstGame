local ServerScriptService = game:GetService("ServerScriptService")
local MonsterClass = require(ServerScriptService.Server.Classes.Monster)

local MonsterService = {}

function MonsterService.spawn(monsterType: string)
	local monster = MonsterClass.new(monsterType)
	print("Spawned monster" .. monsterType)
	return monster
end

return MonsterService
