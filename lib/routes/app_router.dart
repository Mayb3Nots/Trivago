import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivago/features/auth/controller/auth_controller.dart';
import '../models/user_models/user_model.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final WidgetRef ref;

  AppRouter({super.navigatorKey, required this.ref});
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: HomeRoute.page,
            initial: true,
            guards: [AuthenticationGuard(ref)]),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: GroupBookingOverviewRoute.page),
        AutoRoute(page: BookingOverviewRoute.page),
      ];
}

class AuthenticationGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthenticationGuard(this.ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    UserModel? userModel;
    void getData(WidgetRef ref, User data) async {
      userModel = await ref
          .watch(authControllerProvider.notifier)
          .getUserData(data.uid)
          .first;
      ref.read(userProvider.notifier).update((state) => userModel);
    }

    final userData = ref.watch(authStateChangeProvider).value;
    if (userData != null) {
      getData(ref, userData);
    }
    if (ref.watch(authStateChangeProvider).value != null) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      // tip: use resolver.redirect to have the redirected route
      // automatically removed from the stack when the resolver is completed
      resolver.redirect(const SignInRoute());
    }
  }
}
