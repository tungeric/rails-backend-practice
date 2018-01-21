class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    render :index
  end
  
  def show
    query = params[:query]
    if query.to_i != 0
      @chat = Chat.find_by(id: query)
      render :show
    else
      @chats = Chat.get_unexpired(query)
      debugger
      render :index
    end
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: { id: @chat.id }, status: 201
    else
      render json: @chat.errors.full_messages
    end
  end

  def chat_params
    params.require(:chat).permit(:id, :username, :text, :timeout)
  end
end
