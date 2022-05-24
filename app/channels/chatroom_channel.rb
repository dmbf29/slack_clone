class ChatroomChannel < ApplicationCable::Channel
  # how to listen to the channel
  def subscribed
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end

  # what to do when a person leaves the channel
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
