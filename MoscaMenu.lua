local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()

local NomeGuiMenu = "MoscaMenuGui"

-- SISTEMA DE TEMA
local TemaAtual = "Escuro"
local CoresCinza = {
	Fundo = Color3.fromRGB(25, 25, 25),
	FundoSecundario = Color3.fromRGB(45, 45, 45),
	FundoMenuLateral = Color3.fromRGB(32, 32, 32),
	FundoArea = Color3.fromRGB(28, 28, 28),
	Texto = Color3.fromRGB(255, 255, 255),
	TextoSecundario = Color3.fromRGB(235, 235, 235),
	TextoDesativado = Color3.fromRGB(160, 160, 160),
	Borda = Color3.fromRGB(0, 0, 0),
	BordaBotao = Color3.fromRGB(18, 18, 18),
	Sombra = Color3.fromRGB(105, 45, 180)
}

local CoresClaro = {
	Fundo = Color3.fromRGB(240, 240, 245),
	FundoSecundario = Color3.fromRGB(220, 220, 230),
	FundoMenuLateral = Color3.fromRGB(210, 210, 225),
	FundoArea = Color3.fromRGB(230, 230, 240),
	Texto = Color3.fromRGB(30, 30, 50),
	TextoSecundario = Color3.fromRGB(50, 50, 70),
	TextoDesativado = Color3.fromRGB(120, 120, 140),
	Borda = Color3.fromRGB(200, 200, 220),
	BordaBotao = Color3.fromRGB(180, 180, 200),
	Sombra = Color3.fromRGB(150, 120, 200)
}

local CoresCoresAtualmente = CoresCinza

-- AutoDrive
local AutoDriveAtivo = false
local VeiculoAtualAtivo = nil
local UltimaDestinacao = nil

local function TelaDeCarregamentoAtiva()
	for _, Gui in ipairs(PlayerGui:GetChildren()) do
		if Gui:IsA("ScreenGui") then
			local Nome = string.lower(Gui.Name)

			if Nome == "loadingscreen"
				or Nome == "loading"
				or Nome == "carregamento"
				or Nome == "telacarregamento" then

				if Gui.Enabled then
					return true
				end
			end
		end
	end

	return false
end

local function DestruirMenuSeExistir()
	local Gui = PlayerGui:FindFirstChild(NomeGuiMenu)

	if Gui then
		Gui:Destroy()
	end
end

while TelaDeCarregamentoAtiva() do
	DestruirMenuSeExistir()
	task.wait(0.5)
end

PlayerGui.ChildAdded:Connect(function()
	task.wait(0.1)

	if TelaDeCarregamentoAtiva() then
		DestruirMenuSeExistir()
	end
end)

local RemoteTimes = ReplicatedStorage:FindFirstChild("TeamJoinEvent")

local BatePontoRemotes = ReplicatedStorage:FindFirstChild("BatePontoRemotes")
local RemoteSalario = nil

if BatePontoRemotes then
	RemoteSalario = BatePontoRemotes:FindFirstChild("NotificarSalario")
end

local Gerador = ReplicatedStorage:FindFirstChild("Gerador")
local CoinEvent = nil
local ToolEvent = nil
local VeiculosEvent = nil
local AnuncioEvent = nil

if Gerador then
	CoinEvent = Gerador:FindFirstChild("CoinEvent")
	ToolEvent = Gerador:FindFirstChild("ToolEvent")
	VeiculosEvent = Gerador:FindFirstChild("VeiculosEvent")
	AnuncioEvent = Gerador:FindFirstChild("AnuncioEvent")
end

DestruirMenuSeExistir()

local NomeMapa = game.Name

local SucessoInfo, InfoMapa = pcall(function()
	return MarketplaceService:GetProductInfo(game.PlaceId)
end)

if SucessoInfo and InfoMapa and InfoMapa.Name then
	NomeMapa = InfoMapa.Name
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = NomeGuiMenu
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false
ScreenGui.Parent = PlayerGui

