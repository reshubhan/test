module MessagesHelper
  def message_row(message)
    image = "<img src='images/flag.png'>"
    row="<tr id='row_#{message.id}'"+( (message.sender_read==false||message.receiver_read==false) ? " style='font-weight:bold;width:100%;'":"")+">
          <td><input style='width:10px;border:0px;' id=check_box#{message.id} type=checkbox value=#{message.id} name=meassagecheckbox /></td>
          <td style='width:20%;'>#{message.short_name(message.sender.fullname)}</td>
          <td style='width:40%;'>#{link_to_redbox(message.short_subject, 'message_display_'+message.id.to_s,:title=>'Open the message',:onclick=>"read_status('"+message.id.to_s+"');")}</td>
          <td>#{message.is_not_interested ? image : "&nbsp;"}</td>
          <td style='width:15%;'>#{message.reciver_response}</td>
          <td style='width:25%;'>#{message.created_at.strftime("%a, %d %b %Y %H:%M:%S ")}</td>
        </tr>"
  end
end
