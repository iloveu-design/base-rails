class OpItem < ApplicationRecord
  include RailsSortable::Model

  set_sortable :seq, without_updating_timestamps: true

  default_scope { order("seq asc") }

  def get_content(k)
    content.present? ? content[k] : ''
  end
end
