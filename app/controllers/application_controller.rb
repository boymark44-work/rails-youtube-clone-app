class ApplicationController < ActionController::Base
    # Allows Devise to accept custom fields securely
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def configure_permitted_parameters
        added_attrs = [:first_name, :last_name]
        devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
        devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end

    # Role-based Redirects. Using custom redirect after login, either as a User or an Author.
    protected

    def after_sign_in_path_for(resource)
        if resource.is_a?(User)
            root_path
        elsif resource.is_a?(Author)
            authors_blogs_path
        else 
            super   
        end
    end

    def after_sign_out_path(resource)
        if resource_or_scope == :author   
            new_author_session_path
        else 
            super
        end
    end

end
