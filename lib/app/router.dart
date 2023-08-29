import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/pages/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.root,
      name: Routes.root,
      redirect: (context, GoRouterState state) async {
        if(supabase.auth.currentUser != null){
          await OneSignal.login(supabase.auth.currentUser!.id);
        }
        return supabase.auth.currentUser == null ? Routes.login : Routes.chatsHome;
      }
    ),
    GoRoute(
      path: Routes.resetPassword,
      name: Routes.resetPassword,
      redirect: (context, state){
        if(supabase.auth.currentUser != null) return Routes.root;
      },
      builder: (context, state){
        final controller = Get.put(ResetPasswordController());
        controller.reset();
        return const ResetPasswordPage();
      }
    ),
    GoRoute(
      path: Routes.login,
      name: Routes.login,
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
      name: Routes.forgotPasswordSent,
        builder: (context, state){
        return const ForgotPasswordSentPage();
      }
    ),
    GoRoute(
      path: Routes.signup,
      name: Routes.signup,
        builder: (context, state){
        final controller = Get.put(SignUpController());
        controller.reset();
        return const SignUpPage();
      }
    ),
    GoRoute(
      path: Routes.spinner,
      builder: (context, state){
        final controller = Get.put(SpinnerController());
        controller.reset();
        return const SpinnerPage();
      },
    ),
    GoRoute(
      path: Routes.chatsHome,
      name: Routes.chatsHome,
      builder: (context, state){
        final profileController = Get.put(MyProfileController());
        return const ChatsHomePage();
      },
    ),
    GoRoute(
      path: Routes.chatRoom,
      name: Routes.chatRoom,
      builder: (context, state){
        return const ChatRoomPage();
      },
    ),
    GoRoute(
      path: Routes.notifications,
      name: Routes.notifications,
      builder: (context, state){
        return const NotificationsPage();
      },
    ),
    GoRoute(
      path: Routes.places,
      name: Routes.places,
      builder: (context, state){
        final controller = Get.put(PlacesController());
        controller.reset(true);
        return const PlacesPage();
      },
    ),
    GoRoute(
      path: Routes.addPlace,
      name: Routes.addPlace,
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
      name: Routes.editPlace,
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
      name: Routes.profile,
      redirect: (context, state){
        if(supabase.auth.currentUser == null) return Routes.root;

        final id = state.pathParameters['id'];
        if(id == null || id == '') return Routes.notFound;

        return null;
      },
      builder: (context, GoRouterState state){
        final id = state.pathParameters['id'];
        final controller = Get.put(ProfileController());
        controller.init(uid: id!);
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: Routes.editProfile,
      name: Routes.editProfile,
      builder: (context, state){
        final controller = Get.put(EditProfileController());
        controller.reset();
        return const EditProfilePage();
      },
    ),
    GoRoute(
      path: Routes.profileMenu,
      name: Routes.profileMenu,
      builder: (context, state){
        return const ProfileMenuPage();
      },
    ),
  ],
);