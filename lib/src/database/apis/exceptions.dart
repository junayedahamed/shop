import 'dart:async';
import 'dart:io';

class Exceptions {
  Never handlePostApiException(dynamic e) {
    if (e is SocketException) {
      if (e.osError?.message.contains("Failed host lookup") ?? false) {
        throw "Could not reach the server. Please try again later.";
      }
      throw "Please check your network Connection.";
    } else if (e is TimeoutException) {
      throw "Request timed out. Please try again.";
    } else if (e is FormatException) {
      throw "Invalid response from server.";
    } else {
      throw "Unexpected error occurred. Please try again.";
    }
  }

  Never handleGetApiException(dynamic e) {
    if (e is SocketException) {
      if (e.osError?.message.contains("Failed host lookup") ?? false) {
        throw "Could not reach the server. Please try again later.";
      }
      throw "No internet connection.";
    } else if (e is TimeoutException) {
      throw "Request timed out. Please try again.";
    } else if (e is FormatException) {
      throw "Invalid response from server.";
    } else {
      throw "Unexpected error occurred. Please try again.";
    }
  }

  Never handleDeleteApiException(dynamic e) {
    if (e is SocketException) {
      if (e.osError?.message.contains("Failed host lookup") ?? false) {
        throw "Could not reach the server. Please try again later.";
      }
      throw "Please check your network Connection.";
    } else if (e is TimeoutException) {
      throw "Request timed out. Please try again.";
    } else if (e is FormatException) {
      throw "Invalid response from server.";
    } else {
      throw "Unexpected error occurred. Please try again.";
    }
  }
}
