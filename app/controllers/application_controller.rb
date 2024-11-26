class ApplicationController < ActionController::Base
  def redirect_to_root
    redirect_to root_path, alert: "The page or action you're looking for doesn't exist."
  end
end
