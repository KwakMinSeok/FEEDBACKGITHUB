import 'package:date_format/date_format.dart';
import 'package:firebase1102/src/models/entry.dart';
import 'package:firebase1102/src/providers/entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatefulWidget {
  final Entry entry;
  EntryScreen({this.entry,this.listentry});
  final List<Entry> listentry;
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final entryController = TextEditingController();
  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<EntryProvider>(context, listen: false);
    if (widget.entry != null) {
      entryController.text = widget.entry.entry;
      entryProvider.loadAll(widget.entry);
    } else {
      entryProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<EntryProvider>(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _pickDate(context).then((value) async{
                    if (value != null) {
                      entryProvider.changeDate = value;
                    }
                    //
                    //entryProvider.changeorder(widget.listentry);
                  });
                })
          ],
          title:
              Text(formatDate(entryProvider.getdate, [MM, ' ', d, ', ', yyyy])),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                onChanged: (String value) {
                  entryProvider.changeEntry = value;
                },
                controller: entryController,
                maxLines: 12,
                minLines: 10,
                decoration: InputDecoration(
                  labelText: 'daily entry',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: RaisedButton(
                onPressed: () async{
                  entryProvider.saveEntry();
                  //
                  //entryProvider.changeorder(widget.listentry);
                  Navigator.of(context).pop();
                },
                color: Colors.amber,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: (widget.entry != null)
                  ? RaisedButton(
                      onPressed: () async{
                        entryProvider
                            .removeEntry(widget.entry.entryId.toString());
                            //
                      // entryProvider.changeorder(widget.listentry);    
                        Navigator.of(context).pop();
                        
                      },
                      color: Colors.pink[200],
                      child: Text(
                        'delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),
            ),
          ],
        ));
  }

  Future<DateTime> _pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2050));
    if (picked != null) {
      return picked;
    }
  }
}
