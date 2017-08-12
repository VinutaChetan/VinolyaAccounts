class PerticularsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_perticular, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  # GET /perticulars
  # GET /perticulars.json
  def index
    @perticulars = Perticular.all
  end

  # GET /perticulars/1
  # GET /perticulars/1.json
  def show
  end

  def yearwise_perticular
     @perticular = Perticular.find_by(id: params[:perticular_id]) 
  end 

  def monthwise_perticular
     @perticular = Perticular.find_by(id: params[:perticular_id]) 
  end  

  # GET /perticulars/new
  def new
    @perticular = Perticular.new
  end

  # GET /perticulars/1/edit
  def edit
  end

  # POST /perticulars
  # POST /perticulars.json
  def create
    @perticular = Perticular.new(perticular_params)

    respond_to do |format|
      if @perticular.save
          format.js 
        format.html { redirect_to perticulars_path, notice: 'Perticular was successfully created.' }
        format.json { render :show, status: :created, location: @perticular }
      
      else
        format.js 
        format.html { render :new }
        format.json { render json: @perticular.errors, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /perticulars/1
  # PATCH/PUT /perticulars/1.json
  def update
    respond_to do |format|
      if @perticular.update(perticular_params)
        format.html { redirect_to @perticular, notice: 'Perticular was successfully updated.' }
        format.json { render :show, status: :ok, location: @perticular }
      else
        format.html { render :edit }
        format.json { render json: @perticular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perticulars/1
  # DELETE /perticulars/1.json
  def destroy
    @perticular.destroy
    respond_to do |format|
      format.html { redirect_to perticulars_url, notice: 'Perticular was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perticular
      @perticular = Perticular.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perticular_params
      params.require(:perticular).permit(:name,:perticular_type)
    end
end
