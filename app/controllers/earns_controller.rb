class EarnsController < ApplicationController
  before_action :custom_authenticate_user!
  before_action :set_earn, only: %i[ show edit update destroy ]

  def index
    @pagy, @earns = pagy(Earn.order(created_at: :desc), items: 20, anchor_string: 'data-remote="false"')
  end

  def show
  end

  def new
    @earn = Earn.new
  end

  def edit
  end

  def create
    @earn = Earn.new(earn_params)

    respond_to do |format|
      if @earn.save
        EarnJob.perform_later(@earn.id, @earn.txhash, @earn.status)
        format.html { redirect_to earn_url(@earn), notice: "earn was successfully created." }
        format.json { render :show, status: :created, location: @earn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @earn.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @earn.update(earn_params)
        format.html { redirect_to earn_url(@earn), notice: "earn was successfully updated." }
        format.json { render :show, status: :ok, location: @earn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @earn.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @earn.destroy!

    respond_to do |format|
      format.html { redirect_to earns_url, notice: "earn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earn
      @earn = Earn.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def earn_params
      params.require(:earn).permit(:txhash, :prompt, :image, model_file: []).merge(user_id: current_user.id)
    end
end
