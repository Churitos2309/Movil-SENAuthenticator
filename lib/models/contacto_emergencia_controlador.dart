class ContactoEmergenciaControlador {
  String nombreCntEmerg;
  String apellidoCntEmerg;
  String generoCntEmerg;
  int celularCntEmerg;
  int tipoDocumentoCntEmerg;
  int numeroDocumentoCntEmerg;
  String parentezcoCntEmerg;
  int usuarioCntEmerg;

  ContactoEmergenciaControlador(
      this.nombreCntEmerg,
      this.apellidoCntEmerg,
      this.generoCntEmerg,
      this.celularCntEmerg,
      this.tipoDocumentoCntEmerg,
      this.numeroDocumentoCntEmerg,
      this.parentezcoCntEmerg,
      this.usuarioCntEmerg);

  static fromJson(json) {}
}
