// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Next Tennis';

  @override
  String get navTournaments => 'Torneos';

  @override
  String get navRankings => 'Rankings';

  @override
  String get navAcademies => 'Academias';

  @override
  String get navRegistrations => 'Inscripciones';

  @override
  String get navSchedule => 'Calendario';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navLogin => 'Login';

  @override
  String get routeNotFound => 'Ruta no encontrada';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonNoMoreItems => 'No hay mas elementos';

  @override
  String get commonLoadMore => 'Cargar mas';

  @override
  String get commonRequestId => 'id_solicitud';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonRequired => 'Campo obligatorio';

  @override
  String get authGuardRedirectingMessage =>
      'Se requiere iniciar sesion. Redirigiendo...';

  @override
  String get statusUnknown => 'Desconocido';

  @override
  String get statusRegistrationOpen => 'Inscripciones abiertas';

  @override
  String get statusRegistrationClosed => 'Inscripciones cerradas';

  @override
  String get statusInProgress => 'En progreso';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get statusCancelled => 'Cancelado';

  @override
  String get statusRejected => 'Rechazado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusPaid => 'Pagado';

  @override
  String get statusRefunded => 'Reembolsado';

  @override
  String get statusWaived => 'Exonerado';

  @override
  String get statusActive => 'Activo';

  @override
  String get statusPast => 'Finalizado';

  @override
  String get statusScheduled => 'Programado';

  @override
  String get statusDraftScheduled => 'Programacion borrador';

  @override
  String get statusWalkover => 'Walkover';

  @override
  String get statusPostponed => 'Aplazado';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileErrorLoading => 'No se pudo cargar el perfil';

  @override
  String get profileFirstName => 'Nombre';

  @override
  String get profileLastName => 'Apellido';

  @override
  String get profileDisplayName => 'Nombre visible';

  @override
  String get profilePhone => 'Telefono';

  @override
  String get profileSave => 'Guardar perfil';

  @override
  String get profileSavedMessage =>
      'Solicitud de actualizacion de perfil enviada';

  @override
  String get tournamentsTitle => 'Torneos';

  @override
  String get tournamentsSearchHint => 'Buscar torneos';

  @override
  String get tournamentsErrorLoading => 'No se pudieron cargar los torneos';

  @override
  String get tournamentsEmpty => 'No se encontraron torneos';

  @override
  String get tournamentsUnknownVenue => 'Sede no disponible';

  @override
  String get tournamentDetailTitle => 'Detalle del torneo';

  @override
  String get tournamentNoDescription => 'Sin descripcion.';

  @override
  String tournamentVenue(Object venue) {
    return 'Sede: $venue';
  }

  @override
  String get tournamentVenueNotSpecified => 'No especificada';

  @override
  String get tournamentRegisterNow => 'Inscribirme ahora';

  @override
  String get tournamentViewSchedule => 'Ver calendario';

  @override
  String get tournamentCreateRegistration => 'Crear inscripcion';

  @override
  String get tournamentCategoryId => 'Id de categoria del torneo';

  @override
  String get tournamentRegister => 'Inscribirse';

  @override
  String get registrationsTitle => 'Mis inscripciones';

  @override
  String get registrationsSearchHint => 'Buscar referencia de pago';

  @override
  String get registrationsErrorLoading =>
      'No se pudieron cargar las inscripciones';

  @override
  String get registrationsEmpty => 'No se encontraron inscripciones';

  @override
  String get registrationsWithdrawTitle => 'Retirar inscripcion';

  @override
  String get registrationsWithdrawConfirm =>
      'Esta accion es destructiva. Deseas continuar?';

  @override
  String get registrationsWithdraw => 'Retirar';

  @override
  String registrationsItemTitle(Object id) {
    return 'Inscripcion #$id';
  }

  @override
  String registrationsCategory(Object category) {
    return 'Categoria: $category';
  }

  @override
  String get feedbackRegistrationCreated => 'Inscripcion creada';

  @override
  String get feedbackRegistrationConflict =>
      'Conflicto: inscripcion duplicada o categoria llena.';

  @override
  String get feedbackRegistrationRuleViolation =>
      'Regla de negocio: la ventana de inscripcion esta cerrada.';

  @override
  String get feedbackRegistrationWithdrawn => 'Inscripcion retirada';

  @override
  String get feedbackRegistrationCannotWithdraw =>
      'No se puede retirar en el estado actual del torneo.';

  @override
  String get scheduleMyTitle => 'Mi calendario';

  @override
  String get scheduleMySearchHint => 'Buscar por cancha, ronda o marcador';

  @override
  String get scheduleErrorLoading => 'No se pudo cargar el calendario';

  @override
  String get scheduleMyEmpty => 'No hay partidos programados';

  @override
  String get scheduleTournamentTitle => 'Calendario del torneo';

  @override
  String get scheduleTournamentSearchHint => 'Buscar por ronda o cancha';

  @override
  String get scheduleTournamentEmpty =>
      'No se encontraron entradas en el calendario';

  @override
  String get scheduleVisibilityRestricted =>
      'La visibilidad del calendario esta restringida para tu cuenta.';

  @override
  String get scheduleNotFound => 'No se encontro el calendario del torneo.';

  @override
  String get scheduleRoundUnknown => 'Ronda no disponible';

  @override
  String get scheduleCourtTbd => 'Cancha por definir';

  @override
  String get loginTitle => 'Iniciar sesion';

  @override
  String get loginEmail => 'Correo electronico';

  @override
  String get loginPassword => 'Contrasena';

  @override
  String get loginSubmit => 'Ingresar';

  @override
  String get loginSubmitting => 'Ingresando...';

  @override
  String get loginInvalidEmail => 'Correo invalido';

  @override
  String get loginInvalidSession =>
      'No se pudo validar la sesion. Intenta nuevamente.';

  @override
  String get rankingsTitle => 'Rankings';

  @override
  String get rankingsSearchHint => 'Buscar rankings';

  @override
  String get rankingsErrorLoading => 'No se pudieron cargar los rankings';

  @override
  String get rankingsEmpty => 'No se encontraron rankings';

  @override
  String get rankingsDetailTitle => 'Detalle del ranking';

  @override
  String get rankingsTypeLabel => 'Tipo';

  @override
  String get rankingsCategoryLabel => 'Categoria';

  @override
  String get rankingsEntriesTitle => 'Entradas';

  @override
  String get academiesTitle => 'Academias';

  @override
  String get academiesSearchHint => 'Buscar academias';

  @override
  String get academiesErrorLoading => 'No se pudieron cargar las academias';

  @override
  String get academiesEmpty => 'No se encontraron academias';

  @override
  String get academiesDetailTitle => 'Detalle de academia';

  @override
  String get academiesUnknownLocation => 'Ubicacion no disponible';

  @override
  String get academiesEmailLabel => 'Email';

  @override
  String get academiesPhoneLabel => 'Telefono';

  @override
  String get academiesAddressLabel => 'Direccion';

  @override
  String get errorSessionExpired =>
      'Tu sesion expiro. Inicia sesion nuevamente.';

  @override
  String get errorForbidden => 'No tienes acceso a este recurso.';

  @override
  String get errorNotFound => 'Recurso no encontrado.';

  @override
  String get errorConflict =>
      'La accion entra en conflicto con el estado actual.';

  @override
  String get errorBusinessRule => 'Esta accion viola una regla de negocio.';

  @override
  String get errorValidation => 'Los datos enviados no son validos.';

  @override
  String get errorInvalidResponse => 'Formato de respuesta API invalido';

  @override
  String get errorUnknownApi => 'Error de API desconocido';
}
