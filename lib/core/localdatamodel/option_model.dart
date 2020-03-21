import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(FontAwesomeIcons.questionCircle, size: 40.0),
    title: 'Depresyon Testi',
    subtitle: 'Haftalık depresyon takip testi',
  ),
  Option(
    icon: Icon(FontAwesomeIcons.clipboard, size: 40.0),
    title: 'Düşünce Kayıt',
    subtitle: 'Anlık düşünce kayıt sistemi',
  ),
  Option(
    icon: Icon(FontAwesomeIcons.binoculars, size: 40.0),
    title: 'Kayıtlı Düşüncelerim',
    subtitle: 'Düşünce Gözlem Sistemi',
  ),
  Option(
    icon: Icon(FontAwesomeIcons.chartBar, size: 40.0),
    title: 'Grafiksel Takip ',
    subtitle: 'Genel Puan Takip Sistemi',
  ),
  Option(
    icon: Icon(FontAwesomeIcons.pray, size: 40.0),
    title: 'Anksiyete Egzersizleri',
    subtitle: 'Anksiyete Üzerine Çalışmalar',
  ),
  
];