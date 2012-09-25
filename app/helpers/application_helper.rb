module ApplicationHelper

  # Return image tag based on email
  def gravatar_for(user, size=60)
    require 'digest/md5'
    hash = Digest::MD5.hexdigest(user.email)
    image_tag("http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm")
  end

end
