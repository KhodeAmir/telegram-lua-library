local CRCO_ = {}

function CRCO_:NEW(restab)
     local table = restab or {}

    
     setmetatable(table, self)
     
     self.__index = self
 
     return table

end


function CRCO_:ROS()
  
    local VAL_ = {}
  
    setmetatable(VAL_, {
        __index = self
    })
  
    return VAL_
end
