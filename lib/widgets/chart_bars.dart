import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // this Class must build each bar of the chart bars
  final String label;
  final double spendingAmount;
  final double spindingPctOfTotal;

  ChartBar(
    this.label,
    this.spendingAmount,
    this.spindingPctOfTotal,
  );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight *
                  .15, //to set a specific space for the amount
              child: FittedBox(
                //a Widget used to prevent stertching for the amount
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: constrains.maxHeight * .05),
            Container(
              height: constrains.maxHeight * .6,
              width: 18, //controls the width and height of the bars
              child: Stack(
                // Stack build widgets on top of each other
                children: <Widget>[
                  // We need to build an empty bar with grey color and on in build another widget which
                  Container(
                    //fills that bar with only green color
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1), //outside borders of the bars
                      color: Color.fromRGBO(
                          220, 220, 220, 1), //filled color inside the bars
                      borderRadius:
                          BorderRadius.circular(10), // make the bars curved "U"
                    ),
                  ),
                  FractionallySizedBox( 
                    //=> a Widget used to get the full size of its parent and modify it with hightFactor and widthFactor
                    heightFactor: spindingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * .05,
            ),
            Container(
              height: constrains.maxHeight * .15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
