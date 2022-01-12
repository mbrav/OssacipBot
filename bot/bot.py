import tweepy
import environ

env = environ.Env()
environ.Env.read_env()


def main():

    twitter_auth_keys = {
        "consumer_key": env('SECRET_KEY'),
        "consumer_secret": env('SECRET_KEY'),
        "access_token": env('SECRET_KEY'),
        "access_token_secret": env('SECRET_KEY')
    }

    auth = tweepy.OAuthHandler(
        twitter_auth_keys['consumer_key'],
        twitter_auth_keys['consumer_secret']
    )

    auth.set_access_token(
        twitter_auth_keys['access_token'],
        twitter_auth_keys['access_token_secret']
    )

    api = tweepy.API(auth)

    tweet = "I have been summoned again...."
    status = api.update_status(status=tweet)


if __name__ == "__main__":

    main()
