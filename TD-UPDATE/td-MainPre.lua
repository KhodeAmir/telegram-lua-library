CRCO_ = require('td-table.TD-ROS')

curl = require('cURL')

json = require('dkjson') -- TESTING


CRCO = CRCO_:ROS()

serpent = require('serpent')


function CRCO:vardump(value)

    print(serpent.block(value,{comment=false}))

        end
                CRCO.MainUpdateMeta = ''
           CRCO.MainUpdateRequest = ''
        CRCO.MainUpdate = {}
    CRCO.setting_config = {}
            CRCO.MainLastUpdate = 0
        CRCO.MainUpdateQueue = {}
CRCO.grouplist = {}
CRCO.users = {}
function CRCO:setconfig(cfg)
      self.setting_config = cfg     

    end



function CRCO:CleanUpdate()
    self.MainUpdateMeta = ''

end

function CRCO:write(LAST)

    self.MainUpdateMeta = self.MainUpdateMeta .. LAST

end

function CRCO:read (n) 
    if (string.len(self.MainUpdateRequest) == 0) then

        return nil
    else
        local l = math.min(n, string.len(self.MainUpdateRequest))

        local r = string.sub(self.MainUpdateRequest, 1, l)

        self.MainUpdateRequest = string.sub(self.MainUpdateRequest, l + 1, -1)
        return r
    end
end

function CRCO:Main_URL(method)

    return 'https://api.telegram.org/bot' .. self.setting_config.token .. '/' .. method
end
function CRCO:apiRequest (method, data)

    self.MainUpdateMeta = ''
    self.MainUpdateRequest = json.encode(data)
     curl.easy{
        url = self:Main_URL(method),
        writefunction = self,
        readfunction = self,
        httpheader = {
            'Content-Type: application/json',
            'Content-Length: ' .. string.len(self.MainUpdateRequest),
            'Expect:'
        },
    }
    :setopt(curl.OPT_POST, 1) 
    :perform()
 :close()
    
end

function CRCO:getUpdates ()

    self:apiRequest('getUpdates', {offset = self.MainLastUpdate, limit = 10})
    self.MainUpdate = json.decode(self.MainUpdateMeta)
    self:handleMainUpdate()
   
end


function CRCO:PreMessage ()
    if (#self.MainUpdateQueue ~= 0) then
        return table.remove(self.MainUpdateQueue, 1)
    else
        return nil
    end
end

function CRCO:handleMainUpdate()
    if self.MainUpdate.ok  then
        for tttt,msg in ipairs(self.MainUpdate.result) do
            if msg then
                if (msg.update_id >= self.MainLastUpdate) then
                    self.MainLastUpdate = msg.update_id + 1
                end
            
                table.insert(self.MainUpdateQueue, {CRCO =msg})
            end
        end
        self.MainUpdate = {}
    end
end

