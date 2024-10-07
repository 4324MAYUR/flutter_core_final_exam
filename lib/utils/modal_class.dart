import 'dart:io';

class Global {
  static String name = 'name';
  static String gr_id = 'gr_id';
  static String standard = 'standard';
  static File? image;
}

class Modal {
  final String name;
  final String gr_id;
  final String standard;
  final File? image;

  Modal(
      {required this.name,
        required this.gr_id,
        required this.standard,
        required this.image});
}

List<Modal> studentDetails = [];