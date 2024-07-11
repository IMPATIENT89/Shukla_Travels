class ApplicationController < ActionController::Base
    helper_method :current_customer, :current_host, :logged_in_as_customer?, :logged_in_as_host?

    def current_customer
        @current_customer ||= Customer.find(session[:customer_id]) if session[:customer_id]
    end

    def current_host
        @current_host ||= Host.find(session[:host_id]) if session[:host_id]
    end

    def logged_in_as_customer?
        !!current_customer 
    end

    def logged_in_as_host?
        !!current_host
    end
end
