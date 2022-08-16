class CeapsController < ApplicationController
  before_action :set_ceap, only: %i[ show ]

  # GET /ceaps or /ceaps.json
  def index
    @ceaps = Ceap.all
  end

  # GET /ceaps/1 or /ceaps/1.json
  def show
    @deputies = Deputy.where(ceap: @ceap).all
  end

  # GET /ceaps/new
  def new
    @ceap = Ceap.new
  end
  # GET /ceaps/1/edit

  # POST /ceaps or /ceaps.json
  def create
    @ceap = Ceap.new(ceap_params)
    @ceap.save(validate: false)
    file = params[:ceap][:file].tempfile.path
    ReadCsvJob.perform_later(file, @ceap)

    respond_to do |format|
      if @ceap.save
        format.html { redirect_to ceap_url(@ceap), notice: "Seu Arquivo está sendo extraido. Pode levar um tempo. Aguarde!!" }
        format.json { render :show, status: :created, location: @ceap }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ceap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ceaps/1 or /ceaps/1.json
  def destroy
    @ceap = Ceap.find(params[:id])
    DestroyCeapJob.perform_later(@ceap)
    respond_to do |format|
      format.html { redirect_to ceaps_url, notice: "Ceap Deletado com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ceap
      @ceap = Ceap.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ceap_params
      params.require(:ceap).permit(:name, :email, :total_spend)
    end
end
