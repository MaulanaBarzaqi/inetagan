import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inetagan/core/errors/exceptions.dart';

class AppResponse {
  static Map<String, dynamic> data(Response response) {
    DMethod.printResponse(response);
    final statusCode = response.statusCode;
    final responseBody = response.body;

    switch (statusCode) {
      case 200: //read
      case 201: //create, update
        return jsonDecode(responseBody);
      case 204: //delete
        return {'success': true};
      case 400:
        throw BadRequestException(_extractErrorMessage(responseBody));
      case 401:
        throw UnauthorisedException(_extractErrorMessage(responseBody));
      case 422:
        throw ForbiddenException(_extractErrorMessage(responseBody));
      case 403:
        throw InvalidInputException(_extractErrorMessage(responseBody));
      case 404:
        throw NotFoundException(_extractErrorMessage(responseBody));
      case 500:
        throw ServerException(_extractErrorMessage(responseBody));
      default:
        throw FetchFailureException('Unexpected error: $statusCode');
    }
  }

  static String _extractErrorMessage(String responseBody) {
    try {
      final json = jsonDecode(responseBody);
      return json['message'] ?? json['error'] ?? responseBody;
    } catch (e) {
      return responseBody;
    }
  }

  static invalidInput(BuildContext context, String messageBody) {
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
                  children: (e.value as List).map((itemError) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("- "),
                        Expanded(child: Text(itemError)),
                      ],
                    );
                  }).toList(),
                ),
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("close"),
              ),
            ),
          ],
        );
      },
    );
  }
}
