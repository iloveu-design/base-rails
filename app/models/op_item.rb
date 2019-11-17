class OpItem < ApplicationRecord
  default_scope { order("seq asc") }

  def get_content(k)
    content.present? ? content[k] : ''
  end
end
