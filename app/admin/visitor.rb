ActiveAdmin.register Visitor do

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
    column :os, sortable: false
    column :browser, sortable: false
    column :date, sortable: false
    column :cookie, sortable: false
    column :source, sortable: false
  end

  filter :os
  filter :browser
  filter :date
  filter :cookie
  filter :source

end
