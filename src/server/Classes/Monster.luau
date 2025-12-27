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

function Monster.takeDamage(self, damage)
	self.Health = math.max(self.Health - damage, 0)
end

function Monster.isAlive(self)
	return self.Health > 0
end

function Monster.getExperience(self)
	return self.ExperiencePoints
end

function Monster.attack(self, target)
	target:takeDamage(self.AttackPoints)
end

function Monster.getStats(self)
	return {
		Type = self.Type,
		Health = self.Health,
		AttackPoints = self.AttackPoints,
		ExperiencePoints = self.ExperiencePoints,
	}
end

return Monster
