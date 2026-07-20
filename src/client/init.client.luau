local orderUpdate = game.ReplicatedStorage:WaitForChild("orderUpdate")
local ambilOrder = game.ReplicatedStorage:WaitForChild("ambilOrder")

local player = game.Players.LocalPlayer
local hud = player:WaitForChild("PlayerGui"):WaitForChild("hud")
local btnOrder = hud:WaitForChild("btnOrder")
local counter = btnOrder:WaitForChild("counter")
local popup = hud:WaitForChild("daftarOrder")
local daftarIsi = popup:WaitForChild("daftarIsi")
local kosong = popup:WaitForChild("kosong")
local template = popup:WaitForChild("templateRow")
local aksiCepat = popup:WaitForChild("aksiCepat")
local btnAntarSemua = aksiCepat:WaitForChild("btnAntarSemua")
local btnOperSemua = aksiCepat:WaitForChild("btnOperSemua")

-- bikin tombol keliatan mati & gak bisa diklik
local function matikan(btn)
	btn.Active = false
	btn.AutoButtonColor = false
	btn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
end

-- fitur karyawan belum ada, tombol oper dimatiin dulu
matikan(btnOperSemua)
matikan(template.btnOper)

-- kunci perilaku scroll: frame diem, isinya aja yang melar ke bawah
daftarIsi.AutomaticSize = Enum.AutomaticSize.None
daftarIsi.AutomaticCanvasSize = Enum.AutomaticSize.Y
daftarIsi.CanvasSize = UDim2.new(0, 0, 0, 0)
daftarIsi.ScrollingDirection = Enum.ScrollingDirection.Y

local listLayout = daftarIsi:WaitForChild("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- biar isi list gak nempel ke border
local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.Parent = daftarIsi

btnOrder.MouseButton1Click:Connect(function()
	popup.Visible = not popup.Visible
end)

btnAntarSemua.MouseButton1Click:Connect(function()
	ambilOrder:FireServer()
end)

orderUpdate.OnClientEvent:Connect(function(daftar)
	-- buang row lama, bikin ulang dari daftar terbaru
	for _, row in daftarIsi:GetChildren() do
		if row:IsA("Frame") then
			row:Destroy()
		end
	end

	-- yang ditampilin cuma order yang belum diklaim
	local jumlahBaru = 0
	for urutan, o in daftar do
		if o.status == "baru" then
			jumlahBaru += 1

			local row = template:Clone()
			row.teks.Text = "Ada yang minta dianter nih! 📦 " .. o.barang.nama .. " ke " .. o.alamat
			row.btnAntar.MouseButton1Click:Connect(function()
				ambilOrder:FireServer(o.id)
			end)
			row.LayoutOrder = urutan
			row.Visible = true
			row.Parent = daftarIsi
		end
	end

	counter.Text = tostring(jumlahBaru)
	counter.Visible = jumlahBaru > 0
	kosong.Visible = jumlahBaru == 0
end)
