module ApplicationHelper
  def ko_boolean_type(bool)
    bool ? 'O' : 'X'
  end

  def excerpt_short(text)
    truncate(raw(strip_tags(text).gsub('"','').gsub("'",'').gsub('&amp;','&').gsub('&lt;','<').gsub('&gt;','>').html_safe), length: 28)
  end

  def excerpt(text)
    truncate(raw(strip_tags(text).gsub('"','').gsub("'",'').gsub('&amp;','&').gsub('&lt;','<').gsub('&gt;','>').html_safe), length: 40)
  end

  def excerpt_b(text)
    truncate(raw(strip_tags(text).gsub('"','').gsub("'",'').gsub('&amp;','&').gsub('&lt;','<').gsub('&gt;','>').html_safe), length: 52)
  end

  def excerpt_long(text)
    truncate(raw(strip_tags(text).gsub('"','').gsub("'",'').gsub('&amp;','&').gsub('&lt;','<').gsub('&gt;','>').html_safe), length: 126)
  end

  def provider_ko(provider)
    case provider.to_s
    when 'kakao'
      '카카오톡으'
    when 'naver'
      '네이버'
    when 'facebook'
      '페이스북으'
    end
  end
end
