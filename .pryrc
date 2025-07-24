# frozen_string_literal: true

Pry::Commands.create_command 'goto' do
  description 'Open ActiveRecord object in browser'

  def process
    obj = target.eval(arg_string)

    case obj
    when ActiveRecord::Base
      url = build_url(obj)
      open_browser(url)
    when Integer, String
      output.puts 'Please pass an ActiveRecord object, not just an ID'
    else
      output.puts "#{obj.class} is not an ActiveRecord object"
    end
  rescue StandardError => e
    output.puts "Error: #{e.message}"
  end

  private

  def build_url(obj)
    host = ENV['RAILS_ENV'] == 'development' ? 'localhost:3000' : 'your-staging-url.com'
    protocol = ENV['RAILS_ENV'] == 'development' ? 'http' : 'https'

    resource = obj.class.name.underscore.pluralize
    "#{protocol}://#{host}/#{resource}/#{obj.id}"
  end

  def open_browser(url)
    output.puts "Opening #{url}..."

    case RbConfig::CONFIG['host_os']
    when /darwin/
      system("open '#{url}'")
    when /linux/
      system("xdg-open '#{url}'")
    when /mswin|mingw|cygwin/
      system("start '#{url}'")
    end
  end
end
