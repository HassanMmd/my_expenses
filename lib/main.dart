import 'package:flutter/material.dart';
import 'package:my_expenses/screens/mainScreen.dart';
import 'package:my_expenses/services/dataBase.dart';
import 'package:my_expenses/services/reminderAndNotifications.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:my_expenses/viewModel/categoryViewModel.dart';
import 'package:my_expenses/viewModel/reminderViewModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHelper.initDatabase();
  await NotificationService().init(); //
  await NotificationService().requestIOSPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoneyViewModel>(create: (_) => MoneyViewModel()),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (_) => CategoryViewModel()),
        ChangeNotifierProvider<ReminderViewModel>(
            create: (_) => ReminderViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color:Color(0XFF125F61),
          titleTextStyle: TextStyle(color: Colors.white,fontSize: 15.0),
          ),
                ),
        home: MainScreen(),
      ),
    );
  }
}
