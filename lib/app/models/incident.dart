class IncidentReport {
  final int iid;
  final int? rid;
  final String deptName;
  final int smsID;
  final String deviceName;
  final String? userName;
  final String? cause;
  final DateTime idate;
  final DateTime? rdate;

  IncidentReport({
    required this.iid,
    required this.deptName,
    required this.smsID,
    required this.deviceName,
    required this.idate,
    this.rid,
    this.userName,
    this.cause,
    this.rdate,
  });

  factory IncidentReport.fromJson(Map<String, dynamic> json) {
    return IncidentReport(
      iid: json['iid'],
      rid: json['rid'],
      deptName: json['dept_name'],
      smsID: json['sms_id'],
      deviceName: json['device_name'],
      userName: json['user_name'],
      cause: json['cause'],
      idate: DateTime.parse(json['idate']),
      rdate: json['rdate'] == null ? null : DateTime.parse(json['rdate']),
    );
  }

  Map<String, dynamic> toJson() => {
    'iid': iid,
    'rid': rid,
    'dept_name': deptName,
    'sms_id': smsID,
    'device_name': deviceName,
    'user_name': userName,
    'cause': cause,
    'idate': idate,
    'rdate': rdate,
  };
}