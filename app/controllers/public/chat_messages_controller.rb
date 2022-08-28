class Public::ChatMessagesController < ApplicationController
  def index
    @group = Group.find_by(id: params[:group_id])
    @message = ChatMessage.new
    @messages = @group.chat_messages
  end
  
  def create
    @group = Group.find_by(id: params[:group_id])
    @message = @group.chat_messages.new(chat_message_params)
    if @message.save
      redirect_to group_chat_messages_path
    else
      redirect_to group_chat_messages_path
    end
  end
  
  private

  def chat_message_params
    params.require(:chat_message).permit(:message).merge(user_id: current_user.id)
  end
  
end
