defmodule SdvxMusicCrawler.Document do
	@moduledoc false

  def get_music_infos(doc) do
		Floki.find(doc, ".info")
	end

	def get_page_count(doc) do
		[search_page] = Floki.find(doc, "#search_page")

		search_page
		|> Floki.children()
		|> length()
	end
end
