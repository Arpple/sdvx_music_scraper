defmodule SdvxMusicCrawler do
  alias SdvxMusicCrawler.{Html, Document}

  @spec get_music_from_page(integer()) :: %{}
  def get_music_from_page(page) do
    page
    |> Html.from_web()
    |> Html.parse()
    |> Document.get_music_list()
  end

  @doc """
  get list of all music from sdvx web synchronously page by page
  """
  def get_all_music_sync() do
    first_page = Html.from_web(1)
    |> Html.parse()

    first_page_music_list = Document.get_music_list(first_page)
    count = Document.get_page_count(first_page)

    Enum.reduce(2..count, first_page_music_list,
      fn page, music_list ->
        music_list ++ get_music_from_page(page)
      end
    )
  end
end
