class HelpModel {
  String? message;
  List<HelpData>? data;
  String? status;

  HelpModel({this.message, this.data, this.status});

  HelpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <HelpData>[];
      json['data'].forEach((v) {
        data!.add(HelpData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class HelpData {
  int? helpId;
  String? helpQuestion;
  String? helpAnswer;

  HelpData({this.helpId, this.helpQuestion, this.helpAnswer});

  HelpData.fromJson(Map<String, dynamic> json) {
    helpId = json['help_id'];
    helpQuestion = json['help_question'];
    helpAnswer = json['help_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['help_id'] = helpId;
    data['help_question'] = helpQuestion;
    data['help_answer'] = helpAnswer;
    return data;
  }
}
