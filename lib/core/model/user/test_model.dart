class TestPoint {
  int point;

  DateTime time;

  TestPoint(this.point, this.time);

  Map<String, dynamic> toJson() => {'point': point, 'time': time};
}