local Janela = Instance.new("Frame")
Janela.Name = "Janela"
Janela.AnchorPoint = Vector2.new(0.5, 0.5)
Janela.Position = UDim2.new(0.5, 0, 0.5, 0)
Janela.Size = UDim2.new(0, 350, 0, 250)
Janela.BackgroundColor3 = CoresCoresAtualmente.Fundo
Janela.BackgroundTransparency = 0.05
Janela.BorderSizePixel = 1
Janela.BorderColor3 = CoresCoresAtualmente.Borda
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
BarraTopo.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
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
Titulo.TextColor3 = CoresCoresAtualmente.Texto
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
Fechar.TextColor3 = CoresCoresAtualmente.Texto
Fechar.Font = Enum.Font.GothamBold
Fechar.TextSize = 16
Fechar.Parent = BarraTopo

local MenuLateral = Instance.new("Frame")
MenuLateral.Name = "MenuLateral"
MenuLateral.Size = UDim2.new(0, 98, 1, -42)
MenuLateral.Position = UDim2.new(0, 6, 0, 38)
MenuLateral.BackgroundColor3 = CoresCoresAtualmente.FundoMenuLateral
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
Area.BackgroundColor3 = CoresCoresAtualmente.FundoArea
Area.BackgroundTransparency = 0.2
Area.BorderSizePixel = 0
Area.Parent = Janela

Fechar.MouseButton1Click:Connect(function()
	Janela.Visible = false
	IconeAbrir.Visible = true
end)

IconeAbrir.MouseButton1Click:Connect(function()
	if TelaDeCarregamentoAtiva() then
		DestruirMenuSeExistir()
		return
	end

	Janela.Visible = true
	IconeAbrir.Visible = false
end)

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
	Caixa.Position = UDim2.new(0.5, 0, 0, 35)
	Caixa.Size = UDim2.new(0, 360, 0, 95)
	Caixa.BackgroundColor3 = CoresCoresAtualmente.Fundo
	Caixa.BackgroundTransparency = 0.05
	Caixa.BorderSizePixel = 1
	Caixa.BorderColor3 = CoresCoresAtualmente.Borda
	Caixa.Parent = Gui

	local Canto = Instance.new("UICorner")
	Canto.CornerRadius = UDim.new(0, 8)
	Canto.Parent = Caixa

	local Borda = Instance.new("UIStroke")
	Borda.Color = Color3.fromRGB(150, 90, 220)
	Borda.Transparency = 0.15
	Borda.Thickness = 1.5
	Borda.Parent = Caixa

	local SombraNotificacao = Instance.new("ImageLabel")
	SombraNotificacao.Name = "SombraRoxa"
	SombraNotificacao.AnchorPoint = Vector2.new(0.5, 0.5)
	SombraNotificacao.Position = UDim2.new(0.5, 0, 0.5, 7)
	SombraNotificacao.Size = UDim2.new(1, 30, 1, 30)
	SombraNotificacao.BackgroundTransparency = 1
	SombraNotificacao.Image = "rbxassetid://1316045217"
	SombraNotificacao.ImageColor3 = CoresCoresAtualmente.Sombra
	SombraNotificacao.ImageTransparency = 0.55
	SombraNotificacao.ScaleType = Enum.ScaleType.Slice
	SombraNotificacao.SliceCenter = Rect.new(10, 10, 118, 118)
	SombraNotificacao.ZIndex = 0
	SombraNotificacao.Parent = Caixa

	AplicarGradiente(Caixa)

	local Topo = Instance.new("Frame")
	Topo.Name = "Topo"
	Topo.Size = UDim2.new(1, 0, 0, 28)
	Topo.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
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
	Icone.TextColor3 = CoresCoresAtualmente.Texto
	Icone.Font = Enum.Font.GothamBold
	Icone.TextSize = 18
	Icone.Parent = Topo

	local TituloNotificacao = Instance.new("TextLabel")
	TituloNotificacao.Name = "Titulo"
	TituloNotificacao.Size = UDim2.new(1, -45, 1, 0)
	TituloNotificacao.Position = UDim2.new(0, 38, 0, 0)
	TituloNotificacao.BackgroundTransparency = 1
	TituloNotificacao.Text = "MoscaMenu"
	TituloNotificacao.TextColor3 = CoresCoresAtualmente.Texto
	TituloNotificacao.Font = Enum.Font.GothamBold
	TituloNotificacao.TextSize = 14
	TituloNotificacao.TextXAlignment = Enum.TextXAlignment.Left
	TituloNotificacao.Parent = Topo

	local Mensagem = Instance.new("TextLabel")
	Mensagem.Name = "Mensagem"
	Mensagem.Size = UDim2.new(1, -20, 1, -38)
	Mensagem.Position = UDim2.new(0, 10, 0, 34)
	Mensagem.BackgroundTransparency = 1
	Mensagem.Text = Texto or "MoscaMenu"
	Mensagem.TextColor3 = CoresCoresAtualmente.TextoSecundario
	Mensagem.TextTransparency = 0.02
	Mensagem.Font = Enum.Font.GothamBold
	Mensagem.TextSize = 13
	Mensagem.TextWrapped = true
	Mensagem.TextXAlignment = Enum.TextXAlignment.Left
	Mensagem.TextYAlignment = Enum.TextYAlignment.Top
	Mensagem.Parent = Caixa

	Caixa.Position = UDim2.new(0.5, 0, 0, -120)

	Caixa:TweenPosition(
		UDim2.new(0.5, 0, 0, 35),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.25,
		true
	)

	task.delay(5, function()
		if Gui and Gui.Parent then
			Caixa:TweenPosition(
				UDim2.new(0.5, 0, 0, -120),
				Enum.EasingDirection.In,
				Enum.EasingStyle.Quad,
				0.25,
				true
			)

			task.wait(0.3)

			if Gui and Gui.Parent then
				Gui:Destroy()
			end
		end
	end)
