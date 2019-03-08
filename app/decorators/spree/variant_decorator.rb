class Spree::VariantDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  
  def actions(order, variant)
    h.content_tag(:div, class: 'big ui compact icon buttons') do
      h.link_to(h.product_path(object.product.id), target: :_blank, class: 'ui blue basic button') do
        h.content_tag(:i, '', class: 'big icons') do
          h.content_tag(:i, '', class: 'white desktop icon')+
          h.content_tag(:i, '', class: 'top right corner white eye icon')
        end
      end +
        h.link_to(h.add_admin_pos_path(number: order.number, item: variant), method: :get, remote: true, class: 'ui green basic button') do
          h.content_tag(:i, '', class: 'big white cart plus icon')
        end
    end
    
  end
  def image
    img = object.images.first ? h.mini_image(object) : h.mini_image(product)
    # h.image_tag(img)
  end
  def name
    h.object.name.truncate(10)
  end
end
