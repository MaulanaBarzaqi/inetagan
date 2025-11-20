import 'dart:convert';
import 'package:flutter/material.dart';

class DialogHelper {
  static void showInvalidInputDialog(BuildContext context, String messageBody) {
    Map<String, dynamic> errors = jsonDecode(messageBody)['errors'];
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          title: Text("Invalid Input"),
          children: [
            ...errors.entries.map((e) {
              return ListTile(
                title: Text(e.key),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (e.value as List).map((itemError) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("- "),
                        Expanded(child: Text(itemError.toString())),
                      ],
                    );
                  }).toList(),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("tutup"),
              ),
            ),
          ],
        );
      },
    );
  }
}
