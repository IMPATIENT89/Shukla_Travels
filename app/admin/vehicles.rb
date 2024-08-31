ActiveAdmin.register Vehicle do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :vehicle_no, :registration_no, :no_of_seats, :host_id, :car_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:vehicle_no, :registration_no, :no_of_seats, :host_id, :car_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :vehicle_image_attachment, :vehicle_image_blob
  
end
