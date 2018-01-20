class Api::ChatsController < ApplicationController

  def show
    @chat = Chat.find_by(id: params[:id])
    render :show
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render :show, status: 201
    else
      render json: @chat.errors.full_messages
    end
  end

  def chat_params
    params.require(:chat).permit(:username, :text, :timeout)
  end
end
