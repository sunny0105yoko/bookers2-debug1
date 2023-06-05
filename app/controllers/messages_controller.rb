class MessagesController < ApplicationController
  before_action :authenticate_user!
  #before_action :reject_non_related, only: [:show]

    def create
      if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
        @message = Message.new(message_params)
        if @message.save
            redirect_to "/rooms/#{@message.room_id}"
        end
      else
        redirect_back(fallback_location: root_path)
      end
    end

    private 
    def message_params
        params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id)
    end
    
    #def reject_non_related
    #user = User.find(params[:id])
    #unless current_user.following?(user) && user.following?(current_user)
      #redirect_to books_path
    #end
    #end
end