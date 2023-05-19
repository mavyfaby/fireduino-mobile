/// Months
const List<String> months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December'
];

/// Convert DateTime to readable date (ex. January 1, 2023 at 12:00 AM)
String getReadableDate(DateTime datetime, { bool isUtc = true }) {
  // If Utc
  if (isUtc) {
    datetime = datetime.add(const Duration(hours: 8)); // GMT+8
  }

  // Get month
  String month = months[datetime.month - 1];
  // Get day
  String day = datetime.day.toString();
  // Get year
  String year = datetime.year.toString();
  // Get hour
  String hour = datetime.hour.toString();
  // Get minute
  String minute = datetime.minute.toString();
  // Get AM/PM
  String ampm = datetime.hour > 12 ? 'PM' : 'AM';

  // If hour is greater than 12
  if (datetime.hour > 12) {
    // Subtract 12
    hour = (datetime.hour - 12).toString();
  }

  // If hour is 0
  if (datetime.hour == 0) {
    // Set to 12
    hour = '12';
  }

  // If minute is less than 10
  if (datetime.minute < 10) {
    // Add 0
    minute = '0$minute';
  }

  // Return readable date
  return '$month $day, $year at $hour:$minute $ampm';
}

/// Get years from 2020 to current year
List<int> getYears() {
  // Get current year
  int currentYear = DateTime.now().year;

  // Create list
  List<int> years = [];

  // For each year
  for (int year = 2020; year <= currentYear; year++) {
    // Add to list
    years.add(year);
  }

  // Return years
  return years;
}

/// Get time from DateTime (ex. 12:00 AM)
String getTime(DateTime datetime) {
  // If datetime is utc
  if (datetime.isUtc) {
    // Convert to local
    datetime = datetime.toLocal();
  }

  // Get hour
  String hour = datetime.hour.toString();
  // Get minute
  String minute = datetime.minute.toString();
  // Get AM/PM
  String ampm = datetime.hour > 12 ? 'PM' : 'AM';

  // If hour is greater than 12
  if (datetime.hour > 12) {
    // Subtract 12
    hour = (datetime.hour - 12).toString();
  }

  // If hour is 0
  if (datetime.hour == 0) {
    // Set to 12
    hour = '12';
  }

  // If minute is less than 10
  if (datetime.minute < 10) {
    // Add 0
    minute = '0$minute';
  }

  // Return time
  return '$hour:$minute $ampm';
}

/// Get date from DateTime (ex. Mar 1, 2023)
String getDate(DateTime datetime) {
  // If datetime is utc
  if (datetime.isUtc) {
    // Convert to local
    datetime = datetime.toLocal();
  }

  // Get month
  String month = months[datetime.month - 1];
  // Get day
  String day = datetime.day.toString();
  // Get year
  String year = datetime.year.toString();

  // Return date
  return '$month $day, $year';
}