import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa')],
      theme: ThemeData(
        fontFamily: 'irancell',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'irancell',
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
          displayMedium: TextStyle(
            fontFamily: 'irancell',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'irancell',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/icon.png", width: 40),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              " به روز ارز و سکه",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(width: 25, child: Image.asset("assets/menu.png")),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/question.png", width: 20),
                SizedBox(width: 8),
                Text(
                  "نرخ ارز آزاد چیست؟",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "نرخ ارزها در معاملات نقدی و رایج روزانه است، معاملات نقدری معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می‌نمایند.",
              style: Theme.of(context).textTheme.bodyLarge,
              textDirection: TextDirection.rtl,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Container(
                height: 35,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  color: Color.fromARGB(255, 130, 130, 130),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "نام آزاد ارز",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      "قیمت",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      "تغییر",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
