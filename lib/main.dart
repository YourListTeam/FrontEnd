import 'package:your_list_flutter_app/screens/wrapper.dart';
import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/models/user.dart';
import 'models/userService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        Provider(
            create: (_) => UserService.create(),
            dispose: (context, UserService service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );

//    return StreamProvider<User>.value(
//      value: AuthService().user,
//      child: Provider(
//        create: (_) => UserService.create(),
//        dispose: (context, UserService service) => service.client.dispose(),
//        child: MaterialApp(
//          home: Wrapper(),
//        ),
//      ),
//    );
  }
}
