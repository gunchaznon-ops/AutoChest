_G.hopServer=false
local Players=game:GetService("Players")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local chestCountGui=Instance.new("ScreenGui")
chestCountGui.Name="ChestCountGUI"
chestCountGui.Parent=playerGui
local countFrame=Instance.new("Frame")
countFrame.Size=UDim2.new(0,150,0,50)
countFrame.Position=UDim2.new(0,10,0,10)
countFrame.BackgroundColor3=Color3.fromRGB(50,50,50)
countFrame.BackgroundTransparency=0.3
countFrame.BorderSizePixel=0
countFrame.Parent=chestCountGui
local countLabel=Instance.new("TextLabel")
countLabel.Size=UDim2.new(1,0,1,0)
countLabel.Position=UDim2.new(0,0,0,0)
countLabel.BackgroundTransparency=1
countLabel.TextColor3=Color3.new(1,1,1)
countLabel.TextScaled=true
countLabel.Font=Enum.Font.SourceSansBold
countLabel.Text="Chests:0"
countLabel.Parent=countFrame
local function updateChestCount()
local chestsFolder=workspace:FindFirstChild("Chests")
if chestsFolder then
countLabel.Text="Chests:"..#chestsFolder:GetChildren()
else
countLabel.Text="Chests:0"
end
end
updateChestCount()
local function connectChestEvents()
local chestsFolder=workspace:FindFirstChild("Chests")
if chestsFolder then
chestsFolder.ChildAdded:Connect(updateChestCount)
chestsFolder.ChildRemoved:Connect(updateChestCount)
end
end
connectChestEvents()
if _G.hopServer then
local p=game:GetService("Players").LocalPlayer
local tS=game:GetService("TweenService")
local tP=game:GetService("TeleportService")
local rS=game:GetService("ReplicatedStorage")
local sEv=rS:WaitForChild("Connections"):WaitForChild("Spawn")
local placeId=137595477352660
repeat wait() until workspace:FindFirstChild("UserData")
local uD=workspace.UserData:WaitForChild("User_"..p.UserId)
repeat wait() until uD:FindFirstChild("Data")
local sN=uD.Data:WaitForChild("SpawnNumber")
sEv:FireServer(sN.Value)
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("HumanoidRootPart")
repeat wait() until uD:FindFirstChild("FullyLoaded") and uD.FullyLoaded.Value==true
local startTime=tick()
while true do
local chestsFolder=workspace:FindFirstChild("Chests")
if not chestsFolder then break end
local chests=chestsFolder:GetChildren()
if #chests==0 then break end
for _,ch in ipairs(chests) do
pcall(function()
local targetCFrame
if ch:IsA("Model") and ch.PrimaryPart then
targetCFrame=ch.PrimaryPart.CFrame+Vector3.new(0,2,0)
elseif ch:IsA("BasePart") then
targetCFrame=ch.CFrame+Vector3.new(0,2,0)
end
if targetCFrame then
local tw=tS:Create(h,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=targetCFrame})
tw:Play()tw.Completed:Wait()task.wait(0.1)
end
end)
if tick()-startTime>15 then break end
end
if tick()-startTime>15 or #chests==0 then break end
wait(0.05)
end
local Players=game:GetService("Players")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local screenGui=Instance.new("ScreenGui")
screenGui.Name="BlackScreenCountdown"
screenGui.Parent=playerGui
local blackFrame=Instance.new("Frame")
blackFrame.Size=UDim2.new(1,0,1,0)
blackFrame.Position=UDim2.new(0,0,0,0)
blackFrame.BackgroundColor3=Color3.new(0,0,0)
blackFrame.BackgroundTransparency=0
blackFrame.Parent=screenGui
local countdownLabel=Instance.new("TextLabel")
countdownLabel.Size=UDim2.new(1,0,1,0)
countdownLabel.Position=UDim2.new(0,0,0,0)
countdownLabel.BackgroundTransparency=1
countdownLabel.TextColor3=Color3.new(1,1,1)
countdownLabel.TextScaled=true
countdownLabel.Font=Enum.Font.SourceSansBold
countdownLabel.Text="5"
countdownLabel.Parent=blackFrame
for i=5,0,-1 do
countdownLabel.Text=tostring(i)
task.wait(1)
end
tP:Teleport(placeId,p)
else
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local TeleportService=game:GetService("TeleportService")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local screenGui=Instance.new("ScreenGui")
screenGui.Name="AutoChest"
screenGui.Parent=playerGui
local frame=Instance.new("Frame")
frame.Size=UDim2.new(0,250,0,150)
frame.Position=UDim2.new(0.5,-125,0.5,-60)
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
local minimizeButton=Instance.new("TextButton")
minimizeButton.Size=UDim2.new(0,25,0,25)
minimizeButton.Position=UDim2.new(1,-60,0,5)
minimizeButton.BackgroundColor3=Color3.fromRGB(255,200,50)
minimizeButton.Text="-"
minimizeButton.Parent=frame
local runButton=Instance.new("TextButton")
runButton.Size=UDim2.new(0,100,0,40)
runButton.Position=UDim2.new(0.5,-50,0.5,-30)
runButton.BackgroundColor3=Color3.fromRGB(100,255,100)
runButton.Text="Run"
runButton.Parent=frame
local hopserver=Instance.new("TextButton")
hopserver.Size=UDim2.new(0,100,0,40)
hopserver.Position=UDim2.new(0.5,-50,0.5,15)
hopserver.BackgroundColor3=Color3.fromRGB(100,255,100)
hopserver.Text="Hopserver"
hopserver.Parent=frame
local openGuiButton=Instance.new("TextButton")
openGuiButton.Size=UDim2.new(0,80,0,55)
openGuiButton.Position=UDim2.new(0,100,0.1,0)
openGuiButton.BackgroundColor3=Color3.fromRGB(150,150,150)
openGuiButton.Text="Open"
openGuiButton.Visible=false
openGuiButton.Active=true
openGuiButton.Parent=screenGui
closeButton.MouseButton1Click:Connect(function()screenGui:Destroy()end)
minimizeButton.MouseButton1Click:Connect(function()frame.Visible=false openGuiButton.Visible=true end)
openGuiButton.MouseButton1Click:Connect(function()frame.Visible=true openGuiButton.Visible=false end)
local function makeDraggable(gui)
local dragging,dragInput,dragStart,startPos
gui.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
dragStart=input.Position
startPos=gui.Position
input.Changed:Connect(function()
if input.UserInputState==Enum.UserInputState.End then dragging=false end
end)
end
end)
gui.InputChanged:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end
end)
UserInputService.InputChanged:Connect(function(input)
if input==dragInput and dragging then
local delta=input.Position-dragStart
gui.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)
end
makeDraggable(frame)
makeDraggable(openGuiButton)
local placeId=137595477352660
local runStopTF=false
runButton.MouseButton1Click:Connect(function()
if runStopTF==false then
runStopTF=true
runButton.Text="Stop"
local character=player.Character or player.CharacterAdded:Wait()
local humanoidRootPart=character:WaitForChild("HumanoidRootPart")
local chestsFolder=workspace:WaitForChild("Chests")
spawn(function()
while runStopTF do
local chests=chestsFolder:GetChildren()
if #chests==0 then break end
for _,chest in ipairs(chests) do
if not runStopTF then break end
pcall(function()
local targetCFrame
if chest:IsA("Model") and chest.PrimaryPart then
targetCFrame=chest.PrimaryPart.CFrame+Vector3.new(0,2,0)
elseif chest:IsA("BasePart") then
targetCFrame=chest.CFrame+Vector3.new(0,2,0)
end
if targetCFrame then
local tween=TweenService:Create(humanoidRootPart,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{CFrame=targetCFrame})
tween:Play()
tween.Completed:Wait()
task.wait(0.1)
end
end)
end
task.wait(0.1)
end
runStopTF=false
runButton.Text="Run"
end)
else
runStopTF=false
runButton.Text="Run"
end
end)
local tP=game:GetService("TeleportService")
hopserver.MouseButton1Click:Connect(function()
local Players=game:GetService("Players")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
local screenGui=Instance.new("ScreenGui")
screenGui.Name="BlackScreenCountdown"
screenGui.Parent=playerGui
local blackFrame=Instance.new("Frame")
blackFrame.Size=UDim2.new(1,0,1,0)
blackFrame.Position=UDim2.new(0,0,0,0)
blackFrame.BackgroundColor3=Color3.new(0,0,0)
blackFrame.BackgroundTransparency=0
blackFrame.Parent=screenGui
local countdownLabel=Instance.new("TextLabel")
countdownLabel.Size=UDim2.new(1,0,1,0)
countdownLabel.Position=UDim2.new(0,0,0,0)
countdownLabel.BackgroundTransparency=1
countdownLabel.TextColor3=Color3.new(1,1,1)
countdownLabel.TextScaled=true
countdownLabel.Font=Enum.Font.SourceSansBold
countdownLabel.Text="5"
countdownLabel.Parent=blackFrame
for i=5,0,-1 do
countdownLabel.Text=tostring(i)
task.wait(1)
end
tP:Teleport(placeId,p)
end)
end
