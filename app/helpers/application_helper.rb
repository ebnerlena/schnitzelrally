module ApplicationHelper
  def display_svg(filename)
    File.open("app/assets/images/#{filename}.svg", 'rb') do |file|
      raw file.read
    end
  end
end
