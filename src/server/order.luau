local barang = require(game.ReplicatedStorage.Shared.barang)

local order = {}

order.daftar = {}

-- angka sementara, nanti diatur pas balancing
local maxOrder = 3
local jedaSpawn = 5
local peluang = 0.5

function order.buat()
	local b = barang[math.random(#barang)]
	local semuaRumah = workspace.map.pemukiman:GetChildren()
	local rumah = semuaRumah[math.random(#semuaRumah)]

	table.insert(order.daftar, {
		barang = b,
		alamat = rumah.Name,
	})
	print("Order masuk: " .. b.nama .. " ke " .. rumah.Name .. " (aktif: " .. #order.daftar .. ")")
end

function order.mulai()
	task.spawn(function()
		while true do
			task.wait(jedaSpawn)
			if #order.daftar < maxOrder and math.random() < peluang then
				order.buat()
			end
		end
	end)
end

return order
