# telegram-lua-library - 1.0
 Lua Library for the Telegram-API 

# [Telegram Group](https://t.me/crco_bugs)

# installing

Install luarocks and : `git`,`lua-curl`, `lua5.3`, , `liblua` , `serpent` , `dkjson` , `luasocket` , `ltn12` , `luasec` ,  


## Using : 
- Import `td-getupdate.lua` into the bot.
- Call the functions.

See example script below.


```lua

CRCO  = require("telegram-lua-library.TD-UPDATE.td-getupdate")
            
function CRCO:getMessage(msg)
    CRCO:vardump(msg)
    if msg.text == 'ping' then
        CRCO:vardump(msg)
CRCO:sendMessage(msg.chat.id,'READY',msg.message_id,'html')
end
end
CRCO:setconfig{
    token = '' --you'r token
}    
CRCO:RUNING()


```





## CRCO - Amir Bagheri
