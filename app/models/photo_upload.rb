# frozen_string_literal: true

class PhotoUpload < GameTask
  def attach(image)
    images.attach(image)
  end
end
