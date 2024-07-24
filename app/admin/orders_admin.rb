Trestle.resource(:orders) do
  menu do
    item "订单", icon: "fa fa-list"
  end

  active_storage_fields do
    [:image]
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :txhash
    column :prompt
    column :file_name, header: "Image"
    column :status
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |order|
    tab :content do
      text_field :id
      text_field :txhash
      text_field :prompt

      row do
        col { datetime_field :updated_at }
        col { datetime_field :created_at }
      end
  
      row do
        col { radio_button :status, "pending" }
        col { radio_button :status, "creating" }
        col { radio_button :status, "completed" }
      end
      
    end

    tab :image do
      if order.image.attached?
        order.image.blob.filename
        content_tag :img, nil, src: "data:image/jpeg;base64,#{Base64.encode64(order.image.download)}"
      else
        content_tag :div, "暂无图片", class: "text-center"
      end
    end

  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:order).permit(:name, ...)
  # end
end
