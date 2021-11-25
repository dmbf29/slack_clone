class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # From our JS => { channel: "ChatroomChannel", id: id }
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

end
