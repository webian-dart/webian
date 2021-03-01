final DateTime emptyDateTime = DateTime.now();
extension DateTimeExtensions on DateTime {
    bool get isNotEmpty => this != emptyDateTime;
}