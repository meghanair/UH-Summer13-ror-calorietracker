class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end
  
  def search
     
  end
  
  def search_by_restaurant  
    search_string = params[:restaurant_name]
    puts params[:restaurant_name]
    @restaurants = Restaurant.search (search_string)
     if (@restaurants.size ==0 || @restaurants == nil )
      render 'search_error'
   
   end
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
       @restaurants = Restaurant.find(params[:id])
      else
        render 'create_error'
      end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
      if @restaurant.update(restaurant_params)
         @restaurants = Restaurant.all
      else
        render 'update_error'
      end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.menu.destroy       
    restaurant_id = @restaurant.id
    @restaurants = Menu.restaurant.where(:restaurant_id=>restaurant_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:restaurant_name)
    end
end
