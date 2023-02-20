defmodule SdvxMusicScraper.DocumentTest do
	alias SdvxMusicScraper.{Html, Document}

	use ExUnit.Case

	defp setup_doc(context) do
		doc = "test/example/music.html"
		|> Html.get_body_from_file()
		|> Html.parse_body()

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

		test "grab id from image link", %{doc: doc} do
			[music | _tail] = Document.get_music_list(doc)

			assert music.id == "bcf5MwWqag47zYdBbue-bg"
		end

		test "contain music info", %{doc: doc} do
			[music | _tail] = Document.get_music_list(doc)

			assert %{
				name: "↑↑↓↓←→←→BA",
				artist: "meiyo",
				jacket: "https://p.eagate.573.jp/game/sdvx/vi/common/jacket.html?img=bcf5MwWqag47zYdBbue-bg",
				levels: %{
					nov: 3,
					adv: 10,
					exh: 14,
					mxm: 17,

					inf: nil,
					grv: nil,
					hvn: nil,
					vvd: nil,
				},
			} = music
		end
	end
end
