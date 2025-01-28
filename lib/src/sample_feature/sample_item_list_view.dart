import 'package:flutter/material.dart';
import 'sample_item_edit_view.dart';
import 'sample_item_details_view.dart';

class SampleItemListView extends StatefulWidget {
  const SampleItemListView({super.key});

  static const routeName = '/sample_item_list';

  @override
  SampleItemListViewState createState() => SampleItemListViewState();
}

class SampleItemListViewState extends State<SampleItemListView> {
  List<String?> items = List<String?>.filled(10, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Item List'),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text(item ?? '+'),
            leading: const CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () async {
              // Navigate to the edit page and get the result.
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SampleItemEditView()),
              );

              if (result != null) {
                setState(() {
                  items[index] = result;
                });
              }
            },
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                // Handle edit action here
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SampleItemEditView()),
                );

                if (result != null) {
                  setState(() {
                    items[index] = result;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }
}
