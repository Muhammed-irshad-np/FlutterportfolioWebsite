String getCurrentTimeinIst() {
  final currenttime = DateTime.now().toUtc();
  const isoffset = Duration(hours: 5, minutes: 30);
  final istTime = currenttime.add(isoffset);
  String formattedTime = '${istTime.hour}:${istTime.minute.toString()}';
  return formattedTime;
}
