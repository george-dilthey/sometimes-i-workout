# Sometimes I Workout

Sometimes I Workout is a simple app that allows you to view your Strava activities, as well as add your own run and ride activities. The best way to use the app is to login using Strava. If you'd like to work with the source code, follow these instructions.

## Instructions

First, clone this app down so you can work with it. In order for Strava Oauth to work, you'll need to create a developer account and get access to your client ID and client secret. Add these to your .env file.

```
STRAVA_CLIENT_ID={{CLIENT ID}}
STRAVA_CLIENT_SECRET={{CLIENT SECRET}}
```

This app also need to create a Mapbox developer account and get your public access token and add that to your .env file.

```
MAPBOX_ACCESS_TOKEN={{ACCESS TOKEN}}
```

Once this is done, start up your rails server and play around!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/george-dilthey/sometimes-i-workout.
