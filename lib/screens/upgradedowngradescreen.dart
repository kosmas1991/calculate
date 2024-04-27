import 'package:calculate/widgets/icontextbutton.dart';
import 'package:flutter/material.dart';

class UpgradeDowngradeScreen extends StatefulWidget {
  const UpgradeDowngradeScreen({super.key});

  @override
  State<UpgradeDowngradeScreen> createState() => _UpgradeDowngradeScreenState();
}

enum RenewalPeriod {
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
  twoYears,
  threeYears
}

class _UpgradeDowngradeScreenState extends State<UpgradeDowngradeScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int numberOfDays = 0;
  double costOldPack = 0;
  double costNewPack = 0;
  RenewalPeriod renewal = RenewalPeriod.oneYear;
  double finalMoney = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 236, 236, 236),
          const Color.fromARGB(255, 190, 190, 190)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Αρχική ημερομηνία (συνήθως η σημερινή): ${startDate.day.toString()}/${startDate.month.toString()}/${startDate.year.toString()}',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                IconTextButton(
                  icon: Icons.date_range,
                  text: 'Επιλογή ημερομηνίας',
                  function: datePickFun(isStartDate: true),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Τελική ημερομηνία (συνήθως η ημερομηνία λήξης του πακέτου): ${endDate.day.toString()}/${endDate.month.toString()}/${endDate.year.toString()}',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                IconTextButton(
                  icon: Icons.date_range,
                  text: 'Επιλογή ημερομηνίας',
                  function: datePickFun(isStartDate: false),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ημέρες μεταξύ των δύο ημερομηνιών: ${numberOfDays}',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ο πελάτης είχε κάνει ανανέωση για: ',
                  style: TextStyle(fontSize: 30),
                ),
                DropdownMenu(
                    initialSelection: RenewalPeriod.oneYear,
                    onSelected: (value) {
                      if (value != null) {
                        setState(() {
                          renewal = value;
                        });
                      }
                    },
                    dropdownMenuEntries: <DropdownMenuEntry<RenewalPeriod>>[
                      DropdownMenuEntry(
                          value: RenewalPeriod.oneMonth, label: '1 μήνα'),
                      DropdownMenuEntry(
                          value: RenewalPeriod.threeMonths, label: '3 μήνες'),
                      DropdownMenuEntry(
                          value: RenewalPeriod.sixMonths, label: '6 μήνες'),
                      DropdownMenuEntry(
                          value: RenewalPeriod.oneYear, label: '1 χρόνο'),
                      DropdownMenuEntry(
                          value: RenewalPeriod.twoYears, label: '2 χρόνια'),
                      DropdownMenuEntry(
                          value: RenewalPeriod.threeYears, label: '3 χρόνια'),
                    ])
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Κόστος τρέχοντος πακέτου για ανανέωση για ${getRenewString()}: ',
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    onChanged: (value) {
                      setState(() {
                        value == ''
                            ? costOldPack = 0
                            : costOldPack = double.parse(value);
                      });
                    },
                    controller: textEditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '**',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Κόστος νέου πακέτου για ανανέωση για ${getRenewString()}: ',
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],
                    onChanged: (value) {
                      setState(() {
                        value == ''
                            ? costNewPack = 0
                            : costNewPack = double.parse(value);
                      });
                    },
                    controller: textEditingController2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '**',
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            IconTextButton(
                icon: Icons.calculate,
                text: 'Υπολογισμός ποσού',
                function: () {
                  setState(() {
                    finalMoney = calculateFinal();
                  });
                }),
            SizedBox(
              height: 10,
            ),
            (finalMoney >= 0)
                ? Text(
                    'Το τελικό ποσό πληρωμής είναι: ${finalMoney.toStringAsFixed(2)} €',
                    style: TextStyle(fontSize: 30),
                  )
                : Text(
                    'Θα χρειαστεί να επιστραφεί στον πελάτη το ποσό: ${(-finalMoney).toStringAsFixed(2)} €',
                    style: TextStyle(fontSize: 30),
                  ),
            SizedBox(
              height: 30,
            ),
            Text(
                '*Αν ο πελάτης έχει πληρώσει ανανέωση και αναβάθμιση αθροίζουμε τις δύο παραγγελίες'),
            Text(
                '**Η υποδιαστολή είναι ο χαρακτήρας τελεία "." και όχι το κόμμα'),
            Text(
                'Αν οι τιμές που συμπληρωθούν είναι με ΦΠΑ το αποτέλεσμα θα είναι με το ΦΠΑ και το αντίθετο. Προτείνεται να συμπληρώνονται οι τελικές τιμές'),
          ],
        ),
      ),
    );
  }

  VoidCallback datePickFun({required bool isStartDate}) {
    return () async {
      final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: isStartDate ? startDate : endDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000));
      if (dateTime != null) {
        setState(() {
          isStartDate ? startDate = dateTime : endDate = dateTime;
          numberOfDays = daysBetween(from: startDate, to: endDate);
        });
      }
    };
  }

  int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String getRenewString() {
    switch (renewal) {
      case RenewalPeriod.oneMonth:
        return '1 μήνα';
      case RenewalPeriod.threeMonths:
        return '3 μήνες';
      case RenewalPeriod.sixMonths:
        return '6 μήνες';
      case RenewalPeriod.oneYear:
        return '1 έτος';
      case RenewalPeriod.twoYears:
        return '2 έτη';
      case RenewalPeriod.threeYears:
        return '3 έτη';
    }
  }

  double calculateFinal() {
    print(
        'num of days ${numberOfDays} cost old ${costOldPack} cost new ${costNewPack}');
    double finalAmount = 0;

    int dividedDays = 0;

    switch (renewal) {
      case RenewalPeriod.oneMonth:
        dividedDays = 30;
      case RenewalPeriod.threeMonths:
        dividedDays = 90;
      case RenewalPeriod.sixMonths:
        dividedDays = 180;
      case RenewalPeriod.oneYear:
        dividedDays = 365;
      case RenewalPeriod.twoYears:
        dividedDays = 730;
      case RenewalPeriod.threeYears:
        dividedDays = 1095;
    }

    finalAmount = numberOfDays * ((costNewPack - costOldPack) / dividedDays);
    return finalAmount;
  }
}
