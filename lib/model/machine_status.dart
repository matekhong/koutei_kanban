import 'dart:convert';

List<MachineStatus> decodeMachineStatus(String str) {
  return List<MachineStatus>.from(
      json.decode(str)['items'].map((x) => MachineStatus.fromJson(x)));
}

class MachineStatus {
  String? jobno;
  String? partno;
  String? jobnm1;
  String? startdate;
  String? machcode;
  String? status;

  MachineStatus(
      {this.jobno,
      this.partno,
      this.jobnm1,
      this.startdate,
      this.machcode,
      this.status});

  MachineStatus.fromJson(Map<String, dynamic> json) {
    jobno = json['jobno'];
    partno = json['partno'];
    jobnm1 = json['jobnm1'];
    startdate = json['startdate'];
    machcode = json['machcode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jobno'] = jobno;
    data['partno'] = partno;
    data['jobnm1'] = jobnm1;
    data['startdate'] = startdate;
    data['machcode'] = machcode;
    data['status'] = status;
    return data;
  }
}
