local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local RemoteTimes = ReplicatedStorage:WaitForChild("TeamJoinEvent")
local BatePontoRemotes = ReplicatedStorage:WaitForChild("BatePontoRemotes")
local RemoteSalario = BatePontoRemotes:WaitForChild("NotificarSalario")

local GuiAntiga = PlayerGui:FindFirstChild("MoscaMenuGui")
if GuiAntiga then
	GuiAntiga:Destroy()
end

local NomeMapa = game.Name

local SucessoInfo, InfoMapa = pcall(function()
	return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if SucessoInfo and InfoMapa and InfoMapa.Name then
	NomeMapa = InfoMapa.Name
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoscaMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false
ScreenGui.Parent = PlayerGui

local Janela = Instance.new("Frame")
Janela.Name = "Janela"
Janela.AnchorPoint = Vector2.new(0.5, 0.5)
Janela.Position = UDim2.new(0.5, 0, 0.5, 0)
Janela.Size = UDim2.new(0, 350, 0, 250)
Janela.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Janela.BackgroundTransparency = 0.05
Janela.BorderSizePixel = 1
Janela.BorderColor3 = Color3.fromRGB(0, 0, 0)
Janela.Parent = ScreenGui

local IconeAbrir = Instance.new("TextButton")
IconeAbrir.Name = "IconeAbrir"
IconeAbrir.Size = UDim2.new(0, 38, 0, 38)
IconeAbrir.Position = UDim2.new(0, 15, 0.5, -19)
IconeAbrir.BackgroundColor3 = Color3.fromRGB(95, 55, 150)
IconeAbrir.BackgroundTransparency = 0.08
IconeAbrir.BorderSizePixel = 0
IconeAbrir.Text = "🦟"
IconeAbrir.TextColor3 = Color3.fromRGB(255, 255, 255)
IconeAbrir.Font = Enum.Font.GothamBold
IconeAbrir.TextSize = 22
IconeAbrir.Visible = false
IconeAbrir.Parent = ScreenGui

local IconeCanto = Instance.new("UICorner")
IconeCanto.CornerRadius = UDim.new(0, 8)
IconeCanto.Parent = IconeAbrir

local IconeBorda = Instance.new("UIStroke")
IconeBorda.Color = Color3.fromRGB(255, 255, 255)
IconeBorda.Transparency = 0
IconeBorda.Thickness = 1.5
IconeBorda.Parent = IconeAbrir

local IconeGradiente = Instance.new("UIGradient")
IconeGradiente.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 95, 205)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 40, 120))
})
IconeGradiente.Rotation = 90
IconeGradiente.Parent = IconeAbrir

local Sombra = Instance.new("ImageLabel")
Sombra.Name = "SombraRoxa"
Sombra.AnchorPoint = Vector2.new(0.5, 0.5)
Sombra.Position = UDim2.new(0.5, 0, 0.5, 8)
Sombra.Size = UDim2.new(1, 35, 1, 35)
Sombra.BackgroundTransparency = 1
Sombra.Image = "rbxassetid://1316045217"
Sombra.ImageColor3 = Color3.fromRGB(105, 45, 180)
Sombra.ImageTransparency = 0.55
Sombra.ScaleType = Enum.ScaleType.Slice
Sombra.SliceCenter = Rect.new(10, 10, 118, 118)
Sombra.ZIndex = 0
Sombra.Parent = Janela

local GradienteJanela = Instance.new("UIGradient")
GradienteJanela.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(32, 32, 32)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
})
GradienteJanela.Rotation = 90
GradienteJanela.Parent = Janela

local BarraTopo = Instance.new("Frame")
BarraTopo.Name = "BarraTopo"
BarraTopo.Size = UDim2.new(1, 0, 0, 32)
BarraTopo.Position = UDim2.new(0, 0, 0, 0)
BarraTopo.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BarraTopo.BackgroundTransparency = 0.15
BarraTopo.BorderSizePixel = 0
BarraTopo.Parent = Janela

local GradienteTopo = Instance.new("UIGradient")
GradienteTopo.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 60, 90)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(55, 55, 55)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
})
GradienteTopo.Rotation = 0
GradienteTopo.Parent = BarraTopo

