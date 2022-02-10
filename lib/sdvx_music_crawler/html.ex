defmodule SdvxMusicCrawler.Html do
	@moduledoc false

	@url "https://p.eagate.573.jp/game/sdvx/vi/music/index.html"
	@encoding "VENDORS/MICSFT/WINDOWS/CP932"

	def from_web(), do: from_web("1")

	def from_web(page) when is_number(page) do
		from_web(to_string(page))
	end

	def from_web(page) when is_binary(page) do
		form = [{"page", page}]
		%{body: body} = HTTPoison.post!(@url, {:multipart, form}, [])

		Codepagex.to_string!(body, @encoding)
	end

	@doc """
	get html content from file without decoding from 'shift-jis'
	your file need to be in 'utf-8'
	"""
	def from_file(path) do
		path
		|> Path.expand()
		|> File.read!()
	end

	def parse(html) do
		{:ok, document} = Floki.parse_document(html)
		document
	end
end
