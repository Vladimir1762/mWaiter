import '../Line.dart';

class ComplexMenuForSelect {
  ComplexMenuForSelect({this.headerComplex, this.complexLines});

  Line? headerComplex;
  ComplexLines? complexLines;
}

class ComplexLines {
  ComplexLines({this.complexLines});
  List<Map<int, Line>>? choiceSelected;
  List<Map<int, List<Line>>>? complexLines;
}


List<Line> selectedComplexToBillLines(ComplexMenuForSelect complexMenuForSelect){
  List<Line> listOfLines =[];
  listOfLines.add(complexMenuForSelect.headerComplex!);
  complexMenuForSelect.complexLines!.choiceSelected!.forEach((element) {
    listOfLines.add(element.values.first);
  });
  return listOfLines;
}