class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: %i(show edit update destroy)

  def index
    redirect_to @project
  end

  def new
    @ticket = @project.tickets.build
  end

  def show
    @comment = @ticket.comments.build
  end

  def edit
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user

    if params[:attachments].present?
      @ticket.attachments.attach(params[:attachments])
      Rails.logger.info("-----------------------------------")
      Rails.logger.info("-----------------------------------")
      Rails.logger.info("-----------------------------------")
      Rails.logger.info("-----------------------------------")
      Rails.logger.info("-----------------------------------")
      Rails.logger.info("-----------------------------------")
      Rails.logger.info params[:attachments].inspect
    end


    if @ticket.save
      @ticket.attachments.each do |attachment|
        Rails.logger.info "Attached file: #{attachment.filename}"
      end
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash.now[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def update
    if params[:attachments].present?
      @ticket.attachments.attach(params[:attachments])
    end

    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been updated."
      render "new"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
    redirect_to @project
  end

  def upload_file
    blob = ActiveStorage::Blob.create_and_upload!(io: params[:file], filename: params[:file].original_filename)
    render json: { signedId: blob.signed_id }
  end
  
  private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description, :attachment ,attachments: [])
  end
end
