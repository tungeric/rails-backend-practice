class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    render :index
  end
  
  def show
    query = params[:query]
    if query.is_a?(Integer)
      @chat = Chat.find_by(id: query)
      render :show
    elsif query.is_a?(String)
      @chats = Chat.get_unexpired(query)
      render :index
    end
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: { id: @chat.id }
    else
      render json: @chat.errors.full_messages
    end
  end

  def chat_params
    params.require(:chat).permit(:id, :username, :text, :timeout)
  end
end
