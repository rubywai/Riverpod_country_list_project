import 'package:country_list/ui/pages/detail_page.dart';
import 'package:country_list/ui/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'ui/pages/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     routerConfig: GoRouter(
       routes: [
         GoRoute(path: '/',
         builder: (context,routeState){
           return const Home();
         },),
         GoRoute(path: '/name/:name',
         builder: (context,routeState){
           String? name = routeState.pathParameters['name'] ?? '';
           return CountryDetailPage(name: name);
         },)
       ],
       errorBuilder: (context,_){
         return Material(
           child: FailedWidget(errorMessage: 'invalid route', tryAgain: (){
             context.go("/");
           }),
         );
       }
     ),
    );
  }
}
