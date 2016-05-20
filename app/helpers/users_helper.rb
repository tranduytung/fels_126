module UsersHelper
  def gravatar_for user, options = {size: Settings.image_user.size}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    if user.picture?
      gravatar_url = user.picture.url
      image_tag gravatar_url, height: Settings.image_user.height,
      width: Settings.image_user.width, alt: user.name, class: "gravatar"
    else
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag gravatar_url, alt: user.name, class: "gravatar"
    end
  end

  def find_user user_id
    User.find_by id: user_id
  end
end
