class StoresController < InheritedResources::Base
  load_and_authorize_resource
  
  private

    def store_params
      params.require(:store).permit(:name, :description, :user_id)
    end

end
