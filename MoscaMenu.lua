local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local BatePontoRemotes = ReplicatedStorage:WaitForChild("BatePontoRemotes")
local RemoteSalario = BatePontoRemotes:WaitForChild("NotificarSalario")

local function CriarNotificacaoSalario(Texto)
	local Antiga = PlayerGui:FindFirstChild("MoscaMenuSalario")
	if Antiga then
		Antiga:Destroy()
	end

	local Gui = Instance.new("ScreenGui")
	Gui.Name = "MoscaMenuSalario"
	Gui.ResetOnSpawn = false
	Gui.IgnoreGuiInset = true
	Gui.Parent = PlayerGui

	local Caixa = Instance.new("Frame")
	Caixa.Name = "Caixa"
	Caixa.AnchorPoint = Vector2.new(0.5, 0)
	Caixa.Position = UDim2.new(0.5, 0, 0, -120)
	Caixa.Size = UDim2.new(0, 360, 0, 95)
	Caixa.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Caixa.BackgroundTransparency = 0.05
	Caixa.BorderSizePixel = 1
	Caixa.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Caixa.Parent = Gui

	local CaixaCanto = Instance.new("UICorner")
	CaixaCanto.CornerRadius = UDim.new(0, 8)
	CaixaCanto.Parent = Caixa

	local CaixaBorda = Instance.new("UIStroke")
	CaixaBorda.Color = Color3.fromRGB(150, 90, 220)
	CaixaBorda.Transparency = 0.15
	CaixaBorda.Thickness = 1.5
	CaixaBorda.Parent = Caixa

	local CaixaGradiente = Instance.new("UIGradient")
	CaixaGradiente.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(44, 44, 44)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 32, 42))
	})
	CaixaGradiente.Rotation = 90
	CaixaGradiente.Parent = Caixa

	local Sombra = Instance.new("ImageLabel")
	Sombra.Name = "SombraRoxa"
	Sombra.AnchorPoint = Vector2.new(0.5, 0.5)
	Sombra.Position = UDim2.new(0.5, 0, 0.5, 7)
	Sombra.Size = UDim2.new(1, 30, 1, 30)
	Sombra.BackgroundTransparency = 1
	Sombra.Image = "rbxassetid://1316045217"
	Sombra.ImageColor3 = Color3.fromRGB(105, 45, 180)
	Sombra.ImageTransparency = 0.55
	Sombra.ScaleType = Enum.ScaleType.Slice
	Sombra.SliceCenter = Rect.new(10, 10, 118, 118)
	Sombra.ZIndex = 0
	Sombra.Parent = Caixa

	local Topo = Instance.new("Frame")
	Topo.Name = "Topo"
	Topo.Size = UDim2.new(1, 0, 0, 28)
	Topo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Topo.BackgroundTransparency = 0.12
	Topo.BorderSizePixel = 0
	Topo.Parent = Caixa

	local TopoCanto = Instance.new("UICorner")
	TopoCanto.CornerRadius = UDim.new(0, 8)
	TopoCanto.Parent = Topo

	local Icone = Instance.new("TextLabel")
	Icone.Name = "Icone"
	Icone.Size = UDim2.new(0, 32, 1, 0)
	Icone.Position = UDim2.new(0, 5, 0, 0)
	Icone.BackgroundTransparency = 1
	Icone.Text = "🦟"
	Icone.TextColor3 = Color3.fromRGB(255, 255, 255)
	Icone.Font = Enum.Font.GothamBold
	Icone.TextSize = 18
	Icone.Parent = Topo

	local Titulo = Instance.new("TextLabel")
	Titulo.Name = "Titulo"
	Titulo.Size = UDim2.new(1, -45, 1, 0)
	Titulo.Position = UDim2.new(0, 38, 0, 0)
	Titulo.BackgroundTransparency = 1
	Titulo.Text = "MoscaMenu"
	Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
	Titulo.Font = Enum.Font.GothamBold
	Titulo.TextSize = 14
	Titulo.TextXAlignment = Enum.TextXAlignment.Left
	Titulo.Parent = Topo

	local Mensagem = Instance.new("TextLabel")
	Mensagem.Name = "Mensagem"
	Mensagem.Size = UDim2.new(1, -20, 1, -38)
	Mensagem.Position = UDim2.new(0, 10, 0, 34)
	Mensagem.BackgroundTransparency = 1
	Mensagem.Text = Texto or "MoscaMenu"
	Mensagem.TextColor3 = Color3.fromRGB(235, 235, 235)
	Mensagem.TextTransparency = 0.02
	Mensagem.Font = Enum.Font.GothamBold
	Mensagem.TextSize = 13
	Mensagem.TextWrapped = true
	Mensagem.TextXAlignment = Enum.TextXAlignment.Left
	Mensagem.TextYAlignment = Enum.TextYAlignment.Top
	Mensagem.Parent = Caixa

	Caixa:TweenPosition(
		UDim2.new(0.5, 0, 0, 35),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)

	task.delay(5, function()
		if Gui.Parent then
			Caixa:TweenPosition(
				UDim2.new(0.5, 0, 0, -120),
				Enum.EasingDirection.In,
				Enum.EasingStyle.Quad,
				0.25,
				true
			)

			task.wait(0.3)

			if Gui.Parent then
				Gui:Destroy()
			end
		end
	end)
end

RemoteSalario.OnClientEvent:Connect(function(Texto)
	CriarNotificacaoSalario(Texto or "MoscaMenu")
end)

local function NotificarSalarioTodos()
	RemoteSalario:FireServer("MoscaMenu")
end

local function TestarNotificacaoLocal()
	CriarNotificacaoSalario("MoscaMenu")
end
