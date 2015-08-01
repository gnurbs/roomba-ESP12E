-- some functions missing in lua ...

function pow(a,n)
    -- there is no power nor bitshift Are you fucking kidding me, goddamnit
    if n == 0 then return 1
    else return a*pow(a,n-1) end
end

function uint(chars)
    -- you cannot take a number bigger than a byte from an array, b/c fuck you.
    -- this is MSB
    local x=0
    n = #chars
    for i=1,n do
        x = x + chars:byte(n-i+1)*pow(256,i-1)
    end
    return x
end

function struct_unpack(struct,itemlen)
	pos = 1
	ans={}
	for i,j in pairs(itemlen) do
	ans[i] = struct:sub(pos,pos+j-1)
	pos=pos+j
	end
	ans[#ans+1] = struct:sub(pos)
	return unpack(ans)
end

function map(func, array)
  local new_array = {}
  for i,v in ipairs(array) do
    new_array[i] = func(v)
  end
  return new_array
end
