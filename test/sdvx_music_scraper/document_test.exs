defmodule SdvxMusicScraper.DocumentTest do
	alias SdvxMusicScraper.{Html, Document}

	use ExUnit.Case

	defp setup_doc(context) do
		doc = "test/example/music.html"
		|> Html.from_file()
		|> Html.parse()

		Map.put(context, :doc, doc)
	end

	describe "get_page_count" do
		setup [:setup_doc]

		test "returns number of pages available", %{doc: doc} do
			assert Document.get_page_count(doc) == 87
		end
	end

	describe "get_music_list" do
		setup [:setup_doc]

		test "returns list", %{doc: doc} do
			list = Document.get_music_list(doc)
			assert length(list) == 20
		end

		test "contain music info", %{doc: doc} do
			[music | _tail] = Document.get_music_list(doc)

			assert music.name == "↑↑↓↓←→←→BA"
			assert music.artist == "meiyo"
			assert music.id == "qITA4PnaDDDpSeOPWszPmQ"
			assert music.jacket == "https://p.eagate.573.jp/game/sdvx/vi/common/jacket.html?img=bcf5MwWqag47zYdBbue-bg"

			levels = music.levels
			assert levels.nov == 3
			assert levels.adv == 10
			assert levels.exh == 14
			assert levels.mxm == 17

			assert levels.inf == nil
			assert levels.grv == nil
			assert levels.hvn == nil
			assert levels.vvd == nil
		end
	end
end
