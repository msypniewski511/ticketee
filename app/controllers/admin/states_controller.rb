class Admin::StatesController < ApplicationController
  before_action :set_state, only: [:edit, :update, :destroy]
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end
  def edit
  end

  def create
    @state = State.new(state_params)
    if @state.save
      flash[:notice] = "State has been created."
      redirect_to admin_states_path
    else
      flash.now[:alert] = "State has not been created."
      render "new"
    end
  end

  def update
    if @state.update(state_params)
      flash[:notice] = "State has been updated."
      redirect_to admin_states_path
    else
      flash.now[:alert] = "State has not been updated"
      render "edit"
    end
  end

  private

  def set_state
    @state = State.find(params[:id])
  end

  def state_params
    params.require(:state).permit(:name, :color)
  end
end
