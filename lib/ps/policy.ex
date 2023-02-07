defmodule Ps.Policy do
  use LetMe.Policy

  object :post do
    # Creating posts is always allowed
    action :create do
      allow(true)
    end

    # Viewing posts is always allowed
    action :read do
      allow([:own_resource])
      allow([:public_post])
    end

    # Updating an post is allowed if (the user wrote the post)
    action :update do
      allow([:own_resource])
    end

    # Deleting an post is allowed if (the user wrote the post)
    action :delete do
      allow([:own_resource])
    end
  end

  object :tweet do
    # Creating tweets is always allowed
    action :create do
      allow(true)
    end

    # Viewing tweets is always allowed
    # TODO: add drafts?
    action :read do
      allow(true)
    end

    # Updating an tweet is allowed if (the user wrote the tweet)
    action :update do
      allow([:own_resource])
    end

    # Deleting an tweet is allowed if (the user wrote the tweet)
    action :delete do
      allow([:own_resource])
    end
  end

  object :profile do
    # Viewing profiles is always allowed
    action :read do
      allow(true)
    end

    # Updating a profile is allowed if (the user wrote the profile)
    action :update do
      allow([:own_resource])
    end

    # Deleting a profile is allowed if (the user wrote the profile)
    action :delete do
      allow([:own_resource])
    end
  end
end
