import 'package:flutter/widgets.dart';

class ErrorModel {
  final String? status;
  final int? statusCode;
  final String message;
  final bool? isOperational;
  final IconData? icon;
  final String? stack;

  const ErrorModel({
    this.status,
    this.statusCode,
    required this.message,
    this.isOperational,
    this.icon,
    this.stack,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    // Check if the response has an "errors" array (field validation errors)
    if (json.containsKey('errors') && json['errors'] is List) {
      final errors = json['errors'] as List;
      if (errors.isNotEmpty) {
        final firstError = errors.first as Map<String, dynamic>;
        // Extract the message from the first error in the array
        final message = firstError['msg'] as String? ?? 'Validation error';
        return ErrorModel(
          status: 'fail',
          statusCode: 400,
          message: message,
          isOperational: true,
        );
      }
    }

    // Handle the original error format
    final error = json['error'] as Map<String, dynamic>?;

    return ErrorModel(
      status: json['status'],
      statusCode: error?['status_code'],
      message: json['status_message'] ?? 'An unexpected error occurred',
      isOperational: error?['isOperational'],
      stack: json['stack'],
    );
  }

  ErrorModel copyWith({
    String? status,
    int? statusCode,
    String? message,
    bool? isOperational,
    IconData? icon,
    String? stack,
  }) {
    return ErrorModel(
      status: status ?? this.status,
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      isOperational: isOperational ?? this.isOperational,
      icon: icon ?? this.icon,
      stack: stack ?? this.stack,
    );
  }

  @override
  String toString() {
    return 'ErrorModel(status: $status, statusCode: $statusCode, message: $message, isOperational: $isOperational, stack: $stack)';
  }
}
