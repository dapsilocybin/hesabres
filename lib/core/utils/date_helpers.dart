// helpers for date parsing (optional)
DateTime? parseDate(dynamic v) {
  if (v == null) return null;
  if (v is DateTime) return v;
  return DateTime.parse(v as String);
}

String? dateToIso(DateTime? d) => d?.toIso8601String();
