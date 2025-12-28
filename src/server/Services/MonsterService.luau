local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local MonsterClass = require(ServerScriptService.Server.Classes.Monster)

local MonsterService = {}

local function moveToRandomLocation(dimensionName, monsterModel)
	local platform = workspace[dimensionName]

	local rangeX = platform.Size.X / 2
	local rangeZ = platform.Size.Z / 2
	local rangeY = platform.Size.Y

	local randomOffset = Vector3.new(math.random(-rangeX, rangeX), rangeY, math.random(-rangeZ, rangeZ))

	monsterModel:PivotTo(platform.CFrame * CFrame.new(randomOffset))
end

function MonsterService.spawn(monsterType: string)
	local monster = MonsterClass.new(monsterType)
	local template = ServerStorage.MonsterModels:FindFirstChild(monsterType)

	local monsterModel = template:Clone()
	monsterModel.Parent = workspace.Monsters

	moveToRandomLocation("SpawnZone", monsterModel)
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
