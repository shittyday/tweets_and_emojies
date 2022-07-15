# twitts_emoji

🧠🧠🧠🧠🧠
Very cool app
🫂🫂🫂🫂🫂

## Getting Started

Read before check it.

Structure of project:
    - lib
        - common
            - confi.dart # init string for sql
        - cubit
            - emoji_cubit.dart # cubit for emoji toolbar
            - emoji_state.dart # state for emoji toolbar
            - expand_cubit.dart # cubit for expand emoji toolbar
        - models
            - emojies_table.dart # emojies table
            - tweet.dart # tweet table
            - view_table.dart # view table, id's  from emojies table, and from tweet table
        -repository
            - repository.dart # repository for database, api
        -widgets
            - clickable_emoji.dart # clickable single emoji
            - custom_appbar.dart # appbar
            - emoji_toolbar.dart # emoji toolbar contains clickable_emoji
            - tweer_error_card.dart # error card for when tweet throw error
            - tweet_card.dart # tweet card contains tweet_card_default, and emoji_cubit
            - tweet_card_default.dart # contains tweet and emoji
            - tweet_count_card.dart # card of tweet count contains tweet_count_inherited widget
            - tweet_count_inherited.dart # inherited widget for check count of tweet
        home.dart # contains Home widget and tweet_card
        main.dart # main function
