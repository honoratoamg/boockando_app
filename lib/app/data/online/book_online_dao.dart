import 'dart:convert';

import 'package:boockando_app/app/data/online/consts/consts.dart';
import 'package:boockando_app/app/models/book.dart';
import 'package:http/http.dart' as server;

class BookOnlineDao {
  /// GET a book from the json-server a book with id
  Future<Book> getBook({bookId}) async {
    final response = await server.get("$URL_BOOK/$bookId");

    if (response.statusCode == 200) {
      //200 OK response
      return Book.fromJson(map: jsonDecode(response.body));
    } else {
      // 200 Fail response
      throw Exception('Failed to load the book');
    }
  }

  /// GET all books from json-server
  Future<List<Book>> getBooks() async {
    final response = await server.get(URL_BOOK);

    //200 OK response
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final books = (jsonResponse as List)
          .map((data) => Book.fromJson(map: data))
          .toList();
      return books;
    } else {
      // 200 Fail response
      throw Exception('Failed to get all books');
    }
  }

  /// POST a book to the json-server
  Future<int> postBook({Book book}) async {
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode(book.toJson());
    final response = await server.post(URL_BOOK, body: body, headers: headers);
    final jsonResponse = jsonDecode(response.body);

    return jsonResponse['idBook'];
  }

  /// PUT a book from json-server
  Future<Book> putBook({Book book}) async {
    final response = await server.put(
      '$URL_BOOK/${book.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(book.toJson()),
    );

    if (response.statusCode == 200) {
      //200 Updated response
      return Book.fromJson(map: jsonDecode(response.body));
    } else {
      //200 failed on updated response
      throw Exception('Failed to update a book');
    }
  }

  /// Delete a book from json-server
  Future<server.Response> RemoveBook({int idBook}) async {
    final response = await server.delete(
      '$URL_BOOK/$idBook',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // 200 Ok response
    if (response.statusCode == 200) {
      return response;
    } else {
      // 200 Fail response
      throw Exception('Failed to delete a book');
    }
  }
}
