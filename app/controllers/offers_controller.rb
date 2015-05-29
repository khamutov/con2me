class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    params[:categories] ||= Category.all.select(:id).map(&:id).map(&:to_s)
    offers_scoped = Offer.desc_contains(params[:search]).category_contains(params[:categories]).order('created_at')
    @offers = offers_scoped.paginate(:page => params[:page])
    generate_dist

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:category_id, :price, :desc, :name, :phone, :image)
    end

    def generate_dist
      # add first elem
      @dists = []
      dist = params[:dist].try(:to_i) || 270
      if dist == 270
        @dists << dist + (-30..30).to_a.sample
      else
        @dists << dist + (20..250).to_a.sample
      end
      for i in 1..Offer.per_page
        @dists << @dists.last + (20..250).to_a.sample
      end
    end
end
