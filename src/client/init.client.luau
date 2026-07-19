local orderUpdate = game.ReplicatedStorage:WaitForChild("orderUpdate")

local player = game.Players.LocalPlayer
local hud = player:WaitForChild("PlayerGui"):WaitForChild("hud")
local btnOrder = hud:WaitForChild("btnOrder")
local counter = btnOrder:WaitForChild("counter")
local popup = hud:WaitForChild("daftarOrder")
local isi = popup:WaitForChild("isi")

btnOrder.MouseButton1Click:Connect(function()
	popup.Visible = not popup.Visible
end)

orderUpdate.OnClientEvent:Connect(function(daftar)
	counter.Text = tostring(#daftar)
	counter.Visible = #daftar > 0

	local baris = {}
	for _, o in daftar do
		table.insert(baris, o.barang.nama .. "  ->  " .. o.alamat)
	end

	if #baris == 0 then
		isi.Text = "belum ada order"
	else
		isi.Text = table.concat(baris, "\n")
	end
end)
