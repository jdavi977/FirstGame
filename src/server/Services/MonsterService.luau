local CollectionService = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local MonsterClass = require(ServerScriptService.Server.Classes.Monster)
local PlayerService = require(ServerScriptService.Server.Services.PlayerService)
local BattleService = require(ServerScriptService.Server.Services.BattleService)

local MonsterService = {}

local activeMonsters = {}

local function moveToRandomLocation(dimensionName: string, monsterModel: Model)
	local platform = workspace[dimensionName]

	local rangeX = platform.Size.X / 2
	local rangeZ = platform.Size.Z / 2
	local rangeY = platform.Size.Y

	local randomOffset = Vector3.new(math.random(-rangeX, rangeX), rangeY, math.random(-rangeZ, rangeZ))

	monsterModel:PivotTo(platform.CFrame * CFrame.new(randomOffset))
end

local function newId()
	return tostring(math.random(100000, 999999)) .. "-" .. tostring(os.clock())
end

function MonsterService.despawn(monsterId: string)
	local monsterData = activeMonsters[monsterId]
	if monsterData then
		monsterData.model:Destroy()
		activeMonsters[monsterId] = nil
		print("Despawned monster with ID: " .. monsterId)
	end
end

function MonsterService.spawn(monsterType: string)
	local monsterState = MonsterClass.new(monsterType)
	local template = ServerStorage.MonsterModels:FindFirstChild(monsterType)

	local monsterModel = template:Clone()
	local monsterId = newId()

	activeMonsters[monsterId] = {
		state = monsterState,
		model = monsterModel,
	}

	monsterModel.Parent = workspace.Monsters
	monsterModel:SetAttribute("MonsterId", monsterId)
	CollectionService:AddTag(monsterModel, "Monster")

	local hitbox = monsterModel:FindFirstChild("Hitbox", true) or monsterModel.PrimaryPart
	assert(hitbox, "Monster model must have a Hitbox or PrimaryPart")

	hitbox.Touched:Connect(function(otherPart)
		local character = otherPart:FindFirstAncestorOfClass("Model")
		if not character then
			return
		end

		local player = game.Players:GetPlayerFromCharacter(character)
		if not player then
			return
		end

		local playerState = PlayerService.getPlayerState(player)
		if not playerState or not playerState:isAlive() then
			return
		end

		BattleService.startBattle(playerState, monsterState)
		if not monsterState:isAlive() then
			MonsterService.despawn(monsterId)
		end
	end)

	moveToRandomLocation("SpawnZone", monsterModel)
	print("Spawned monster" .. monsterType)

	return monsterId
end

function MonsterService.getMonster(monsterId: string)
	return activeMonsters[monsterId]
end

function MonsterService.startSpawner(amount: number, monsterType: { string })
	local currentCount = 0
	while currentCount < amount do
		local index = math.random(1, #monsterType)
		MonsterService.spawn(monsterType[index])
		currentCount = currentCount + 1
		task.wait(1)
	end
end

return MonsterService
