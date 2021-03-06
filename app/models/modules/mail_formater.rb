module Modules
  module MailFormater
    [:to, :cc].each do |method|
      define_method method.to_s + '=' do |emails|
        self[method] = emails.to_a.map(&:strip)
      end

      define_method method.to_s do
        self[method].join(', ')
      end
    end
  end
end