local Titulo = Instance.new("TextLabel")
Titulo.Name = "Titulo"
Titulo.Size = UDim2.new(1, -45, 1, 0)
Titulo.Position = UDim2.new(0, 8, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "MoscaMenu"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.TextXAlignment = Enum.TextXAlignment.Left
Titulo.Parent = BarraTopo

local Fechar = Instance.new("TextButton")
Fechar.Name = "Fechar"
Fechar.Size = UDim2.new(0, 32, 1, 0)
Fechar.Position = UDim2.new(1, -34, 0, 0)
Fechar.BackgroundTransparency = 1
Fechar.Text = "X"
Fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
Fechar.Font = Enum.Font.GothamBold
Fechar.TextSize = 16
Fechar.Parent = BarraTopo

local MenuLateral = Instance.new("Frame")
MenuLateral.Name = "MenuLateral"
MenuLateral.Size = UDim2.new(0, 98, 1, -42)
MenuLateral.Position = UDim2.new(0, 6, 0, 38)
MenuLateral.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
MenuLateral.BackgroundTransparency = 0.25
MenuLateral.BorderSizePixel = 0
MenuLateral.Parent = Janela

local ListaMenu = Instance.new("UIListLayout")
ListaMenu.FillDirection = Enum.FillDirection.Vertical
ListaMenu.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListaMenu.VerticalAlignment = Enum.VerticalAlignment.Top
ListaMenu.Padding = UDim.new(0, 5)
ListaMenu.Parent = MenuLateral

local Area = Instance.new("Frame")
Area.Name = "Area"
Area.Size = UDim2.new(1, -120, 1, -50)
Area.Position = UDim2.new(0, 110, 0, 38)
Area.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Area.BackgroundTransparency = 0.2
Area.BorderSizePixel = 0
Area.Parent = Janela

Fechar.MouseButton1Click:Connect(function()
	Janela.Visible = false
	IconeAbrir.Visible = true
end)

IconeAbrir.MouseButton1Click:Connect(function()
	Janela.Visible = true
	IconeAbrir.Visible = false
end)

local Paginas = {}

local function CriarPagina(Nome, Scroll)
	local Pagina

	if Scroll then
		Pagina = Instance.new("ScrollingFrame")
		Pagina.ScrollBarThickness = 4
		Pagina.ScrollBarImageColor3 = Color3.fromRGB(130, 115, 160)
		Pagina.CanvasSize = UDim2.new(0, 0, 0, 0)
		Pagina.AutomaticCanvasSize = Enum.AutomaticSize.Y
	else
		Pagina = Instance.new("Frame")
	end

	Pagina.Name = Nome
	Pagina.Size = UDim2.new(1, -4, 1, 0)
	Pagina.Position = UDim2.new(0, 0, 0, 0)
	Pagina.BackgroundTransparency = 1
	Pagina.BorderSizePixel = 0
	Pagina.Visible = false
	Pagina.Parent = Area

	local Layout = Instance.new("UIListLayout")
	Layout.FillDirection = Enum.FillDirection.Vertical
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Layout.VerticalAlignment = Enum.VerticalAlignment.Top
	Layout.Padding = UDim.new(0, 6)
	Layout.Parent = Pagina

	local Padding = Instance.new("UIPadding")
	Padding.PaddingRight = UDim.new(0, 6)
	Padding.Parent = Pagina

	Paginas[Nome] = Pagina
	return Pagina
end

local PaginaHome = CriarPagina("Home", false)
local PaginaTimes = CriarPagina("Times", true)
local PaginaPlayer = CriarPagina("Player", true)
local PaginaTP = CriarPagina("TP", true)
local PaginaVisual = CriarPagina("Visual", true)

local function TrocarPagina(Nome)
	for NomePagina, Pagina in pairs(Paginas) do
		Pagina.Visible = NomePagina == Nome
	end
end

local function CriarBotaoMenu(Texto)
	local Botao = Instance.new("TextButton")
	Botao.Name = Texto
	Botao.Size = UDim2.new(1, -8, 0, 30)
	Botao.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Botao.BackgroundTransparency = 0.08
	Botao.BorderSizePixel = 1
	Botao.BorderColor3 = Color3.fromRGB(22, 22, 22)
	Botao.Text = Texto
	Botao.TextColor3 = Color3.fromRGB(255, 255, 255)
	Botao.Font = Enum.Font.GothamBold
	Botao.TextSize = 13
	Botao.Parent = MenuLateral

	local Gradiente = Instance.new("UIGradient")
	Gradiente.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(58, 58, 58)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 38))
	})
	Gradiente.Rotation = 90
	Gradiente.Parent = Botao

	Botao.MouseButton1Click:Connect(function()
		TrocarPagina(Texto)
	end)
end

CriarBotaoMenu("Home")
CriarBotaoMenu("Times")
CriarBotaoMenu("Player")
CriarBotaoMenu("TP")
CriarBotaoMenu("Visual")

local function AplicarGradiente(Objeto)
	local Gradiente = Instance.new("UIGradient")
	Gradiente.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(44, 44, 44)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 32, 42))
	})
	Gradiente.Rotation = 90
	Gradiente.Parent = Objeto
