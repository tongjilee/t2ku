# -*- encoding : utf-8 -*-
class Subdomain
  def self.matches?(request)
    request.subdomain.present? and request.subdomain != 'www'
  end
end
