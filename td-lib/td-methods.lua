

  require('TD-UPDATE.td-MainPre')

  color = {
    black = {30, 40},
          red = {31, 41},
               green = {32, 42},
               yellow = {33, 43},
                       blue = {34, 44},
                                   magenta = {35, 45},
                               cyan = {36, 46},
                    white = {37, 47}
   }
    
 
printRed = function(text)
   return "\027[00m\027[" ..color.red[1].. "m"..text.."\027[00m"
end
function CRCO:sendMessage(chat_id_,text_,msg_id,markdown)
  assert(chat_id_, printRed"Missing required variable chat_id")
  assert(msg_id, printRed"Missing required variable reply_to_message_id")
  assert(text_, printRed"Missing required variable text")
  if markdown == 'md' or markdown == 'markdown' then
    mark = 'Markdown'
     elseif markdown == 'html' then
          mark = 'HTML'
                end
      self:apiRequest('sendMessage', {
        chat_id = chat_id_, 
        text = text_,
        reply_to_message_id = msg_id,
        parse_mode = mark
      
      }
    )
  
end




------------------------------------
function CRCO:checkUpdate(result)
  CRCO:vardump(result)
 if result.message then
              msg = result.message
  
        CRCO:getMessage(msg)
  

      elseif result.edited_message then
        msg = result.edited_message
        CRCO:getMessage(msg)
      
      elseif result.callback_query then
      data = result.callback_query


                 CRCO:get_callback_query(data)

       elseif result.inline_query then
         QI = result.inline_query
                     CRCO:get_inline_query(QI)
                      --CRCO:vardump(QI)
                               
                                end
                  end
function CRCO:getMessage(message)
    end

function CRCO:get_callback_query(up)
end
function CRCO:get_inline_query(up)
end


return CRCO
