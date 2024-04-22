local from = tonumber(ARGV[1])
local to = tonumber(ARGV[2])

redis.debug("from: " .. from)
redis.debug("to: " .. to)

local result = {}

for slot=from,to do
    local keysInSlot = redis.call('CLUSTER', 'COUNTKEYSINSLOT', slot) -- 計算指定 slot 的 key 數量
    local keys = redis.call('CLUSTER', 'GETKEYSINSLOT', slot, keysInSlot) -- 取得指定 slot 的所有 key
    for _, key in ipairs(keys) do
        local pos = string.find(key, ':') -- 以 : 做為分群條件
        if pos ~= nil then
           local simplifiedKey = string.sub(key, 1, pos - 1)
           local memory = redis.call('MEMORY', 'USAGE', key)
           if result[simplifiedKey] == nil then
               result[simplifiedKey] = memory
           else
               result[simplifiedKey] = result[simplifiedKey] + memory
           end
       end
    end
end
redis.debug(result)
return cjson.encode(result)