end

if RemoteSalario then
	RemoteSalario.OnClientEvent:Connect(function(...)
		local Argumentos = {...}
		local TextoFinal = "MoscaMenu"

		if typeof(Argumentos[1]) == "string" and Argumentos[1] ~= "" then
			TextoFinal = Argumentos[1]
		elseif typeof(Argumentos[2]) == "string" and Argumentos[2] ~= "" then
			TextoFinal = Argumentos[2]
		end

		CriarNotificacaoSalario(TextoFinal)
	end)
end

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
local PaginaKeys = CriarPagina("Keys", true)
local PaginaVeiculos = CriarPagina("Veiculos", true)

local function TrocarPagina(Nome)
	if TelaDeCarregamentoAtiva() then
		DestruirMenuSeExistir()
		return
	end

	for NomePagina, Pagina in pairs(Paginas) do
		Pagina.Visible = NomePagina == Nome
	end
end

local function CriarBotaoMenu(Texto)
	local Botao = Instance.new("TextButton")
	Botao.Name = Texto
	Botao.Size = UDim2.new(1, -8, 0, 30)
	Botao.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
	Botao.BackgroundTransparency = 0.08
	Botao.BorderSizePixel = 1
	Botao.BorderColor3 = CoresCoresAtualmente.BordaBotao
	Botao.Text = Texto
	Botao.TextColor3 = CoresCoresAtualmente.Texto
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
CriarBotaoMenu("Keys")
CriarBotaoMenu("Veiculos")

local function CriarTitulo(Parent, Texto)
	local Label = Instance.new("TextLabel")
	Label.Name = Texto
	Label.Size = UDim2.new(1, -8, 0, 32)
	Label.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
	Label.BackgroundTransparency = 0.08
	Label.BorderSizePixel = 1
	Label.BorderColor3 = CoresCoresAtualmente.BordaBotao
	Label.Text = Texto
	Label.TextColor3 = CoresCoresAtualmente.Texto
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
	Botao.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
	Botao.BackgroundTransparency = 0.08
	Botao.BorderSizePixel = 1
	Botao.BorderColor3 = CoresCoresAtualmente.BordaBotao
	Botao.Text = Texto
	Botao.TextColor3 = CoresCoresAtualmente.Texto
	Botao.Font = Enum.Font.GothamBold
	Botao.TextSize = 13
	Botao.Parent = Parent
	AplicarGradiente(Botao)

	if Funcao then
		Botao.MouseButton1Click:Connect(Funcao)
	end

	return Botao
end

