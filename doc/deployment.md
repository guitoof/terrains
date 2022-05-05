# Deployment

## Prerequisite
Create a `ios/.env` at the root of the project and set the following variables

```
IOS_TEAM_ID="MY_TEAM_ID"
IOS_PROVISIONING_PROFILE_ID="MY_PROVISIONING_PROFILE_ID"
```

## Deploy
```
cd ios
bundle exec fastlane ios deploy
```

App is distributed to [Firebase App Distribution](https://console.firebase.google.com/project/terrains-game/appdistribution/app/ios:tech.bam.terrains/releases)
