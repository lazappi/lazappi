library(rtweet)
library(tweetrmd)
library(dplyr)

token <- create_token(
    "github-readme-last-tweet",
    consumer_key    = Sys.getenv("CONSUMER_KEY"),
    consumer_secret = Sys.getenv("CONSUMER_SECRET"),
    access_token    = Sys.getenv("ACCESS_TOKEN"),
    access_secret   = Sys.getenv("ACCESS_SECRET"),
    set_renv        = FALSE
)

handle <- "_lazappi_"
recent_tweets <- get_timeline(handle, n = 30, token = token)
original <- recent_tweets %>%
    filter(
        !is_retweet,
        source != "IFTTT"
    ) %>%
    arrange(desc(created_at))
retweets <- recent_tweets %>%
    filter(is_retweet) %>%
    arrange(desc(created_at))

tweet_screenshot(
    tweet_url(handle, original$status_id[1]),
    scale      = 5,
    maxwidth   = 400,
    theme      = "light",
    hide_media = FALSE,
    file       = "latest_tweet.png"
)

tweet_screenshot(
    tweet_url(handle, retweets$status_id[1]),
    scale      = 5,
    maxwidth   = 400,
    theme      = "light",
    hide_media = FALSE,
    file       = "latest_retweet.png"
)