end

local function CriarTitulo(Parent, Texto)
	local Label = Instance.new("TextLabel")
	Label.Name = Texto
	Label.Size = UDim2.new(1, -8, 0, 32)
	Label.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Label.BackgroundTransparency = 0.08
	Label.BorderSizePixel = 1
	Label.BorderColor3 = Color3.fromRGB(18, 18, 18)
	Label.Text = Texto
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 14
	Label.Parent = Parent
	AplicarGradiente(Label)
	return Label
end

local function CriarBotao(Parent, Texto, Funcao)
	local Botao = Instance.new("TextButton")
	Botao.Name = Texto
	Botao.Size = UDim2.new(1, -8, 0, 32)
	Botao.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Botao.BackgroundTransparency = 0.08
	Botao.BorderSizePixel = 1
	Botao.BorderColor3 = Color3.fromRGB(18, 18, 18)
	Botao.Text = Texto
	Botao.TextColor3 = Color3.fromRGB(255, 255, 255)
	Botao.Font = Enum.Font.GothamBold
	Botao.TextSize = 13
	Botao.Parent = Parent
	AplicarGradiente(Botao)

	if Funcao then
		Botao.MouseButton1Click:Connect(Funcao)
	end

	return Botao
end

local Infos = Instance.new("Frame")
Infos.Name = "Infos"
Infos.Size = UDim2.new(1, -8, 0, 190)
Infos.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Infos.BackgroundTransparency = 0.08
Infos.BorderSizePixel = 1
Infos.BorderColor3 = Color3.fromRGB(18, 18, 18)
Infos.Parent = PaginaHome
AplicarGradiente(Infos)

local InfosTitulo = Instance.new("TextLabel")
InfosTitulo.Name = "Titulo"
InfosTitulo.Size = UDim2.new(1, -12, 0, 30)
InfosTitulo.Position = UDim2.new(0, 6, 0, 5)
InfosTitulo.BackgroundTransparency = 1
InfosTitulo.Text = "Infos"
InfosTitulo.TextColor3 = Color3.fromRGB(255, 255, 255)
InfosTitulo.Font = Enum.Font.GothamBold
InfosTitulo.TextSize = 15
InfosTitulo.TextXAlignment = Enum.TextXAlignment.Left
InfosTitulo.Parent = Infos

local function CriarInfo(Texto, Ordem)
	local Label = Instance.new("TextLabel")
	Label.Name = "Info"
	Label.Size = UDim2.new(1, -12, 0, 22)
	Label.Position = UDim2.new(0, 6, 0, 38 + ((Ordem - 1) * 25))
	Label.BackgroundTransparency = 1
	Label.Text = Texto
	Label.TextColor3 = Color3.fromRGB(235, 235, 235)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 12
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextWrapped = true
	Label.Parent = Infos
end

CriarInfo("Horario de criação: " .. os.date("%d/%m/%Y %H:%M:%S"), 1)
CriarInfo("Holders: Wzjay & Menddsz", 2)
CriarInfo("Mapa atual: " .. NomeMapa, 3)
CriarInfo("Id da place: " .. tostring(game.PlaceId), 4)
CriarInfo("Id do usuario: " .. tostring(Player.UserId), 5)

CriarTitulo(PaginaTimes, "Times")

local function CriarBotaoTime(Time)
	CriarBotao(PaginaTimes, Time.Name, function()
		RemoteTimes:FireServer(Time.Name)
	end)
end

local ListaTimes = Teams:GetChildren()

table.sort(ListaTimes, function(A, B)
	return A.Name < B.Name
end)

for _, Time in ipairs(ListaTimes) do
	if Time:IsA("Team") then
		CriarBotaoTime(Time)
	end
end

Teams.ChildAdded:Connect(function(Time)
	if Time:IsA("Team") then
		CriarBotaoTime(Time)
	end
end)

CriarTitulo(PaginaPlayer, "Player")

local CooldownSalario = false

CriarBotao(PaginaPlayer, "Notificar Salario Todos", function()
	if CooldownSalario then
		return
	end

	CooldownSalario = true

	pcall(function()
		RemoteSalario:FireServer("MoscaMenu")
	end)

	task.delay(3, function()
		CooldownSalario = false
	end)
end)

for i = 1, 6 do
	CriarBotao(PaginaPlayer, "Mosca Menu", nil)
end

CriarTitulo(PaginaTP, "TP")

for i = 1, 7 do
	CriarBotao(PaginaTP, "Mosca Menu", nil)
end

CriarTitulo(PaginaVisual, "Visual")

for i = 1, 7 do
	CriarBotao(PaginaVisual, "Mosca Menu", nil)
end

TrocarPagina("Home")
