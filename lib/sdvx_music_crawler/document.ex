defmodule SdvxMusicScraper.Document do
	@moduledoc false

	@domain "https://p.eagate.573.jp"

	def get_music_list(doc) do
		doc
		|> Floki.find(".music")
		|> Enum.map(&parse_music/1)
	end

	def get_page_count(doc) do
		[search_page] = Floki.find(doc, "#search_page")

		search_page
		|> Floki.children()
		|> length()
	end

	defp parse_music(music_doc) do
		info_doc = Floki.find(music_doc, ".info p")
		name = info_doc |> Enum.at(0) |> Floki.text()
		artist = info_doc |> Enum.at(1) |> Floki.text()

		link = music_doc
		|> Floki.attribute("a", "href")
		|> Enum.at(0)
		|> String.split("=")
		|> Enum.at(1)

		[jacket] = Floki.attribute(music_doc, ".jk img", "src")

		%{
			name: name,
			artist: artist,
			id: link,
			jacket: @domain <> jacket,
			levels: %{
				nov: parse_level(music_doc, ".nov"),
				adv: parse_level(music_doc, ".adv"),
				exh: parse_level(music_doc, ".exh"),
				mxm: parse_level(music_doc, ".mxm"),

				inf: parse_level(music_doc, ".inf"),
				grv: parse_level(music_doc, ".grv"),
				hvn: parse_level(music_doc, ".hvn"),
				vvd: parse_level(music_doc, ".vvd"),
			}
		}
	end

	defp parse_level(doc, name) do
		text = doc
		|> Floki.find(name)
		|> Floki.text()

		if text == "" do
			nil
		else
			{level, _} = Integer.parse(text)
			level
		end
	end
end
