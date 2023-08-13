import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/pages/_all.dart';
import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.root,
      redirect: (context, GoRouterState state) async {
        final deeplinkedRoute = await DeepLinkService.handleOnStart();
        if(deeplinkedRoute != null) return deeplinkedRoute;

        return supabase.auth.currentUser == null ? Routes.login : Routes.spinner;
      }
    ),
    GoRoute(
      path: Routes.resetPassword,
      builder: (context, state){
        final controller = Get.put(ResetPasswordController());
        controller.reset();
        return const ResetPasswordPage();
      }
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state){
        final controller = Get.put(LoginController());
        controller.reset();
        return const LoginPage();
      }
    ),
    GoRoute(
      path: Routes.forgotPassword,
      builder: (context, state){
        final controller = Get.put(ForgotPasswordController());
        controller.reset();
        return const ForgotPasswordPage();
      }
    ),
    GoRoute(
      path: Routes.forgotPasswordSent,
      builder: (context, state){
        return const ForgotPasswordSentPage();
      }
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state){
        final controller = Get.put(SignUpController());
        controller.reset();
        return const SignUpPage();
      }
    ),
    GoRoute(
      path: Routes.spinner,
      builder: (context, state){
        final controller = Get.put(SpinnerController(context));
        controller.reset();
        return const SpinnerPage();
      },
    ),
    GoRoute(
      path: Routes.places,
      builder: (context, state){
        final controller = Get.put(PlacesController(context));
        controller.reset(true);
        return const PlacesPage();
      },
    ),
    GoRoute(
      path: Routes.addPlace,
      builder: (BuildContext context, GoRouterState state){
        final mapController = Get.put(MyMapController());
        final controller = Get.put(AddEditPlaceController());
        mapController.reset();
        controller.reset();
        return const AddEditPlacePage(isEdit: false);
      }
    ),
    GoRoute(
      path: Routes.editPlace,
      redirect: (context, GoRouterState state){
        final id = state.pathParameters['id'];
        if(id == null || id == ':id')  return '404';

        return null;
      },
      builder: (BuildContext context, GoRouterState state){
        final String? id = state.pathParameters['id'];
        final mapController = Get.put(MyMapController());
        final controller = Get.put(AddEditPlaceController());
        controller.reset(int.parse(id!));
        mapController.reset();
        return AddEditPlacePage(isEdit: true, id: id);
      }
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state){
        final controller = Get.put(ProfileController());
        controller.reset();
        return const ProfilePage();
      },
    ),
  ],
);