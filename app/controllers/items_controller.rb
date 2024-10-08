class ItemsController < ApplicationController
  before_action :authorized_user # Ensure user is authenticated

  def index
    items = Item.all
    render json: items
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end

  def authorized_user
    decoded_token = decode_token(request.headers['Authorization'])
    @current_user = User.find(decoded_token['user_id']) if decoded_token
  rescue
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
