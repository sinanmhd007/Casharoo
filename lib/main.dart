import 'package:chaching/Home/HomeScreen.dart';
import 'package:chaching/Transaction/add_transaction/screenaddtransaction.dart';
import 'package:chaching/models/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chaching/Transaction/model/Transactionmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryAdapter().typeId)) {
    Hive.registerAdapter(CategoryAdapter());
  }
  if (!Hive.isAdapterRegistered(CategorytypeAdapter().typeId)) {
    Hive.registerAdapter(CategorytypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionmodelAdapter().typeId)) {
    Hive.registerAdapter(TransactionmodelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casharoo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      home: Homescreen(),
      routes: {
        Screenaddtransaction.routeName: (ctx) => const Screenaddtransaction(),
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
