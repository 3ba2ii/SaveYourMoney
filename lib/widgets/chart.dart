import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/chart_bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

//This class must build this Tree 

//       Card 
//       /  
//      Row
//        \
//         Column
//        /   /  \
//     Amount Bar Day  
// p.s: this class 


  final List<Transaction> recentTransactions; //we need to recieve the transaction list of <Transaction>

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions { //Generating 7 maps of just the recent 7 days
    return List.generate(7, (index) { 
      final weekDay = DateTime.now().subtract(Duration(days: index)); //NowTime (D,M,Y,H) -Days 
                                                                      //(if days :0 then it's friday if days:1 then it's thursday) 
      double totalSum = 0; 

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].price;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1), //returning a Map,i.e {'day':'F','amount: 99.99} for each day
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending { 
    return groupedTransactions.fold(0.0, (sum, item) { // fold=>reduces a collection for a single Value 
      return sum + item['amount'];                     //takes each item of the List and added it into sum
    });                                                // return the total sum of all transactions
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:EdgeInsets.all(20), 
      elevation: 6,
      child: Padding( 
        padding:EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,//to put some space around each bar 
          children: groupedTransactions.map( // to work on all the maps' elements map((function){return widget "you wanna build"}
            (data) {
              return Flexible(    //Flexible => a widget that controls the space each column can occupy
                fit: FlexFit.tight, 
                child: ChartBar( // Another Class that recieves the day ,amount , percentage 
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0 //to eleminate the error of dividing by zero if no transaction added 
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            },
          ).toList(), //Row get inpur as a list 
        ),
      ),
    );
  }
}