local function CriarCaixa(Parent, Nome, Placeholder)
	local Caixa = Instance.new("TextBox")
	Caixa.Name = Nome
	Caixa.Size = UDim2.new(1, -8, 0, 32)
	Caixa.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
	Caixa.BackgroundTransparency = 0.08
	Caixa.BorderSizePixel = 1
	Caixa.BorderColor3 = CoresCoresAtualmente.BordaBotao
	Caixa.Text = ""
	Caixa.PlaceholderText = Placeholder
	Caixa.TextColor3 = CoresCoresAtualmente.Texto
	Caixa.PlaceholderColor3 = CoresCoresAtualmente.TextoDesativado
	Caixa.Font = Enum.Font.GothamBold
	Caixa.TextSize = 12
	Caixa.ClearTextOnFocus = false
	Caixa.Parent = Parent
	AplicarGradiente(Caixa)

	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 8)
	Padding.PaddingRight = UDim.new(0, 8)
	Padding.Parent = Caixa

	return Caixa
end

-- FUNÇÃO PARA ALTERAR TEMA
local function AlterarTema(NovoTema)
	if NovoTema == TemaAtual then
		return
	end

	TemaAtual = NovoTema
	if NovoTema == "Claro" then
		CoresCoresAtualmente = CoresClaro
	else
		CoresCoresAtualmente = CoresCinza
	end

	-- Atualizar cores da janela
	Janela.BackgroundColor3 = CoresCoresAtualmente.Fundo
	Janela.BorderColor3 = CoresCoresAtualmente.Borda
	
	BarraTopo.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
	Titulo.TextColor3 = CoresCoresAtualmente.Texto
	Fechar.TextColor3 = CoresCoresAtualmente.Texto
	
	MenuLateral.BackgroundColor3 = CoresCoresAtualmente.FundoMenuLateral
	Area.BackgroundColor3 = CoresCoresAtualmente.FundoArea

	-- Atualizar todos os títulos
	for _, child in ipairs(PaginaHome:GetChildren()) do
		if child:IsA("TextLabel") or child:IsA("TextButton") then
			child.TextColor3 = CoresCoresAtualmente.Texto
			child.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
			child.BorderColor3 = CoresCoresAtualmente.BordaBotao
		end
	end

	for _, pagina in pairs(Paginas) do
		if pagina ~= PaginaHome then
			for _, child in ipairs(pagina:GetChildren()) do
				if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
					child.TextColor3 = CoresCoresAtualmente.Texto
					child.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
					child.BorderColor3 = CoresCoresAtualmente.BordaBotao
					if child:IsA("TextBox") then
						child.PlaceholderColor3 = CoresCoresAtualmente.TextoDesativado
					end
				end
			end
		end
	end

	-- Atualizar botões do menu lateral
	for _, botao in ipairs(MenuLateral:GetChildren()) do
		if botao:IsA("TextButton") then
			botao.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
			botao.BorderColor3 = CoresCoresAtualmente.BordaBotao
			botao.TextColor3 = CoresCoresAtualmente.Texto
		end
	end

	CriarNotificacaoSalario("Tema alterado para: " .. NovoTema)
end

local Infos = Instance.new("Frame")
Infos.Name = "Infos"
Infos.Size = UDim2.new(1, -8, 0, 190)
Infos.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
Infos.BackgroundTransparency = 0.08
Infos.BorderSizePixel = 1
Infos.BorderColor3 = CoresCoresAtualmente.BordaBotao
Infos.Parent = PaginaHome
AplicarGradiente(Infos)

local InfosTitulo = Instance.new("TextLabel")
InfosTitulo.Name = "Titulo"
InfosTitulo.Size = UDim2.new(1, -12, 0, 30)
InfosTitulo.Position = UDim2.new(0, 6, 0, 5)
InfosTitulo.BackgroundTransparency = 1
InfosTitulo.Text = "Infos"
InfosTitulo.TextColor3 = CoresCoresAtualmente.Texto
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
	Label.TextColor3 = CoresCoresAtualmente.TextoSecundario
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

-- ADICIONAR BOTÕES DE TEMA NA HOME
CriarBotao(PaginaHome, "Tema Claro", function()
	AlterarTema("Claro")
end)

CriarBotao(PaginaHome, "Tema Escuro", function()
	AlterarTema("Escuro")
end)

CriarTitulo(PaginaTimes, "Times")

