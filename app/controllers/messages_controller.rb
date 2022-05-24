class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      # I need to tell everyone in the same chatroom, that a new message was created.
      # 1. where are we broadcasting to? to the chatroom
      # 2. what are we broadcasting? we want to broadcast the HTML partial
      ChatroomChannel.broadcast_to(
        @chatroom, # where
        render_to_string(partial: 'messages/message', locals: { message: @message }) # what
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
