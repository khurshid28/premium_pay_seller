import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/single_application/single_screen.dart';
import 'package:premium_pay_seller/service/storage.dart';



final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static bool isLogin() {
    return StorageService().read(StorageService.token) == null;
  }

  GoRouter router = GoRouter(
    initialLocation: isLogin() ? "/login" : "/",
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: RouteConstants.home,
        pageBuilder: (context, state) => customPageRoute(
          const HomeScreen(),
          state,
        ),
      ),
      GoRoute(
        path: '/login',
        name: RouteConstants.login,
        pageBuilder: (context, state) => customPageRoute(
          const LoginScreen(),
          state,
        ),
      ),
      GoRoute(
        path: '/support',
        name: RouteConstants.support,
        pageBuilder: (context, state) => customPageRoute(
          const SupportScreen(),
          state,
        ),
      ),
      GoRoute(
        path: '/application',
        name: RouteConstants.application,
       pageBuilder: (context, state) {
          final data = state.extra as Map?;
          return customPageRoute(
            ApplicationScreen(id: data?["id"] ?? 0),
            state,
          );
        },
        routes: [
          GoRoute(
            path: 'graphic',
            name: RouteConstants.graphic,
            pageBuilder: (context, state) => customPageRoute(
              GraphicScreen(
                title: state.uri.queryParameters['title']!,
                subtitle: state.uri.queryParameters['subtitle']!,
                app: (state.extra as Map?)?["app"],
              ),
              state,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/singleApplication',
        name: RouteConstants.singleApplication,
        pageBuilder: (context, state) {
          final data = state.extra as Map?;
          return customPageRoute(
            SingleScreen(id: data?["id"] ?? 1),
            state,
          );
        },
        routes: [
          GoRoute(
            path: 'step1',
            name: RouteConstants.step1,
            pageBuilder: (context, state) => customPageRoute(
              Step1Screen(title: state.uri.queryParameters['title']!),
              state,
            ),
          ),
          GoRoute(
            path: 'step2',
            name: RouteConstants.step2,
             pageBuilder: (context, state) {

          final data = state.extra as Map?;
          return customPageRoute(
             Step2Screen(
              app: data?['app'],
             ),
            state,
          );
        },
           
          ),
          GoRoute(
            path: 'step3',
            name: RouteConstants.step3,
              pageBuilder: (context, state) {

          final data = state.extra as Map?;
          return customPageRoute(
             Step3Screen(
              app: data?['app'],
             ),
            state,
          );
        },
          ),
          GoRoute(
            path: 'step4',
            name: RouteConstants.step4,
            pageBuilder: (context, state) {

          final data = state.extra as Map?;
          return customPageRoute(
             Step4Screen(
              app: data?['app'],
             ),
            state,
          );
        },
          ),
          GoRoute(
            path: 'step5',
            name: RouteConstants.step5,
            pageBuilder: (context, state) {

          final data = state.extra as Map?;
          return customPageRoute(
             Step5Screen(
              app: data?['app'],
             ),
            state,
          );
        },
          ),
          GoRoute(
            path: 'step6',
            name: RouteConstants.step6,

              pageBuilder: (context, state) {

          final data = state.extra as Map?;
          return customPageRoute(
             Step6Screen(
              app: data?['app'],
             ),
            state,
          );
        },
          
          ),
        ],
      ),
      GoRoute(
        path: '/myId',
        name: RouteConstants.myId,
        pageBuilder: (context, state) => customPageRoute(
           MyIdScreen(),
          state,
        ),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    ),
  );
}

customPageRoute(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
