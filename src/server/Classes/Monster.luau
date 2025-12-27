local Monster = {}
local ReplicatedService = game:GetService("ReplicatedStorage")
local MonsterTemplate = require(ReplicatedService.Shared.Templates.MonsterTemplates)

Monster.__index = Monster

function Monster.new(monsterType)
	local t = MonsterTemplate[monsterType]

	-- if t is in invalid, throw an error
	assert(t, "Invalid monster type: " .. tostring(monsterType))

	local self = setmetatable({}, Monster)

	self.Type = monsterType
	self.Health = t.Health
	self.AttackPoints = t.AttackPoints
	self.ExperiencePoints = t.ExperiencePoints
	return self
end
