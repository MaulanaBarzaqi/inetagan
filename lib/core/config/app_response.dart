import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inetagan/core/errors/exceptions.dart';

class AppResponse {
  static Map<String, dynamic> data(Response response) {
    DMethod.printResponse(response);

    switch (response.statusCode) {
      case 200: //read
      case 201: //create, update
        var responseBody = jsonDecode(response.body);
        return responseBody;
      case 204: //delete
        return {'success': true};
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException(response.body);
      case 422:
        throw ForbiddenException(response.body);
      case 403:
        throw InvalidInputException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 500:
        throw ServerException(response.body);
      default:
        throw FetchFailureException(response.body);
    }
  }

  static invalidInput(BuildContext context, String messageBody) {
    Map errors = jsonDecode(messageBody)['errors'];
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
