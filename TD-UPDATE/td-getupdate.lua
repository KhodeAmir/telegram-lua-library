__CRCO  = require("td-lib.td-methods"):NEW() 

lastUpdateTime = 0 
PRE = 3
 function __CRCO:RUNING()
    if os.time() >= lastUpdateTime + PRE then
    while true do
        __CRCO:getUpdates()
        lastUpdateTime = os.time() - 10
         Update = __CRCO:PreMessage()
         if (Update ~= nil) then        
  __CRCO:checkUpdate(Update.CRCO)
                end
                    end
                    end
                
                end
             
            
                return __CRCO