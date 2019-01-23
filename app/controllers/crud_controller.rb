class CrudController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!

    after_action :verify_authorized,except: :index 
    # after_action :verify_policy_scoped,only: :create 
    :index
    def index
        user = current_user
        authorize user
        if current_user.admin?
            redirect_to "/admin/index"
        else
            @response = HTTParty.get("https://raw.githubusercontent.com/sab99r/Indian-States-And-Districts/master/states-and-districts.json")
            @detail = Detail.all            
        end
    end

    # def redirect
    #     if current_user.admin?
    #         redirect_to "/admin/index"
    #     else
    #         redirect_to "/crud/index"
    #     end
    # end

    def create
        user = current_user
        authorize user
        @location = params[:state]+", "+params[:districts] 
        @results = Geocoder.search(@location)
        @data = @results[0].data
        latitude = @data["lat"]== nil ? " " : @data["lat"]
        longtitude = @data["lon"] == nil ? " " : @data["lon"]
        @detail = Detail.new(:first_name => params[:first_name],:last_name => params[:last_name],:gender => params[:gender],:location => @location,:latitude => latitude,:longtitude => longtitude,:image => params[:image])
        # @detail = Detail.new(crud_params)
        if @detail.save
            # render :json => { status: @detail}
            redirect_to "/crud/index"
        end
    end

    # def show
    #     @detail = Detail.find(params[:id])
    #     @results = Geocoder.search(@detail.location)
    #     @data = @results[0].data
    #     @lat = @data["lat"]
    #     @lon = @data["lon"]
    # end

    def update
        # @detail = Detail.find(params[:id]
        # @detailEdit = @detail.update(crud_params) 
    end

    def destroy
        user = current_user
        authorize user
        @detail = Detail.find(params[:id])
        @detail.destroy
    end

    private 
    def crud_params
        params.require(:crud).permit(:first_name,:last_name,:gender,:location,:latitude,:longtitude,:image)
    end  
end