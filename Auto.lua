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
frame.Size=UDim2.new(0,220,0,170)
frame.Position=UDim2.new(0.5,-110,0.5,-85)
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
runButton.Position=UDim2.new(0.5,-50,0.2,-20)
runButton.BackgroundColor3=Color3.fromRGB(100,255,100)
runButton.Text="Run"
runButton.Parent=frame
local hopButton=Instance.new("TextButton")
hopButton.Size=UDim2.new(0,100,0,40)
hopButton.Position=UDim2.new(0.5,-50,0.5,-20)
hopButton.BackgroundColor3=Color3.fromRGB(255,150,50)
hopButton.Text="Hop Server"
hopButton.Parent=frame
local openGuiButton=Instance.new("TextButton")
openGuiButton.Size=UDim2.new(0,50,0,25)
openGuiButton.Position=UDim2.new(0,10,0.9,0)
openGuiButton.BackgroundColor3=Color3.fromRGB(150,150,150)
openGuiButton.Text="Open"
openGuiButton.Visible=false
openGuiButton.Active=true
openGuiButton.Parent=screenGui
closeButton.MouseButton1Click:Connect(function() pcall(function() screenGui:Destroy() end) end)
minimizeButton.MouseButton1Click:Connect(function() frame.Visible=false openGuiButton.Visible=true end)
openGuiButton.MouseButton1Click:Connect(function() frame.Visible=true openGuiButton.Visible=false end)
local function makeDraggable(gui)
local dragging,dragInput,dragStart,startPos
gui.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=true
dragStart=input.Position
startPos=gui.Position
input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragging=false end end)
end
end)
gui.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
UserInputService.InputChanged:Connect(function(input) if input==dragInput and dragging then local delta=input.Position-dragStart gui.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y) end end)
end
makeDraggable(frame)
makeDraggable(openGuiButton)
local placeId=137595477352660
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
