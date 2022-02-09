defmodule SdvxMusicCrawler do
  @url "https://p.eagate.573.jp/game/sdvx/vi/music/index.html"
  @encoding "VENDORS/MICSFT/WINDOWS/CP932"

  def get_document(), do: get_document("1")

  def get_document(page) when is_number(page) do
    get_document(to_string(page))
  end

  def get_document(page) when is_binary(page) do
    form = [{"page", page}]
    %{body: body} = HTTPoison.post!(@url, {:multipart, form}, [])

    {:ok, document} = body
    |> Codepagex.to_string!(@encoding)
    |> Floki.parse_document()

    document
  end

  def parse_music_info(document) do
    document
    |> Floki.find(".info")
    |> Enum.map(&get_music_name/1)
  end

  def get_music_name(document) do
    Floki.text(document)
  end
end
