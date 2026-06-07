-------- random rbxl loading thingy ("rrlt" for short), created by wakeyjakey --------

-------- SETTINGS --------
local time = 0.4 -- time each game is loaded in minutes, i dont recommend making each game last less than around 20 seconds
local maps = { -- rbxl files to load. you may put deeper paths for a game (like "dir/game.rbxl" in this table)
    "Crossroads (Jul 2006).rbxl",
    "PilotLuke's Cloud City (October 2006).rbxl",
    "Brickyard v3 (Playable version).rbxl",
    "DrummerDude952's Place.rbxl"
}
local dir = "rbxasset://games/" -- path to your rbxl folder. make sure theres a / at the end

-------- OH BOY --------
wait(2)
math.randomseed(tick())
print("random rbxl loading thingy (rrlt) loaded! created by wakeyjakey")

function baow(num) -- no need to delete the sound or hint afterwards, game's gonna end anyway
    local hint = Instance.new("Hint")
    hint.Text = "new game in " .. tostring(num) .. " seconds!" -- change these strings if you want lmao
    hint.Parent = game.Workspace 

    local snd = Instance.new("Sound")
    snd.SoundId = "rbxasset://sounds/bass.wav" -- change this if you want lmao
    snd.Parent = game.Workspace
    snd.PlayOnRemove = true
    snd:remove() -- i have absolutely no idea why the countdown sounds dont work but im keeping it here anyway
end

while wait(0) do -- wait() just in case, probably isnt needed

wait((time * 60) - 10)
baow(10)
for i = 10, 1, -1 do
    baow(i)
    wait(1)
end

game:service('ScriptContext').ScriptsDisabled = true

for i, s in pairs(game:children()) do
    if s.className ~= "Players" and s.className ~= "NetworkServer" then
        for i, v in pairs(s:children()) do
            v:remove()
        end
    end
end
for i, plr in pairs(game.Players:children()) do
    for i, v in pairs(plr:children()) do
        if v.className ~= "Backpack" then
            v:remove()
        else
            for i, tool in pairs(v:children()) do
                tool:remove()
            end
        end
    end
end

wait(1)
local gaming = dir .. maps[math.random(#maps)]
print('loading "' .. gaming .. '"')
game:load(gaming)
game:service('ScriptContext').ScriptsDisabled = false
for i, plr in pairs(game.Players:children()) do plr:LoadCharacter() end

end