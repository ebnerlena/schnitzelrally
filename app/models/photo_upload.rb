# frozen_string_literal: true

# photo upload model class
class PhotoUpload < GameTask
  def attach(image)
    images.attach(image)
  end
end
