module UsersHelper
	def is_friend?(user)
    friendship = current_user.friendships.find_by_friend_id(user)

    if friendship && friendship.relationship == "confirm"
      return true
    else
    	return false
    end
  end


  def is_confirming_friend?(user)
  	friendship = current_user.friendships.find_by_friend_id(user)

    if friendship && (friendship.relationship == "confirming" || friendship.relationship == "ignore")
      return true
    else
      return false
    end
  end
end
