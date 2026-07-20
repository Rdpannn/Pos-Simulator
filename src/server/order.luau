local barang = require(game.ReplicatedStorage.Shared.barang)

local order = {}

order.daftar = {}

-- angka sementara, nanti diatur pas balancing
local maxOrder = 3
local jedaSpawn = 5
local peluang = 0.5

local idBerikut = 1

-- jalur siaran daftar order ke semua client
local orderUpdate = Instance.new("RemoteEvent")
orderUpdate.Name = "orderUpdate"
orderUpdate.Parent = game.ReplicatedStorage

-- client minta klaim order lewat sini (id tertentu, kosong = semua)
local ambilOrder = Instance.new("RemoteEvent")
ambilOrder.Name = "ambilOrder"
ambilOrder.Parent = game.ReplicatedStorage

local function siarkan()
	orderUpdate:FireAllClients(order.daftar)
end

-- yang dihitung cuma order yang belum diklaim
local function jumlahBaru()
	local n = 0
	for _, o in order.daftar do
		if o.status == "baru" then
			n += 1
		end
	end
	return n
end

function order.buat()
	local b = barang[math.random(#barang)]
	local semuaRumah = workspace.map.pemukiman:GetChildren()
	local rumah = semuaRumah[math.random(#semuaRumah)]

	table.insert(order.daftar, {
		id = idBerikut,
		barang = b,
		rumah = rumah,
		alamat = rumah:GetAttribute("alamat") or rumah.Name,
		status = "baru",
		pemilik = nil,
	})
	idBerikut += 1
	siarkan()
end

ambilOrder.OnServerEvent:Connect(function(player, id)
	for _, o in order.daftar do
		if o.status == "baru" and (id == nil or o.id == id) then
			o.status = "diambil"
			o.pemilik = player
		end
	end
	siarkan()
end)

function order.mulai()
	task.spawn(function()
		while true do
			task.wait(jedaSpawn)
			if jumlahBaru() < maxOrder and math.random() < peluang then
				order.buat()
			end
		end
	end)
end

return order
