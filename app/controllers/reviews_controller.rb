class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_business
  before_action :authenticate_user!
  before_action :check_user

  # GET /reviews/new
  def new
    @review = Review.new
    @skip_footer = true
  end

  # GET /reviews/1/edit
  def edit  
  end

  

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.business_id = @business.id
    @review.business_name = @business.name

    respond_to do |format|
      if @review.save
        if @review.rating >= 3
        # Tell the UserMailer to send a welcome email after save
        UserMailer.notify(@review).deliver

        format.html { redirect_to new_business_review_path}
        format.json { render :show, status: :created, location: @review }
        else
        # Tell the UserMailer to send a welcome email after save
        UserMailer.warning(@review).deliver

        format.html { redirect_to new_business_review_path}
        format.json { render :show, status: :created, location: @review }
        end
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
        @skip_footer = true
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to business_path(@business), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def check_user
      unless current_user.admin?
        redirect_to pages_buy_path, alert: "Sorry you have to purchase a package to ask for reviews."
      end
    end

    def set_business
      @business = Business.find(params[:business_id])
    end  

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment, :name, :email)
    end
end
