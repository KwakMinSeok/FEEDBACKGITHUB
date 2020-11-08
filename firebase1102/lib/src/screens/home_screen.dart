import 'package:date_format/date_format.dart';
import 'package:firebase1102/src/models/entry.dart';
import 'package:firebase1102/src/providers/entry_provider.dart';
import 'package:firebase1102/src/screens/entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EntryScreen()));
            }),
        appBar: AppBar(
          title: Text('my journal'),
        ),
        body: StreamBuilder<List<Entry>>(
            stream: entryProvider.getentries,
            builder: (BuildContext buildcontext, AsyncSnapshot<List<Entry>> asyncsnapshot) {
              return asyncsnapshot.hasData == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: asyncsnapshot.data.length,
                      itemBuilder: (context, index) => ListTile(
                            trailing: IconButton(icon: Icon(Icons.edit), onPressed:(){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EntryScreen(
                                entry: asyncsnapshot.data[index],
                                listentry: asyncsnapshot.data,
                                // 
                              )));
                            } ),
                            title: Text(formatDate(DateTime.parse(asyncsnapshot.data[index].date), [MM, ' ', d, ', ', yyyy])),
                          ));
            }));
  }
}
