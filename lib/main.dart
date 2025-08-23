import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/Model/Currency.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

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
  List<Currency> currency = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrency();
  }

  Future<void> fetchCurrency() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List jsonList = convert.jsonDecode(response.body);
        setState(() {
          currency = jsonList
              .map(
                (e) => Currency(
                  id: e["id"],
                  title: e["title"],
                  price: e["price"],
                  changes: e["changes"],
                  status: e["status"],
                ),
              )
              .toList();
          isLoading = false;
        });
        _showSnackBar(context, "به روزرسانی انجام شد!");
      } else {
        setState(() {
          isLoading = false;
        });
        _showSnackBar(context, "خطا در دریافت اطلاعات");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackBar(context, "خطا در دریافت اطلاعات");
      developer.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Info section
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
            ),

            // Header
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

            // Currency List or Loader
            SizedBox(
              width: double.infinity,
              height: 350,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: currency.length,
                      itemBuilder: (context, position) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: MyItem(position, currency),
                      ),
                      separatorBuilder: (context, index) =>
                          index % 9 == 0 ? Ads() : SizedBox.shrink(),
                    ),
            ),

            // Update Button & Last Update
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
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 202, 193, 255),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                              ),
                        ),
                        onPressed: () {
                          fetchCurrency();
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 24,
                        ),
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
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        "آخرین به روز رسانی: ${_getTime()}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
    DateTime now = DateTime.now();
    return DateFormat('kk:mm:ss').format(now);
  }
}

class MyItem extends StatelessWidget {
  int position;
  List<Currency> currency;
  MyItem(this.position, this.currency, {super.key});

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
            getFarsiNumber(currency[position].price.toString()),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            getFarsiNumber(currency[position].changes.toString()),
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

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.green));
}

String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
