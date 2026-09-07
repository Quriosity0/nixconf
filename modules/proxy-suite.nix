{ ... }:
{
  services.proxy-suite = {
    enable = true;

    # ------------------------------------------------------------------
    # zapret-discord-youtube (DPI bypass)
    # ------------------------------------------------------------------
    zapret = {
      enable = true;
      configName = "general(ALT)"; # choosing config
      gameFilter = "null";         # "null", "all", "tcp" or "udp"
      listGeneral = [ "rutracker.org" "github.com" "steambrew.app" "itch.io" "steamcommunity.com" "steampowered.com" "cloudflare-ech.com" "encryptedsni.com" "cloudflareaccess.com" "cloudflareapps.com" "cloudflarebolt.com" "cloudflareclient.com" "cloudflareinsights.com" "cloudflareok.com" "cloudflarepartners.com" "cloudflareportal.com" "cloudflarepreview.com" "cloudflareresolve.com" "cloudflaressl.com" "cloudflarestatus.com" "cloudflarestorage.com" "cloudflarestream.com" "cloudflaretest.com" "cloudfront.net" "dis.gd" "discord-attachments-uploads-prd.storage.googleapis.com" "discord.app" "discord.co" "discord.com" "discord.design" "discord.dev" "discord.gift" "discord.gifts" "discord.gg" "discord.media" "discord.new" "discord.store" "discord.status" "discord-activities.com" "discordactivities.com" "discordapp.com" "discordapp.net" "discordcdn.com" "discordmerch.com" "discordpartygames.com" "discordsays.com" "discordsez.com" "discordstatus.com" "yt3.ggpht.com" "yt4.ggpht.com" "yt3.googleusercontent.com" "googlevideo.com" "jnn-pa.googleapis.com" "stable.dl2.discordapp.net" "wide-youtube.l.google.com" "youtube-nocookie.com" "youtube-ui.l.google.com" "youtube.com" "youtubeembeddedplayer.googleapis.com" "youtubekids.com" "youtube.googleapis.com" "youtubei.googleapis.com" "youtu.be" "yt-video-upload.l.google.com" "ytimg.com" "ytimg.l.google.com" "play.google.com" "google.ru" "audio-ak-spotify-com.akamaized.net" "audio4-ak-spotify-com.akamaized.net" "byspotify.com" "cdn-spotify-experiments.conductrics.com" "heads-ak-spotify-com.akamaized.net" "heads4-ak-spotify-com.akamaized.net" "open.spotify.com" "pscdn.co" "scdn.co" "spoti.fi" "spotify-everywhere.com" "spotify.co" "spotify.co.uk" "spotify.com" "spotify.com.edgesuite.net" "spotify.de" "spotify.design" "spotify.fr" "spotify.in" "spotify.jp" "spotify.map.fastly.net" "spotify.map.fastlylb.net" "spotify.net" "spotify.org" "spotify.ru" "spotifycdn.com" "spotifycdn.net" "spotifycharts.com" "spotifycodes.com" "spotifyforbrands.com" "spotifyjobs.com" "accounts.scdn.co" "apis.spotify.com" "auth.scdn.co" "bouncer.spotify.com" "cdn.spotify.com" "client.scdn.co" "external.spotify.com" "media.spotify.com" "play.spotify.com" "s1.spotify.com" "s2.spotify.com" "s3.spotify.com" "s4.spotify.com" "spclient.wg.spotify.com" "spotify.artworks.com" "spotify.events.com" "spotify.messaging.com" "static.spotify.com" "st.spotify.com" "status.spotify.com" "github.com" "collector.github.com" "api.github.com" "githubusercontent.com" "avatars.githubusercontent.com" "private-user-imagesgithubusercontent.com" "t.me" ]; # additional domains
      listExclude = [ "microsoft365.com" "office.com" "cloud.microsoft" "microsoft.com" "office.net" "marketplace.visualstudio.com" "gallery.vsassets.io" "gallerycdn.vsassets.io" "gosuslugi.ru" "gov.ru" "nalog.ru" "spb.ru" "mos.ru" "vk.ru" "vk.me" "vkvideo.ru" "ok.ru" "mycdn.me" "okcdn.ru" "odkl.ru" "wb.ru" "geobasket.ru" "paywb.com" "rwb.ru" "wb-basket.ru" "wbbasket.ru" "wbpay.ru" "wibes.ru" "wildberries.ru" "ozon.by" "ozon.com" "ozon.com.by" "ozon.com.kz" "ozon.kz" "ozon.ru" "ozon.tm" "ozone.ru" "ozonru.me" "ozonusercontent.com" "alfabank.ru" "gazprombank.ru" "gpb.ru" "dbo-dengi.online" "mtsdengi.ru" "psbank.ru" "bankline.ru" "rosbank.ru" "abr.ru" "rshb.ru" "sber.ru" "sberbank.com" "sberbank.ru" "cdn-tinkoff.ru" "tbank-online.com" "tbank.ru" "t-bank-app.ru" "tochka-tech.com" "tochka.com" "vtb.ru" "mail.ru" "citilink.ru" "yandex.com" "yandex.net" "yandex.org" "yandex.md" "yandex.ru" "yandexadexchange.net" "yandexcloud.net" "yandexcom.net" "yandexmetrica.com" "yandexwebcache.net" "yandexwebcache.org" "yastat.net" "yastatic-net.ru" "yastatic.net" "ya.ru" "adfox.ru" "admetrica.ru" "naydex.net" "rostaxi.org" "turbopages.org" "webvisor.com" "webvisor.org" "nvidia.com" "donationalerts.com" "vk.com" "yandex.kz" "mts.ru" "multimc.org" "dns-shop.ru" "habr.com" "3dnews.ru" ]; # exclude these addresses
      ipsetExclude = [ "0.0.0.0/8" "10.0.0.0/8" "127.0.0.0/8" "172.16.0.0/12" "192.168.0.0/16" "169.254.0.0/16" "224.0.0.0/4" "100.64.0.0/10" "::1" "fc00::/7" "fe80::/10" ];
      ipsetAll = [ "203.0.113.0/24" ];
    };

    # ------------------------------------------------------------------
    # tg-ws-proxy (local Telegram MTProto WS proxy)
    # ------------------------------------------------------------------
    tgWsProxy = {
      enable = true;
      port = 1080;
      host = "127.0.0.1";
      secret = "6d5002065e914d0bd2d7ceec1e896b73";
      dcIps = {
        "2" = "149.154.167.220";
        "203" = "149.154.167.220";
        "4" = "149.154.167.220";
      };
    };
    tray = {
      autostart = true;
      enable = true;
    };
  };
}
