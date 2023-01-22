defmodule Ps.Policy do
  use LetMe.Policy

  object :post do
    # Creating posts is always allowed
    action :create do
      allow true
    end

    # Viewing posts is always allowed
    action :read do
      allow [:own_resource]
      allow [:public_post]
    end

    # Updating an post is allowed if (the user wrote the post)
    action :update do
      allow [:own_resource]
    end

    # Deleting an post is allowed if (the user wrote the post)
    action :delete do
      allow [:own_resource]
    end
  end
end