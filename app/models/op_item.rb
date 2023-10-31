class OpItem < ApplicationRecord
  include RailsSortable::Model

  set_sortable :seq, without_updating_timestamps: true

  default_scope { order("seq asc") }

  def get_value(k)
    if content.present? && content[k].present?
      if get_type(k) == "image"
        Asset.find(content[k])
      else
        content[k]
      end
    else
      nil
    end
  end

  def get_type(k)
    setting[k]
  end

  def setting
    Setting.op_items[category]
  end
end
