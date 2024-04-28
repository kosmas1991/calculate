import 'package:calculate/widgets/icontextbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VIXscreen extends StatefulWidget {
  const VIXscreen({super.key});

  @override
  State<VIXscreen> createState() => _VIXscreenState();
}

enum RenewalPeriod {
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear,
  twoYears,
  threeYears
}

class _VIXscreenState extends State<VIXscreen> {
  TextEditingController textEditingController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int numberOfDays = 0;
  double moneyClientPaid = 0;
  RenewalPeriod renewal = RenewalPeriod.oneYear;
  double finalMoney = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(60),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 236, 236, 236),
            const Color.fromARGB(255, 190, 190, 190)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
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
              Divider(
                color: Colors.deepPurple,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
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
              Divider(
                color: Colors.deepPurple,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Ημέρες μεταξύ των δύο ημερομηνιών: ${numberOfDays}',
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.deepPurple,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Ποσό που έχει πληρώσει ο πελάτης(το βρίσκουμε στις παραγγελίες*): ',
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
                              ? moneyClientPaid = 0
                              : moneyClientPaid = double.parse(value);
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
                    width: 5,
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
              Divider(
                color: Colors.deepPurple,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
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
              Divider(
                color: Colors.deepPurple,
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
              Text(
                textAlign: TextAlign.center,
                'Το τελικό ποσό είναι: ${finalMoney.toStringAsFixed(2)} €',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                  textAlign: TextAlign.center,
                  '*Αν ο πελάτης έχει πληρώσει ανανέωση και αναβάθμιση αθροίζουμε τις δύο παραγγελίες'),
              Text(
                  textAlign: TextAlign.center,
                  '**Η υποδιαστολή είναι ο χαρακτήρας τελεία "." και όχι το κόμμα'),
              Text(
                  textAlign: TextAlign.center,
                  'Αν οι τιμές που συμπληρωθούν είναι με ΦΠΑ το αποτέλεσμα θα είναι με το ΦΠΑ και το αντίθετο. Προτείνεται να συμπληρώνονται οι τελικές τιμές'),
            ],
          ),
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

  double calculateFinal() {
    double finalAmount = 0;
    double costPerDay = 0;
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

    costPerDay = moneyClientPaid / dividedDays;

    finalAmount = (costPerDay * numberOfDays);

    return finalAmount;
  }
}
