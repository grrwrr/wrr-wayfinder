// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<String>> fetchData() async {
  final headers = {
    'x-ncp-apigw-api-key-id': dotenv.env['NAVER_MAP_CLIENT_ID']!,
    'x-ncp-apigw-api-key': dotenv.env['NAVER_MAP_CLIENT_SECRET']!,
    'Accept': 'application/json',
  };

  http.Response response = await http.get(
      Uri.parse(
          "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=테헤란로 201"),
      headers: headers);

  String jsonData = response.body;

  // Parse the JSON data
  var decodedData = jsonDecode(jsonData);
  List<dynamic> addresses = decodedData['addresses'];
  List<String> roadAddresses =
      addresses.map((address) => address['roadAddress'] as String).toList();

  return roadAddresses;
}

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
      body: Center(
        child: FutureBuilder<List<String>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data found');
            } else {
              // Display the fetched road addresses in a ListView
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]),
                    onTap: () {
                      Navigator.pop(context, snapshot.data![index]);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
