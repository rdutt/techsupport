class TicketsController < ApplicationController

  before_filter :require_user

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = current_user.tickets.last(15).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])
    @help_text = ""

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new
    @ticket.platform = Ticket::PLATFORMS[0]
    @ticket.application = Ticket::APPS[0]
    @ticket.priority = Ticket::PRIORITIES[0]
    @ticket.from_name = current_user.name

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.from_email = current_user.email
    @ticket.user_id = current_user.id

    respond_to do |format|
      if @ticket.save
        zt = ZendeskTicket.new(@ticket.platform)
        zt.build(@ticket, request.base_url)
        zd_ticket = zt.create
        @ticket.zendesk_ticket_id = zd_ticket.id
        @ticket.save

        msg = 'Your ticket was successfully created'

        format.html { redirect_to @ticket, notice: msg}
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
