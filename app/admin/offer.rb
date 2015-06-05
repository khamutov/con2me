ActiveAdmin.register Offer do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  index do
    selectable_column
    column :price, sortable: false
    column :desc, sortable: false
    column :name, sortable: false
    column :phone, sortable: false
    column :image_file_name, sortable: false
    column :image_content_type, sortable: false
    column :image_file_size, sortable: false
    actions
  end


end
