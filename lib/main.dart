import 'package:flutter/cupertino.dart';
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
      body: SingleChildScrollView(
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
            SizedBox(
              width: double.infinity,
              height: 350,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: MyItem(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return Ads();
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 202, 193, 255),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                      onPressed: () => _showSnackBar(
                        context,
                        "به روز رسانی با موفقیت انجام شد!",
                      ),
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 24,
                      ),
                      //update button box
                      label: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          "به روز رسانی",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text("آخرین به روز رسانی: ${_getTime()}"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTime() {
    return "20:45";
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: Theme.of(context).textTheme.bodyLarge),
      backgroundColor: Colors.white,
    ),
  );
}

class MyItem extends StatelessWidget {
  const MyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 1.0, color: Colors.grey)],
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("دلار", style: Theme.of(context).textTheme.bodyLarge),

          Text("90000", style: Theme.of(context).textTheme.bodyLarge),

          Text("+3", style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[BoxShadow(blurRadius: 1.0, color: Colors.grey)],
        color: Colors.red,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("تبلیغات", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
