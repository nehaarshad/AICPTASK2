

import 'package:hive/hive.dart';

import 'favoritequotes.dart';

class Boxes
{
  static Box<favoritequotes> getData()=>Hive.box("favorite quotes ");
}