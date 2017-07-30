class StoresController < ApplicationController
  before_action :set_store, only: [:destroy, :update]

  def index
    @stores = Store.order(:id)
  end

  def create
    @store = Store.create(store_params)

    redirect_to stores_path
  end

  def update
    @store.update(store_params)

    redirect_to stores_path
  end

  def destroy
    @store.destroy
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:en_name, :ch_name, :menu)
  end
end
