defmodule SdvxMusicScraper.Html do
	@moduledoc false

	@url "https://p.eagate.573.jp/game/sdvx/vi/music/index.html"
	@encoding "VENDORS/MICSFT/WINDOWS/CP932"

	def get_body_from_web(), do: get_body_from_web_page("1")

	def get_body_from_web_page(page) when is_number(page) do
		get_body_from_web_page(to_string(page))
	end

	def get_body_from_web_page(page) when is_binary(page) do
		form = [{"page", page}]
		%{body: body} = HTTPoison.post!(@url, {:multipart, form}, [])
		body
	end

	@doc """
	get html content from file without decoding from 'shift-jis'
	your file need to be in 'utf-8'
	"""
	def get_body_from_file(path) do
		path
		|> Path.expand()
		|> File.read!()
	end

	def parse_body(body) do
		{:ok, document} = Floki.parse_document(body)
		document
	end
end
