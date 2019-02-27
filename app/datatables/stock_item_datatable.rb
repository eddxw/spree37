# frozen_string_literal: true

class StockItemDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: 'Spree::StockItem.variant_id', searchable: true },
      name: { source: 'Spree::Product.name' },
      sku: { source: 'Spree::Variant.sku' },
      count_on_hand: { source: 'Spree::StockItem.count_on_hand', searchable: false }
    }
  end

  def data
    records.map do |record|
      {
        id: record.variant_id,
        image: record.decorate.image,
        name: record.product.name,
        # name: record.decorate.name,
        sku: record.variant.sku_and_options_text,
        count_on_hand: record.count_on_hand,
        # DT_RowId: record.variant_id
        dt_actions: record.decorate.dt_actions
      }
    end
  end

  def almacen
    @stock_location = options[:stock_location] ? options[:stock_location] : Spree::StockLocation.first 
  end
  
  def get_raw_records
    # insert query here
    # User.all
    almacen.stock_items.includes(variant: [:product, :images, option_values: :option_type])
    .references(:product)
  end
end
