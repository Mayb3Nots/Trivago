import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/auth/controller/auth_controller.dart';
import 'package:trivago/routes/app_router.dart';
import 'constants/colour.dart';
import 'core/error_text.dart';
import 'core/loader.dart';
import 'firebase_options.dart';
import 'models/user_models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(
    BuildContext context,
  ) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    UserModel? userModel;
    // void getData(WidgetRef ref, User data) async {
    //   userModel = await ref
    //       .watch(authControllerProvider.notifier)
    //       .getUserData(data.uid)
    //       .first;
    //   ref.read(userProvider.notifier).update((state) => userModel);
    //   setState(() {});
    // }

    AppRouter appRouter = AppRouter(ref: ref);
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              routerConfig: appRouter.config(),
              debugShowCheckedModeBanner: false,
              title: 'Demo',
              theme: Pallete.darkModeAppTheme,
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
