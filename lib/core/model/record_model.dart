class RecordModel {
  String badthought;
  String smartanswer;

  RecordModel(this.badthought, this.smartanswer);

  Map<String, dynamic> toJson() =>
      {'badthought': badthought,
       'smartanswer': smartanswer};
}
