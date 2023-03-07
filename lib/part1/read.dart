import 'dart:io';

Map<String, String> data = {};
main() async {

  //you can give location of any directory , you want details of
  Directory dir = new Directory('D:\\projects\\app\\intern_task_todquest\\lib');


  List<FileSystemEntity> files = dir.listSync(recursive: true);
  var prevChild = files[0].path.split('\\').last.toString();
  var prevParent = files[0].parent.path.split('\\').last;

  //assign first value to map ,just for checking
  data[prevParent] = prevChild;

  //simple for loop
  for (int i = 1; i < files.length; i++) {
    var nextChild = files[i].path.split('\\').last;
    var nextPar = files[i].parent.path.split('\\').last;
    //check if key already present and if so, add the sub folder to its chain of value
    if(data.containsKey(nextPar))
      {
        data[nextPar]="${data[nextPar]} -> ${nextChild}";
      }
    else
      {
        data[nextPar]=nextChild;
      }
  }
  //print the map in given order
  data.forEach((key, value) { 
    print("${key} -> ${value}");
  });

}
