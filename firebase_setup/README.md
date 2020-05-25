# firebase_setup

A new Flutter Sample project with Firebase Setup.

### Files to be changed:

- pubsec.yaml 
    - update `firebase_core` package version if required
- android/build.gradle
    - Change Google services depencicy version 
    - Version list can be found at: https://firebase.google.com/docs/android/setup
    - Current version is: `classpath 'com.google.gms:google-services:4.3.3'` , change to yours
- android/app/build.gradle 
    - Get the `packagename` from firebase console and add it to `applicationId` 
    - Add following where all the `apply plugin` line exists: 
        - `apply plugin: 'com.google.gms.google-services'`
- Replace `andoird/app/google-services.json` with your own
    - Download it from Firebase Console
