class PinsController < ApplicationController

  def index
    @pins = Pin.all

    respond_to do |format|
      format.json { render json: @pins.to_json(:include => :user) }
    end
  end

  def create
    @pin = Pin.new(pin_params)
    respond_to do |format|
      if @pin.save
        format.json { render json: @pin }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def update
    @pin = Pin.find(params[:id])
    respond_to do |format|
      if @pin.update(pin_params)
        format.json { render json: @pin }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def show
    @pin = Pin.find(params[:id])
    respond_to do |format|
      format.json { render json: @pin.to_json(:include => :user)}
    end
  end


  private

  def pin_params
    params.require(:pin).permit(:item_name, :description, :user_id, :buy_sell)
  end

end
