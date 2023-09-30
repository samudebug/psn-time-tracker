import 'package:api_repository/api_repository.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_repository/games_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:psn_time_tracker/blocs/games_bloc/games_bloc.dart';
import 'package:psn_time_tracker/blocs/profile_bloc/profile_bloc.dart';
import 'package:psn_time_tracker/blocs/trophies_bloc/trophies_bloc.dart';
import 'package:psn_time_tracker/blocs/trophy_groups_bloc/trophy_groups_bloc.dart';
import 'package:psn_time_tracker/pages/games/games_page.dart';
import 'package:psn_time_tracker/pages/login/login_page.dart';
import 'package:trophies_repository/trophies_repository.dart';

void main() {
  APIRepository apiRepository = APIRepository();
  ProfileRepository profileRepository = ProfileRepository(apiRepository: apiRepository);
  GamesRepository gamesRepository = GamesRepository(apiRepository: apiRepository);
  TrophiesRepository trophiesRepository = TrophiesRepository(apiRepository: apiRepository);
  runApp(MyApp(apiRepository: apiRepository, profileRepository: profileRepository, gamesRepository: gamesRepository, trophiesRepository: trophiesRepository,));
  
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.apiRepository, required this.profileRepository, required this.gamesRepository, required this.trophiesRepository});
  final APIRepository apiRepository;
  final ProfileRepository profileRepository;
  final GamesRepository gamesRepository;
  final TrophiesRepository trophiesRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => apiRepository),
        RepositoryProvider(create: (_) => profileRepository),
        RepositoryProvider(create: (_) => gamesRepository),
        RepositoryProvider(create: (_) => trophiesRepository),
        RepositoryProvider(create: (_) => AuthRepository())
      ],child: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => ProfileBloc(profileRepository: context.read<ProfileRepository>(), authRepository: context.read<AuthRepository>())),
        BlocProvider(create: (context) => GamesBloc(gamesRepository: context.read<GamesRepository>())),
        BlocProvider(create: (context) => TrophyGroupsBloc(trophiesRepository: context.read<TrophiesRepository>(),  authRepository: context.read<AuthRepository>())),
        BlocProvider(create: (context) => TrophiesBloc(trophiesRepository: context.read<TrophiesRepository>(),  authRepository: context.read<AuthRepository>()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, background: Colors.black),
          primaryColorDark: Colors.black,
          
          useMaterial3: true,
        ),
        home: LoginPage()),
    ),
    );
  }
}