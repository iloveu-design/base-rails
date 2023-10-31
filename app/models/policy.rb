class Policy < ApplicationRecord
  CATEGORIES = %w( terms privacy )

  def self.terms
    where(category: 'terms').order('id desc').first
  end

  def self.privacy
    where(category: 'privacy').order('id desc').first
  end

  def self.category_name(category)
    case category
    when 'terms'
      '서비스 이용 약관'
    when 'privacy'
      '개인정보처리방침'
    end
  end
end
