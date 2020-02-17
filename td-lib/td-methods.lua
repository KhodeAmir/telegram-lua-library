

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
 if result.message then
              msg = result.message
         data_ = {}
data_.content = {}
data_.date = msg.date
if msg.text then
 data_.content["Pre"] = 'messageText'
end
  data_.content.text = msg.text

  if msg.poll then
data_.poll_id = msg.poll.id 
   data_.poll_closed = msg.poll.is_closed
           data_.poll_question = msg.poll.question
    end
    if msg.new_chat_members or msg.left_chat_member or msg.new_chat_title or msg.new_chat_photo or msg.delete_chat_photo or msg.group_chat_created or msg.supergroup_chat_created or msg.channel_chat_created then
        data_.service = true
         else
          data_.service = false
      end
      if msg.animation then
        data_.content.animation  = {}
        data_.content["Pre"] = 'messageAnimation'

        data_.content.animation.file_id = msg.animation.file_id
        data_.content.animation.file_name = msg.animation.file_name
        data_.content.animation.file_size = msg.animation.file_size
        data_.content.animation.height = msg.animation.height
        data_.content.animation.mime_type = msg.animation.mime_type
        data_.content.animation.thumb_file_id = msg.animation.thumb.file_id
        data_.content.animation.thumb_height = msg.animation.thumb.height
        data_.content.animation.thumb_file_size = msg.animation.thumb.file_size
        data_.content.animation.thumb_width = msg.animation.thumb.width
        end
      if msg.left_chat_member then

data_.content.left_chat = {}
data_.content["Pre"] = 'messageLeft'
data_.content.left_chat.user_id = msg.left_chat_member.id
data_.content.left_chat.username = msg.left_chat_member.username
     data_.content.left_chat.firstname = msg.left_chat_member.first_name
         if msg.left_chat_member.last_name then
           data_.content.left_chat.lastname =  msg.left_chat_member.last_name 
         else
    data_.content.left_chat.lastname = ' '
         end 
        end
        if msg.new_chat_member then
       data_.content.new_user = {}
       data_.content["Pre"] = 'messageNewUser'
       data_.content.new_user.id = msg.new_chat_member.id
            data_.content.new_user.username = msg.new_chat_members.username
              data_.content.new_user.firstname = msg.new_chat_members.first_name
          if msg.new_chat_member.last_name then
         data_.content.new_user.lastname =  msg.new_chat_member.last_name 
       else
     data_.content.new_user.lastname = ' '
       end 
      end
   data_.content.caption = msg.caption
       data_.on = {}
          
           data_.on.chat_id = msg.chat.id
           data_.on.title = msg.chat.title
              if msg.from then
               data_.on.sender_userid = msg.from.id
                   data_.on.sender_username = msg.from.username
                       data_.on.sender_firstname = msg.from.first_name
              end
                         data_.on.id = msg.message_id
                              if msg.forward_from then
                                CRCO:vardump(msg.forward_from)
                          data_.content.forwarded_from = {}
                          data_.content["Pre"] = 'messageForwardFromuser'

                              data_.content.forwarded_from.firstname = msg.forward_from.first_name
                               data_.content.forwarded_from.userid = msg.forward_from.id
                                  data_.content.forwarded_from.firstname = msg.forward_from.first_name
                                      if msg.forward_from.last_name then
                                     data_.content.forwarded_from.lastname = msg.forward_from.last_name
                                      else
                                       data_.content.forwarded_from.lastname = ' '
                                      end
                                    end
                                    if msg.forward_from_chat and msg.forward_from_chat.type == 'channel' then
                                       data_.content.forwarded_from_channel  = {}
                                       data_.content["Pre"] = 'messageFromChannel'

                                           data_.content.forwarded_from_channel.id = msg.forward_from_chat.id
                                            data_.content.forwarded_from_channel.msg_id = msg.forward_from_message_id
                                              data_.content.forwarded_from_channel.signature = msg.forward_signature 
                                                  data_.content.forwarded_from_channel.title = msg.forward_from_chat.title
                                                  data_.content.forwarded_from_channel.username = msg.forward_from_chat.username
                                      end
                                      
        if msg.reply_to_message   then
     data_.on.reply_to_message_id = msg.reply_to_message.message_id
         data_.on.chat_id = msg.reply_to_message.chat.id
             data_.on.title = msg.reply_to_message.chat.title
                 data_.on.type = msg.reply_to_message.chat.type
                    if  msg.reply_to_message.forward_from then
                   data_.content.forwarded_from = {}
                   data_.content["Pre"] = 'messageForwardFromuser'

                   data_.content.forwarded_from.id = msg.reply_to_message.forward_from.id
                   data_.content.forwarded_from.firstname = msg.reply_to_message.forward_from.first_name
                      if msg.reply_to_message.forward_from.last_name then
                     data_.content.forwarded_from.lastname = msg.reply_to_message.forward_from.last_name
                      else
                       data_.content.forwarded_from.lastname = ' '
                      end
                    end
                   
                     data_.on.sender_userid = msg.reply_to_message.from.id
                       data_.on.sender_username = msg.reply_to_message.from.username
                           data_.on.sender_firstname = msg.reply_to_message.from.firstname
                              if msg.reply_to_message.poll then
                           data_.poll_id = msg.reply_to_message.poll.id 
                           data_.poll_closed = msg.reply_to_message.poll.is_closed
                                   data_.poll_question = msg.reply_to_message.poll.question
                              end
                                   data_.on.sender_lastname = msg.reply_to_message.from.last_name or ''
        end
       
        CRCO:getMessage(data_)
  

      elseif result.edited_message then
        msg = result.edited_message
     data_.content = {}
     data_.content.text = msg.text
