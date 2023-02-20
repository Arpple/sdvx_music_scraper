# SdvxMusicScraper

elixir library to get music info from [Sound Voltex EXCEED GEAR website](https://p.eagate.573.jp/game/sdvx/vi/music/index.html)

## Installation

install via github url

```elixir
def deps do
  [
    {:sdvx_music_scraper, git: "https://github.com/arpple/sdvx_music_scraper.git", tag: "0.3"}
  ]
end
```

## Usage
get all music. this will get from page by page synchronously, so it will be slow
``` elixir
SdvxMusicScraper.get_all_sync()
# => [
#   %{
#     artist: "meiyo",
#     id: "qITA4PnaDDDpSeOPWszPmQ",
#     jacket: "https://p.eagate.573.jp/game/sdvx/vi/common/jacket.html?img=bcf5MwWqag47zYdBbue-bg",
#     levels: %{adv: 10, exh: 14, grv: nil, hvn: nil, inf: nil, mxm: 17, nov: 3, vvd: nil},
#     name: "↑↑↓↓←→←→BA"
#   },
#   ...
# ]
```

or get single page

``` elixir
SdvxMusicScraper.get_from_page(1)
# => [...]
```


## Todo
- parallel scraping
- hexdoc (maybe)
