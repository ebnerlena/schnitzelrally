# frozen_string_literal: true

# players helper
module PlayersHelper
  def avatar
    player = current_or_guest_user.player

    unless current_or_guest_user.player.nil?
      if player.avatar.attached?
        image_tag(player.avatar)
      else
        image_tag('female1.jpg')
      end
    end
  end
end