local function CriarBotaoTime(Time)
	CriarBotao(PaginaTimes, Time.Name, function()
		if RemoteTimes then
			RemoteTimes:FireServer(Time.Name)
		end
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

	if not RemoteSalario then
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

CriarTitulo(PaginaKeys, "Keys")

local TipoKey = CriarCaixa(PaginaKeys, "TipoKey", "Tipo: Coins, Tool ou Veiculo")
local ValorKey = CriarCaixa(PaginaKeys, "ValorKey", "Valor ou nome")
local KeyGerada = CriarCaixa(PaginaKeys, "KeyGerada", "Key gerada")
KeyGerada.TextEditable = false

local StatusKey = Instance.new("TextLabel")
StatusKey.Name = "StatusKey"
StatusKey.Size = UDim2.new(1, -8, 0, 32)
StatusKey.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
StatusKey.BackgroundTransparency = 0.08
StatusKey.BorderSizePixel = 1
StatusKey.BorderColor3 = CoresCoresAtualmente.BordaBotao
StatusKey.Text = "Aguardando"
StatusKey.TextColor3 = CoresCoresAtualmente.TextoSecundario
StatusKey.Font = Enum.Font.GothamBold
StatusKey.TextSize = 12
StatusKey.Parent = PaginaKeys
AplicarGradiente(StatusKey)

local function DefinirStatusKey(Texto)
	StatusKey.Text = Texto
end

local function GerarKey()
	if TelaDeCarregamentoAtiva() then
		DestruirMenuSeExistir()
		return
	end

	if not Gerador then
		DefinirStatusKey("Pasta Gerador nao encontrada")
		return
	end

	local Tipo = string.lower(TipoKey.Text)
	local ValorTexto = ValorKey.Text
	local Evento = nil

	if Tipo == "coins" or Tipo == "coin" or Tipo == "dinheiro" then
		Evento = CoinEvent
	elseif Tipo == "tool" or Tipo == "tools" or Tipo == "arma" or Tipo == "item" then
		Evento = ToolEvent
	elseif Tipo == "veiculo" or Tipo == "veiculos" or Tipo == "carro" then
		Evento = VeiculosEvent
	end

	if not Evento then
		DefinirStatusKey("Tipo invalido ou Remote inexistente")
		return
	end

	if ValorTexto == "" then
		DefinirStatusKey("Digite um valor ou nome")
		return
	end

	if Evento == CoinEvent then
		local ValorNumerico = tonumber(ValorTexto)

		if not ValorNumerico then
			DefinirStatusKey("Coins precisa ser numero")
			return
		end

		Evento:FireServer("Generate", ValorNumerico)
	else
		Evento:FireServer("Generate", ValorTexto)
	end

	DefinirStatusKey("Solicitacao enviada")
end

CriarBotao(PaginaKeys, "Gerar Key", GerarKey)

local function ConfigurarRespostaKey(Evento, Nome)
	if not Evento then
		return
	end

	Evento.OnClientEvent:Connect(function(Key)
		if Key then
			KeyGerada.Text = tostring(Key)
			DefinirStatusKey("Key recebida de " .. Nome)

			local CorOriginal = KeyGerada.BackgroundColor3

			TweenService:Create(KeyGerada, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(85, 60, 120)
			}):Play()

			task.delay(0.4, function()
				if KeyGerada and KeyGerada.Parent then
					TweenService:Create(KeyGerada, TweenInfo.new(0.2), {
						BackgroundColor3 = CorOriginal
					}):Play()
				end
			end)
		else
			DefinirStatusKey("Erro ao receber key")
		end
	end)
end

ConfigurarRespostaKey(CoinEvent, "CoinEvent")
ConfigurarRespostaKey(ToolEvent, "ToolEvent")
ConfigurarRespostaKey(VeiculosEvent, "VeiculosEvent")

if AnuncioEvent then
	AnuncioEvent.OnClientEvent:Connect(function(Mensagem)
		if typeof(Mensagem) == "string" then
			local Key = Mensagem:match("key:%s*(%w+)") or Mensagem:match("Key:%s*(%w+)")

			if Key then
				KeyGerada.Text = Key
				DefinirStatusKey("Key recebida por anuncio")
			end
		end
	end)
end

-- ===================== AUTO DRIVE =====================
CriarTitulo(PaginaVeiculos, "Auto Drive")

