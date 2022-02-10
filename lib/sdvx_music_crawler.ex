defmodule SdvxMusicCrawler do
  def get_content(), do: get_content("1")

  def get_content(page) when is_number(page) do
    get_content(to_string(page))
  end

  def get_content(page) when is_binary(page) do
    form = [{"page", page}]
    %{body: body} = HTTPoison.post!(@url, {:multipart, form}, [])

    html = body
    |> Codepagex.to_string!(@encoding)
  end

  def parse_document(html_content) do
    {:ok, doc} = Floki.parse_document(html_content)
    doc
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
