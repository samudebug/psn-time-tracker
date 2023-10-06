# PSN Time Tracker

App to view your registered game time for PS4 and PS5 games.

Since around 2017, PSN tracks your game times for your games. You can only see this information in 3 ways:
- Using Parental Control settings
- If it's a recent game, you can see on the PS App
- On a PS5

Because of that, I made an app that pulls that data from the PSN API using a transformer that I made. [You can check it here](https://github.com/samudebug/psn-time-tracker-api).

I've used Fluter to build the app with the BLoC architeture.

Screenshots:
![Screenshot_1696097906](https://github.com/samudebug/psn-time-tracker/assets/34324655/9609d674-8d80-46c9-a9fb-1828ffb046f7)

![Screenshot_1696181305](https://github.com/samudebug/psn-time-tracker/assets/34324655/559480e1-5a75-4571-aa3c-23d3730034f3)

![Screenshot_1696181313](https://github.com/samudebug/psn-time-tracker/assets/34324655/70276dcc-8112-44a6-97ad-45dd2cfe14fb)

Now with a better UI for tablets:
![Screenshot_1696597763](https://github.com/samudebug/psn-time-tracker/assets/34324655/57d623ee-ae68-47a9-a4d9-4b7511cf1d98)
![Screenshot_1696597815](https://github.com/samudebug/psn-time-tracker/assets/34324655/1b357da2-6301-40d8-be70-8a2a150c02d0)
![Screenshot_1696597826](https://github.com/samudebug/psn-time-tracker/assets/34324655/b10756b9-9a86-4fa4-a987-8f5b0fb6bd1e)


Packages used:
- [Dio](https://github.com/cfug/dio)
- [Flutter Secure Storage](https://github.com/mogol/flutter_secure_storage)
- [Percent Indicator](https://github.com/diegoveloper/flutter_percent_indicator)
- [Flutter BLoC](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc)
- [Equatable](https://github.com/felangel/equatable)
- [Flutter Shimmer](https://github.com/hnvn/flutter_shimmer)
- [WebView Flutter Plus](https://github.com/shah-xad/webview_flutter_plus)
