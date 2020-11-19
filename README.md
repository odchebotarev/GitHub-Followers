# GitHub Followers
There is my home project of GitHub followers viewer app. I hope you enjoy it!
<br>
Let's see what it's like:

## 1. Search Screen
Type username and tap the "Get followers" button to see user's followers.
<br><br>
<img src="/Screenshots/01_SearchScreen.png" width="33%">

## 2. Followers Screen
See user's followers. If you've scrolled to the end, swipe one more time to upload more followers.
<br><br>
<img src="/Screenshots/02_FollowersScreen.png" width="33%"> <img src="/Screenshots/03_FollowersScreenLoading.png" width="33%">

## 3. User Info Screen
See info of typed user by tapping the "User Info" button or his followers by tapping the follower. Tap the "GitHub Profile" button to open profile URL by Safari Viewer or tap the "Get followers" button to see selected follower's followers. Tap the plus button to add user to your favorites.
<br><br>
<img src="/Screenshots/04_UserInfoScreen.png" width="33%"> <img src="/Screenshots/05_SafariScreen.png" width="33%">

## 4. Favorites Screen
See your favorite users. Tap the user to see his followers. Swipe left to delete user from favorites.
<br><br>
<img src="/Screenshots/06_FavoritesScreen.png" width="33%">

## 5. Custom Alert
Get system messages by pretty custom alert.
<br><br>
<img src="/Screenshots/07_CustomAlert.png" width="33%">

## 6. Dark Mode
GitHub Followers app supports dark mode. If you like dark colors - you will definitely like this!
<br><br>
<img src="/Screenshots/08_SearchScreen_dark.png" width="33%"> <img src="/Screenshots/09_FollowersScreen_dark.png" width="33%"> <img src="/Screenshots/10_UserInfoScreen_dark.png" width="33%"> <img src="/Screenshots/11_FavoritesScreen_dark.png" width="33%"> <img src="/Screenshots/12_CustomAlert_dark.png" width="33%">

## 7. RU Localization
Из России с любовью! GitHub Followers app is fully localized for Russia.
<br><br>
<img src="/Screenshots/13_SearchScreen_ru.png" width="33%"> <img src="/Screenshots/14_UserInfoScreen_ru.png" width="33%"> <img src="/Screenshots/15_FavoritesScreen_ru.png" width="33%"> <img src="/Screenshots/16_CustomAlert_ru.png" width="33%">

## Tech Side Overview
There is some tech details you should know about this app:
1. GitHub Followers app supports iOS 13 and higher;
2. No 3rd Party frameworks - Only native stuff;
3. 100% programmatic layout using UIKit - No SwiftUI/Xibs/Storyboards (except Launchscreen);
4. Adaptive UI for all iPhone screen sizes;
5. Dynamic Type support on User Info screen;
6. Data retrieval using GitHub API;
7. Diffable DataSource for Followers collectionview;
8. Storing favorites by Userdefaults;
9. App constants are separately stored in 'Constants.swift' file;
10. Unit&UI Testing;
11. Localization - GitHub app default language is Eng but it's also RU-localized.

## What's next
There's more to come. I'm currently working on my app optimization to make it more effecient and maintainable using SOLID principles. Stay tuned!
