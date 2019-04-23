class BitModulesController < ApplicationController
  before_action :set_bit_module, only: [:show, :edit, :update, :destroy]

  # GET /bit_modules
  # GET /bit_modules.json
  def index
    @bit_modules = BitModule.all
  end

  # GET /bit_modules/1
  # GET /bit_modules/1.json
  def show
  end

  # GET /bit_modules/new
  def new
    @bit_module = BitModule.new
  end

  # GET /bit_modules/1/edit
  def edit
  end

  # POST /bit_modules
  # POST /bit_modules.json
  def create
    @bit_module = BitModule.new(bit_module_params)

    respond_to do |format|
      if @bit_module.save
        format.html { redirect_to @bit_module, notice: 'Bit module was successfully created.' }
        format.json { render :show, status: :created, location: @bit_module }
      else
        format.html { render :new }
        format.json { render json: @bit_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bit_modules/1
  # PATCH/PUT /bit_modules/1.json
  def update
    respond_to do |format|
      if @bit_module.update(bit_module_params)
        format.html { redirect_to @bit_module, notice: 'Bit module was successfully updated.' }
        format.json { render :show, status: :ok, location: @bit_module }
      else
        format.html { render :edit }
        format.json { render json: @bit_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bit_modules/1
  # DELETE /bit_modules/1.json
  def destroy
    @bit_module.destroy
    respond_to do |format|
      format.html { redirect_to bit_modules_url, notice: 'Bit module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bit_module
      @bit_module = BitModule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bit_module_params
      params.require(:bit_module).permit(:name, :author, :bit_content, :sub_topic_one, :sub_topic_two)
    end
end
