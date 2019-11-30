import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medisent/models/donation.dart';

class DonationList extends StatelessWidget {
  final List<Donation> donations;
  final Function deleteD;
  DonationList(this.donations, this.deleteD);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      child: donations.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Donations!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset(
                  'assets/images/Wait.png',
                  fit: BoxFit.cover,
                  height: 100,
                ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text('${donations[index].userName}'),
                        ),
                      ),
                    ),
                    title: Text(
                      donations[index].medName,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(donations[index].exDate)
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: ()=>deleteD(donations[index].id),
                    ),
                  ),
                  
                );
              },
              itemCount: donations.length,
            ),
    );
  }
}
