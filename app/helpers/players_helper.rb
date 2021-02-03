module PlayersHelper
  def avatar
    player = current_or_guest_user.player

    unless current_or_guest_user.player.nil?
      if player.avatar.attached?
        image_tag(player.avatar)
      else
        image_tag('logo.png')
      end
    end
  end
end
