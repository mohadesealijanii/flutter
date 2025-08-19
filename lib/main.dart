import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:my_app/Model/Currency.dart';

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
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontFamily: 'irancell',
            fontSize: 12,
            fontWeight: FontWeight.w300,
            height: 1.3,
          ),
          displaySmall: TextStyle(
            fontFamily: 'irancell',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'irancell',
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'irancell',
            fontSize: 12,
            fontWeight: FontWeight.w200,
          ),
          bodySmall: TextStyle(
            fontFamily: 'irancell',
            fontSize: 11,
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({super.key});
  List<Currency> currency = [];

  getResponse() {
    var url = 'http://sasansafari.com/flutter/api.php?access_key=flutter123456';
    http.get(Uri.parse(url)).then((value) {
      print((value.statusCode));
      if (currency.isEmpty) {
        if (value.statusCode == 200) {
          List jsonList = convert.jsonDecode(value.body);

          if (jsonList.isNotEmpty) {
            for (int i = 0; i < jsonList.length; i++) {
              setState(() {
                currency.add(
                  Currency(
                    id: jsonList[i]["id"],
                    title: jsonList[i]["title"],
                    price: jsonList[i]["price"],
                    changes: jsonList[i]["changes"],
                    status: jsonList[1]["status"],
                  ),
                );
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getResponse();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/icon.png", width: 40),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "  به روز ارز و سکه",
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
        padding: const EdgeInsets.all(18.0),
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
              style: Theme.of(context).textTheme.displayMedium,
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
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      "قیمت",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      "تغییر",
                      style: Theme.of(context).textTheme.displaySmall,
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
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: MyItem(position, currency),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Container(
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                              ),
                        ),
                        onPressed: () => _showSnackBar(
                          context,
                          "به روز رسانی با موفقیت انجام شد!",
                        ),
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 24,
                        ),
                        //update button box
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                            "به روز رسانی",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text("آخرین به روز رسانی: ${_getTime()}"),
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

  String _getTime() {
    return "20:45";
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: Colors.green),
    // style: Theme.of(context).textTheme.bodyLarge  );
  );
}

class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;
  MyItem(this.position, this.currency);

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
          Text(
            currency[position].title!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          Text(
            currency[position].price!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          Text(
            currency[position].changes!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 1.0, color: Colors.grey),
          ],
          color: Colors.red,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("تبلیغات", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
