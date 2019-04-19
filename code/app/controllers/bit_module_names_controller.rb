class BitModuleNamesController < ApplicationController
  before_action :set_bit_module_name, only: [:show, :edit, :update, :destroy]

  # GET /bit_module_names
  # GET /bit_module_names.json
  def index
    @bit_module_names = BitModuleName.all
  end

  # GET /bit_module_names/1
  # GET /bit_module_names/1.json
  def show
  end

  # GET /bit_module_names/new
  def new
    @bit_module_name = BitModuleName.new
  end

  # GET /bit_module_names/1/edit
  def edit
  end

  # POST /bit_module_names
  # POST /bit_module_names.json
  def create
    @bit_module_name = BitModuleName.new(bit_module_name_params)

    respond_to do |format|
      if @bit_module_name.save
        format.html { redirect_to @bit_module_name, notice: 'Bit module name was successfully created.' }
        format.json { render :show, status: :created, location: @bit_module_name }
      else
        format.html { render :new }
        format.json { render json: @bit_module_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bit_module_names/1
  # PATCH/PUT /bit_module_names/1.json
  def update
    respond_to do |format|
      if @bit_module_name.update(bit_module_name_params)
        format.html { redirect_to @bit_module_name, notice: 'Bit module name was successfully updated.' }
        format.json { render :show, status: :ok, location: @bit_module_name }
      else
        format.html { render :edit }
        format.json { render json: @bit_module_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bit_module_names/1
  # DELETE /bit_module_names/1.json
  def destroy
    @bit_module_name.destroy
    respond_to do |format|
      format.html { redirect_to bit_module_names_url, notice: 'Bit module name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bit_module_name
      @bit_module_name = BitModuleName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bit_module_name_params
      params.require(:bit_module_name).permit(:date_added, :last_modified, :author, :sub_topic_one, :sub_topic_two, :sub_topic_three, :sub_topic_four, :sub_topic_five)
    end
end
