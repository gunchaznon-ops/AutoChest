if _G.hopServer then
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local TeleportService=game:GetService("TeleportService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local player=Players.LocalPlayer
local placeId=137595477352660
local lastTeleport=0
local runActive=true
repeat wait() until workspace:FindFirstChild("UserData")
local uD=workspace.UserData:WaitForChild("User_"..player.UserId)
repeat wait() until uD:FindFirstChild("Data")
local sN=uD.Data:WaitForChild("SpawnNumber")
pcall(function()
local sEv=ReplicatedStorage:WaitForChild("Connections"):WaitForChild("Spawn")
sEv:FireServer(sN.Value)
end)
local character=player.Character or player.CharacterAdded:Wait()
local h=character:WaitForChild("HumanoidRootPart")
repeat wait() until uD:FindFirstChild("FullyLoaded") and uD.FullyLoaded.Value==true
while runActive do
local chestsFolder=workspace:FindFirstChild("Chests")
if not chestsFolder or #chestsFolder:GetChildren()==0 then
if tick()-lastTeleport>5 then lastTeleport=tick() pcall(function() TeleportService:Teleport(placeId,player) end) end
task.wait(1)
else
local startTime=tick()
for _,chest in ipairs(chestsFolder:GetChildren()) do
pcall(function()
local targetCFrame
if chest:IsA("Model") and chest.PrimaryPart then targetCFrame=chest.PrimaryPart.CFrame+Vector3.new(0,2,0)
elseif chest:IsA("BasePart") then targetCFrame=chest.CFrame+Vector3.new(0,2,0) end
if targetCFrame then
pcall(function()
local tw=TweenService:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=targetCFrame})
tw:Play() tw.Completed:Wait() task.wait(0.01)
end)
end
end)
if tick()-startTime>15 then break end
end
task.wait(0.05)
end
end
else
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local TeleportService=game:GetService("TeleportService")
local UserInputService=game:GetService("UserInputService")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local screenGui=Instance.new("ScreenGui")
screenGui.Name="AutoChest"
screenGui.Parent=playerGui
local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,220,0,150)
frame.Position=UDim2.new(0.5,-110,0.5,-75)
frame.BackgroundColor3=Color3.fromRGB(50,150,255)
frame.Active=true
frame.Draggable=false
frame.Parent=screenGui
local closeButton=Instance.new("TextButton")
closeButton.Size=UDim2.new(0,25,0,25)
closeButton.Position=UDim2.new(1,-30,0,5)
closeButton.BackgroundColor3=Color3.fromRGB(200,50,50)
closeButton.Text="X"
closeButton.Parent=frame
local runButton=Instance.new("TextButton")
runButton.Size=UDim2.new(0,100,0,40)
runButton.Position=UDim2.new(0.5,-50,0.3,-20)
runButton.BackgroundColor3=Color3.fromRGB(100,255,100)
runButton.Text="Run"
runButton.Parent=frame
local hopButton=Instance.new("TextButton")
hopButton.Size=UDim2.new(0,100,0,40)
hopButton.Position=UDim2.new(0.5,-50,0.6,-20)
hopButton.BackgroundColor3=Color3.fromRGB(255,150,50)
hopButton.Text="Hop Server"
hopButton.Parent=frame
local runActive=false
local lastTeleport=0
local function collectChests()
local character=player.Character or player.CharacterAdded:Wait()
local h=character:WaitForChild("HumanoidRootPart")
while runActive do
local chestsFolder=workspace:FindFirstChild("Chests")
if not chestsFolder or #chestsFolder:GetChildren()==0 then
if tick()-lastTeleport>5 then lastTeleport=tick() pcall(function() TeleportService:Teleport(placeId,player) end) end
task.wait(1)
else
local startTime=tick()
for _,chest in ipairs(chestsFolder:GetChildren()) do
pcall(function()
local targetCFrame
if chest:IsA("Model") and chest.PrimaryPart then targetCFrame=chest.PrimaryPart.CFrame+Vector3.new(0,2,0)
elseif chest:IsA("BasePart") then targetCFrame=chest.CFrame+Vector3.new(0,2,0) end
if targetCFrame then
pcall(function()
local tw=TweenService:Create(h,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=targetCFrame})
tw:Play() tw.Completed:Wait() task.wait(0.01)
end)
end
end)
if tick()-startTime>15 then break end
end
task.wait(0.05)
end
end
end
runButton.MouseButton1Click:Connect(function()
runActive=not runActive
if runActive then runButton.Text="Stop" spawn(collectChests) else runButton.Text="Run" end
end)
hopButton.MouseButton1Click:Connect(function() pcall(function() TeleportService:Teleport(placeId,player) end) end)
end
