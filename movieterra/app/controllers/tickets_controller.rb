class TicketsController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      @ticket = current_user.tickets.create(ticket_params)

      respond_to do |format|
        if @ticket.save
          format.html { redirect_to :root, notice: 'Ticket was successfully created.' }
          format.json { render :show, status: :created, location: @ticket }
        else
          format.html { render :new }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @ticket = current_user.tickets.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to :root, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:movie_id)
    end
end
