defmodule PsWeb.UploadApiController do
  use PsWeb, :controller

  alias Ps.Uploads

  def new(conn, params) do
    args = [
      "--request",
      "POST",
      "--url",
      System.get_env("CLOUDFLARE_DIRECT_UPLOAD_URL"),
      "--header",
      "Authorization: Bearer #{System.get_env("CLOUDFLARE_API_TOKEN")}"
    ]

    if params[:requireSignedUrls] do
      args = args ++ ["--form", "requireSignedURLs=true"]
    end

    {result, status} = System.cmd("curl", args)
    {:ok, %{"result" => result, "success" => success}} = Jason.decode(result)

    %{"id" => id, "uploadURL" => upload_url} = result

    json(conn, %{uploadURL: upload_url, success: success})
  end
end
