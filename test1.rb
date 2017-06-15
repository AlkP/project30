require 'net/http'
require 'open-uri'
      
class Main
  def run
    loop do
      url = feedback
      parse_data{ url }
      pressEnter
    end
  end
  
  private
  
  def feedback
    loop do 
      system 'clear'
      print "Введите url: "
      url = gets.chomp.to_s.strip.downcase
      next if url.nil?
      return url
    end
  end
  
  def pressEnter
    print "Нажмите Enter для продолжения.."
    gets.chomp
  end
  
  def parse_data
    u = Net::HTTP.get( URI.parse( yield ))
    image_url = u.scan(/(?:\"|\')([^"|']*(?:png|jpg|jpeg))(?:\"|\')/)

    image_url.each do |y|
      fileName = /[^\/]*(?:png|jpg|jpeg)/.match(y[0])
      download = open(y[0])
      IO.copy_stream(download, "../project30/download/" + fileName[0])
    end
  end
end

main = Main.new
main.run