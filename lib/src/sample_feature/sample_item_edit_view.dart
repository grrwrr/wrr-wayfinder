// Flutter imports:
import 'package:flutter/material.dart';

/// Displays the edit view for a SampleItem.
class SampleItemEditView extends StatelessWidget {
  const SampleItemEditView({super.key});

  static const routeName = '/sample_item_edit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
