module Modules
  module MailFormater
    [:to, :cc].each do |method|
      define_method method.to_s+'=' do |emails|
        write_attribute(method, emails.split(',').map(&:strip))
      end
    end
  end
end
