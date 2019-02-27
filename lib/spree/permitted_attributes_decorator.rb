Spree::PermittedAttributes.class_eval do
  @@product_attributes.push(:ean)
  @@user_attributes.push(:complete_name)
end