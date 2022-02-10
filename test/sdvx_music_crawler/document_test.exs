defmodule SdvxMusicCrawler.DocumentTest do
	alias SdvxMusicCrawler.{Html, Document}

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
end
