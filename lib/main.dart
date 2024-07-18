import 'package:flutter/material.dart';
import 'package:movies/app_router.dart';

void main() {
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.appRouter});
final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
     onGenerateRoute: appRouter.generateRoute,
     );
  }
}
