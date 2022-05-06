defmodule SdvxMusicScraper do
  alias SdvxMusicScraper.{Html, Document}

  @spec get_from_page(integer()) :: list(%{})
  def get_from_page(page) do
    page
    |> Html.from_web()
    |> Html.parse()
    |> Document.get_music_list()
  end

  @doc """
  get list of all music from sdvx web synchronously page by page
  """
  @spec get_all_sync() :: list(%{})
  def get_all_sync() do
    first_page = Html.from_web(1)
    |> Html.parse()

    first_page_music_list = Document.get_music_list(first_page)
    count = Document.get_page_count(first_page)

    Enum.reduce(2..count, first_page_music_list,
      fn page, music_list ->
        music_list ++ get_from_page(page)
      end
    )
  end
end
