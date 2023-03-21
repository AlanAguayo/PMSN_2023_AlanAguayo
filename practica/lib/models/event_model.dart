class EventModel {
  int? idEvento;
  String? dscEvento;
  String? dateEvento;
  int? completado;

  EventModel({this.idEvento, this.dscEvento, this.dateEvento, this.completado});

  //Constructor nombrado
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      idEvento: map['idEvento'],
      dscEvento: map['dscEvento'],
      dateEvento: map['fechaEvento'],
      completado: map['completado'],
    );
  }
}
