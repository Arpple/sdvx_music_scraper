defmodule SdvxMusicScraper do
  alias SdvxMusicScraper.{Html, Document}

  @spec get_from_page(integer()) :: list(%{})
  def get_from_page(page) do
    page
    |> Html.get_body_from_web_page()
    |> Html.parse_body()
    |> Document.get_music_list()
  end

  @doc """
  get list of all music from sdvx web synchronously page by page
  """
  @spec get_all_sync() :: list(%{})
  def get_all_sync() do
    first_page = Html.get_body_from_web_page(1)
    |> Html.parse_body()

    first_page_music_list = Document.get_music_list(first_page)
    count = Document.get_page_count(first_page)

    Enum.reduce(2..count, first_page_music_list,
      fn page, music_list ->
        music_list ++ get_from_page(page)
      end
    )
  end
end