local CaixaDestino = CriarCaixa(PaginaVeiculos, "NomeDestino", "Nome do local (ex: Police)")
local StatusAutoDrive = Instance.new("TextLabel")
StatusAutoDrive.Name = "StatusAutoDrive"
StatusAutoDrive.Size = UDim2.new(1, -8, 0, 32)
StatusAutoDrive.BackgroundColor3 = CoresCoresAtualmente.FundoSecundario
StatusAutoDrive.BackgroundTransparency = 0.08
StatusAutoDrive.BorderSizePixel = 1
StatusAutoDrive.BorderColor3 = CoresCoresAtualmente.BordaBotao
StatusAutoDrive.Text = "Inativo"
StatusAutoDrive.TextColor3 = CoresCoresAtualmente.TextoSecundario
StatusAutoDrive.Font = Enum.Font.GothamBold
StatusAutoDrive.TextSize = 12
StatusAutoDrive.Parent = PaginaVeiculos
AplicarGradiente(StatusAutoDrive)

local function AtualizarStatusAutoDrive(Status)
	StatusAutoDrive.Text = Status
end

local function PararAutoDrive()
	AutoDriveAtivo = false
	VeiculoAtualAtivo = nil
	AtualizarStatusAutoDrive("Parado")
end

local function IniciarAutoDrive()
	if AutoDriveAtivo then
		PararAutoDrive()
		return
	end

	if TelaDeCarregamentoAtiva() then
		DestruirMenuSeExistir()
		return
	end

	local Destino = CaixaDestino.Text
	if Destino == "" then
		AtualizarStatusAutoDrive("Digite um destino")
		return
	end

	-- Procurar veículo
	local Veiculo = nil
	if Character then
		Veiculo = Character:FindFirstChildOfClass("Humanoid")
		if Veiculo then
			-- Verificar se está em um veículo (procurar em Workspace)
			Veiculo = nil
		end
	end

	-- Procurar veículos no workspace
	for _, v in ipairs(workspace:GetChildren()) do
		if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
			if v:IsDescendantOf(Player.Character) then
				Veiculo = v
				break
			end
		end
	end

	if not Veiculo then
		AtualizarStatusAutoDrive("Entre em um veículo!")
		return
	end

	AutoDriveAtivo = true
	VeiculoAtualAtivo = Veiculo
	UltimaDestinacao = Destino
	AtualizarStatusAutoDrive("AutoDrive: " .. Destino)

	-- Loop AutoDrive
	while AutoDriveAtivo and VeiculoAtualAtivo and VeiculoAtualAtivo.Parent do
		task.wait(0.1)
		
		-- Procurar destino no Workspace
		local DestinoLocal = workspace:FindFirstChild(Destino)
		
		if DestinoLocal then
			local PosicaoDestino = DestinoLocal:IsA("Model") and DestinoLocal:FindFirstChild("PrimaryPart") and DestinoLocal.PrimaryPart.Position or DestinoLocal.Position
			local PosicaoVeiculo = VeiculoAtualAtivo.PrimaryPart and VeiculoAtualAtivo.PrimaryPart.Position or VeiculoAtualAtivo.Position
			
			local Distancia = (PosicaoDestino - PosicaoVeiculo).Magnitude
			
			if Distancia < 50 then
				AtualizarStatusAutoDrive("Destino chegou!")
				PararAutoDrive()
				break
			else
				-- Dirigir para o destino
				local Direcao = (PosicaoDestino - PosicaoVeiculo).Unit
				
				-- Simular ControleWASD (você pode precisar ajustar conforme seu game)
				if VeiculoAtualAtivo:FindFirstChild("BodyGyro") or VeiculoAtualAtivo:FindFirstChild("BodyVelocity") then
					VeiculoAtualAtivo.BodyVelocity.Velocity = Direcao * 50
				end
			end
		else
			AtualizarStatusAutoDrive("Destino não encontrado")
			PararAutoDrive()
			break
		end
	end
end

CriarBotao(PaginaVeiculos, "Iniciar AutoDrive", IniciarAutoDrive)
CriarBotao(PaginaVeiculos, "Parar AutoDrive", PararAutoDrive)

TrocarPagina("Home")
