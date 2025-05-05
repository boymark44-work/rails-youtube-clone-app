class ApplicationController < ActionController::Base
    # Allows Devise to accept custom fields securely
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def configure_permitted_parameters
        added_attrs = [:first_name, :last_name]
        devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
        devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
end