data_.on = {}
data_.on.id = msg.message_id
data_.on.chat_id = msg.chat.id
data_.on.title = msg.chat.title
   data_.on.type = msg.chat.type
       data_.on.sender_userid = msg.from.id
         data_.on.sender_username = msg.from.username
           data_.on.sender_firstname = msg.from.first_name
               data_.on.sender_lastname = msg.from.last_name or ''
        CRCO:getMessage(data_)
      
      elseif result.callback_query then
      data = result.callback_query

 data_.content = {}
   data_.content.text = data.data
       data_.on = {}
                     if data.message and data.message.reply_to_message then
               data_.on.id = data.message.message_id
         
               data_.content.old_text = data.message.text
                     data_.reply_on_id = data.message.reply_to_message.message_id
                            data_.on.reply_sender_firstname = data.message.reply_to_message.from.first_name 
                 data_.on.reply_sender_username = data.message.reply_to_message.from.username
                        data_.on.reply_sender_lastname = data.message.reply_to_message.from.last_name or ''
                          data_.on.reply_sender_userid = data.message.reply_to_message.from.id
                             data_.on.reply_chat_id = data.message.reply_to_message.chat.id
                                data_.on.reply_chatt_itle = data.message.reply_to_message.chat.title
                                  data_.on.reply_chat_type = data.message.reply_to_message.chat.type                    
                                  data_.on.reply_user_type = data.message.reply_to_message.from.is_bot or 'Typeuser'
                                      data_.on.user_code = data.message.reply_to_message.from.language_code


                     end
      data_.on.sender_firstname = data.from.first_name
          data_.on.sender_username = data.from.username
                data_.on.sender_lastname = data.from.last_name or ''
                data_.on.sender_userid = data.from.id
               if data.message then
         data_.on.chat_id = data.message.chat.id
              data_.on.chat_title = data.message.chat.title
              data_.on.user_code = data.message.from.language_code
              data_.on.chat_type = data.message.chat.type                    
  end  
  

                 CRCO:get_callback_query(data_)

       elseif result.inline_query then
         QI = result.inline_query
            QI.content = {}
               QI.content.text = rr.query
                     CRCO:get_inline_query(QI)
                      CRCO:vardump(QI)
                                else
                                  CRCO:unget_message(result)
                                end
                  end
function CRCO:getMessage(message)
    end
function CRCO:unget_message(Message)
  printRed(
    'MessageNotsupported'
  )
end
function CRCO:get_callback_query(up)
end
function CRCO:get_inline_query(up)
end


return CRCO