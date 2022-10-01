a = pcall(function() 
      if shared.GalaxyLoaded then
         error("Already loaded!")
         else
          loadstring(game:HttpGet("https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/GalaxyMain.lua"))()
       end
            print(shared.GalaxyLoaded)
end)
if not a then
   warn("Failed to load")
end
print(shared.GalaxyLoaded)
local a=syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function()end
local callback
callback = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(b)if b==Enum.TeleportState.Started then 
      if shared.GalaxyLoaded == true then
        task.spawn(function()
                  callback:Disconnect()
        end)
            error("Galaxy already loaded")
      end
      a("loadstring(game:HttpGet('https://raw.githubusercontent.com/V0rt3xqa/Galaxy/main/Loadstring.lua'))()")
end end)
