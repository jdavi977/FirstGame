local ServerScriptService = game:GetService("ServerScriptService")
local MonsterClass = require(ServerScriptService.Server.Classes.Monster)

local MonsterService = {}

function MonsterService.spawn(monsterType: string)
	local monster = MonsterClass.new(monsterType)
	print("Spawned monster" .. monsterType)
	return monster
end

function MonsterService.startSpawner(amount, monsterType)
	local currentCount = 0
	while currentCount < amount do
		local index = math.random(1, #monsterType)
		MonsterService.spawn(monsterType[index])
		currentCount = currentCount + 1
		task.wait(1)
	end
end

return MonsterService
