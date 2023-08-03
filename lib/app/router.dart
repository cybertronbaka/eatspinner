import 'package:eatspinner/app/_all.dart';
import 'package:eatspinner/pages/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
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
        final controller = Get.put(PlacesController());
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
      path: Routes.editPlace(),
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
    )
  ],
);