class ComputersController < ApplicationController
  before_action :set_computer, only: [:show, :edit, :update, :destroy]
  before_action :gather_enums

  # GET /computers
  # GET /computers.json
  def index
    @computers = Computer.all
  end

  # GET /computers/1
  # GET /computers/1.json
  def show
  end

  # GET /computers/new
  def new
    @computer = Computer.new
  end

  # GET /computers/1/edit
  def edit
  end

  # POST /computers
  # POST /computers.json
  def create
    @computer = Computer.find_by(serial: params['computer']['serial'])
    if @computer.nil?
      @computer = Computer.new(fixed_params)

      respond_to do |format|
        if @computer.save
          format.html { redirect_to @computer }
          format.json { render :show, status: :created, location: @computer }
        else
          format.html { render :new }
          format.json { render json: @computer.errors, status: :unprocessable_entity }
        end
      end
    else
      update
    end
  end

  # PATCH/PUT /computers/1
  # PATCH/PUT /computers/1.json
  def update
    if @computer.history != true
      parent = @computer.dup
      parent.history = true
      parent.save!
      @computer.parent = parent
    end
    respond_to do |format|
      if @computer.update(fixed_params)
        format.html { redirect_to @computer }
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  def fixed_params
    my_params = computer_params
    return my_params if @computer.nil?
    my_params[:comments] = nil if @computer.comments == computer_params[:comments]
    my_params[:comment_author] = current_user.name
    my_params
  end

  # DELETE /computers/1
  # DELETE /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html { redirect_to computers_url, notice: 'Computer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_computer
      @computer = Computer.find(params[:id])
    end

    def gather_enums
      @statuses = Computer.statuses
      @manufacturers = Computer.manufacturers
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def computer_params
      params.require(:computer).permit(:name, :status, :history, :owner, :manufacturer, :model, :serial, :wired_mac, :wireless_mac, :product, :space, :processor, :ram, :comments, :comment_author)
    end
end
