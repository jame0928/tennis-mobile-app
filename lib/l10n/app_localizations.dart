import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Next Tennis'**
  String get appTitle;

  /// No description provided for @navTournaments.
  ///
  /// In en, this message translates to:
  /// **'Torneos'**
  String get navTournaments;

  /// No description provided for @navRegistrations.
  ///
  /// In en, this message translates to:
  /// **'Inscripciones'**
  String get navRegistrations;

  /// No description provided for @navSchedule.
  ///
  /// In en, this message translates to:
  /// **'Calendario'**
  String get navSchedule;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Ruta no encontrada'**
  String get routeNotFound;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// No description provided for @commonNoMoreItems.
  ///
  /// In en, this message translates to:
  /// **'No hay mas elementos'**
  String get commonNoMoreItems;

  /// No description provided for @commonLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Cargar mas'**
  String get commonLoadMore;

  /// No description provided for @commonRequestId.
  ///
  /// In en, this message translates to:
  /// **'id_solicitud'**
  String get commonRequestId;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'Campo obligatorio'**
  String get commonRequired;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Desconocido'**
  String get statusUnknown;

  /// No description provided for @statusRegistrationOpen.
  ///
  /// In en, this message translates to:
  /// **'Inscripciones abiertas'**
  String get statusRegistrationOpen;

  /// No description provided for @statusRegistrationClosed.
  ///
  /// In en, this message translates to:
  /// **'Inscripciones cerradas'**
  String get statusRegistrationClosed;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'En progreso'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completado'**
  String get statusCompleted;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelado'**
  String get statusCancelled;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rechazado'**
  String get statusRejected;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pendiente'**
  String get statusPending;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Pagado'**
  String get statusPaid;

  /// No description provided for @statusRefunded.
  ///
  /// In en, this message translates to:
  /// **'Reembolsado'**
  String get statusRefunded;

  /// No description provided for @statusWaived.
  ///
  /// In en, this message translates to:
  /// **'Exonerado'**
  String get statusWaived;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Activo'**
  String get statusActive;

  /// No description provided for @statusPast.
  ///
  /// In en, this message translates to:
  /// **'Finalizado'**
  String get statusPast;

  /// No description provided for @statusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Programado'**
  String get statusScheduled;

  /// No description provided for @statusDraftScheduled.
  ///
  /// In en, this message translates to:
  /// **'Programacion borrador'**
  String get statusDraftScheduled;

  /// No description provided for @statusWalkover.
  ///
  /// In en, this message translates to:
  /// **'Walkover'**
  String get statusWalkover;

  /// No description provided for @statusPostponed.
  ///
  /// In en, this message translates to:
  /// **'Aplazado'**
  String get statusPostponed;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @profileErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'No se pudo cargar el perfil'**
  String get profileErrorLoading;

  /// No description provided for @profileFirstName.
  ///
  /// In en, this message translates to:
  /// **'Nombre'**
  String get profileFirstName;

  /// No description provided for @profileLastName.
  ///
  /// In en, this message translates to:
  /// **'Apellido'**
  String get profileLastName;

  /// No description provided for @profileDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Nombre visible'**
  String get profileDisplayName;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Telefono'**
  String get profilePhone;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Guardar perfil'**
  String get profileSave;

  /// No description provided for @profileSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Solicitud de actualizacion de perfil enviada'**
  String get profileSavedMessage;

  /// No description provided for @tournamentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Torneos'**
  String get tournamentsTitle;

  /// No description provided for @tournamentsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Buscar torneos'**
  String get tournamentsSearchHint;

  /// No description provided for @tournamentsErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'No se pudieron cargar los torneos'**
  String get tournamentsErrorLoading;

  /// No description provided for @tournamentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No se encontraron torneos'**
  String get tournamentsEmpty;

  /// No description provided for @tournamentsUnknownVenue.
  ///
  /// In en, this message translates to:
  /// **'Sede no disponible'**
  String get tournamentsUnknownVenue;

  /// No description provided for @tournamentDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Detalle del torneo'**
  String get tournamentDetailTitle;

  /// No description provided for @tournamentNoDescription.
  ///
  /// In en, this message translates to:
  /// **'Sin descripcion.'**
  String get tournamentNoDescription;

  /// No description provided for @tournamentVenue.
  ///
  /// In en, this message translates to:
  /// **'Sede: {venue}'**
  String tournamentVenue(Object venue);

  /// No description provided for @tournamentVenueNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'No especificada'**
  String get tournamentVenueNotSpecified;

  /// No description provided for @tournamentRegisterNow.
  ///
  /// In en, this message translates to:
  /// **'Inscribirme ahora'**
  String get tournamentRegisterNow;

  /// No description provided for @tournamentViewSchedule.
  ///
  /// In en, this message translates to:
  /// **'Ver calendario'**
  String get tournamentViewSchedule;

  /// No description provided for @tournamentCreateRegistration.
  ///
  /// In en, this message translates to:
  /// **'Crear inscripcion'**
  String get tournamentCreateRegistration;

  /// No description provided for @tournamentCategoryId.
  ///
  /// In en, this message translates to:
  /// **'Id de categoria del torneo'**
  String get tournamentCategoryId;

  /// No description provided for @tournamentRegister.
  ///
  /// In en, this message translates to:
  /// **'Inscribirse'**
  String get tournamentRegister;

  /// No description provided for @registrationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Mis inscripciones'**
  String get registrationsTitle;

  /// No description provided for @registrationsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Buscar referencia de pago'**
  String get registrationsSearchHint;

  /// No description provided for @registrationsErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'No se pudieron cargar las inscripciones'**
  String get registrationsErrorLoading;

  /// No description provided for @registrationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No se encontraron inscripciones'**
  String get registrationsEmpty;

  /// No description provided for @registrationsWithdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Retirar inscripcion'**
  String get registrationsWithdrawTitle;

  /// No description provided for @registrationsWithdrawConfirm.
  ///
  /// In en, this message translates to:
  /// **'Esta accion es destructiva. Deseas continuar?'**
  String get registrationsWithdrawConfirm;

  /// No description provided for @registrationsWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Retirar'**
  String get registrationsWithdraw;

  /// No description provided for @registrationsItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Inscripcion #{id}'**
  String registrationsItemTitle(Object id);

  /// No description provided for @registrationsCategory.
  ///
  /// In en, this message translates to:
  /// **'Categoria: {category}'**
  String registrationsCategory(Object category);

  /// No description provided for @feedbackRegistrationCreated.
  ///
  /// In en, this message translates to:
  /// **'Inscripcion creada'**
  String get feedbackRegistrationCreated;

  /// No description provided for @feedbackRegistrationConflict.
  ///
  /// In en, this message translates to:
  /// **'Conflicto: inscripcion duplicada o categoria llena.'**
  String get feedbackRegistrationConflict;

  /// No description provided for @feedbackRegistrationRuleViolation.
  ///
  /// In en, this message translates to:
  /// **'Regla de negocio: la ventana de inscripcion esta cerrada.'**
  String get feedbackRegistrationRuleViolation;

  /// No description provided for @feedbackRegistrationWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Inscripcion retirada'**
  String get feedbackRegistrationWithdrawn;

  /// No description provided for @feedbackRegistrationCannotWithdraw.
  ///
  /// In en, this message translates to:
  /// **'No se puede retirar en el estado actual del torneo.'**
  String get feedbackRegistrationCannotWithdraw;

  /// No description provided for @scheduleMyTitle.
  ///
  /// In en, this message translates to:
  /// **'Mi calendario'**
  String get scheduleMyTitle;

  /// No description provided for @scheduleMySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Buscar por cancha, ronda o marcador'**
  String get scheduleMySearchHint;

  /// No description provided for @scheduleErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'No se pudo cargar el calendario'**
  String get scheduleErrorLoading;

  /// No description provided for @scheduleMyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No hay partidos programados'**
  String get scheduleMyEmpty;

  /// No description provided for @scheduleTournamentTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendario del torneo'**
  String get scheduleTournamentTitle;

  /// No description provided for @scheduleTournamentSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Buscar por ronda o cancha'**
  String get scheduleTournamentSearchHint;

  /// No description provided for @scheduleTournamentEmpty.
  ///
  /// In en, this message translates to:
  /// **'No se encontraron entradas en el calendario'**
  String get scheduleTournamentEmpty;

  /// No description provided for @scheduleVisibilityRestricted.
  ///
  /// In en, this message translates to:
  /// **'La visibilidad del calendario esta restringida para tu cuenta.'**
  String get scheduleVisibilityRestricted;

  /// No description provided for @scheduleNotFound.
  ///
  /// In en, this message translates to:
  /// **'No se encontro el calendario del torneo.'**
  String get scheduleNotFound;

  /// No description provided for @scheduleRoundUnknown.
  ///
  /// In en, this message translates to:
  /// **'Ronda no disponible'**
  String get scheduleRoundUnknown;

  /// No description provided for @scheduleCourtTbd.
  ///
  /// In en, this message translates to:
  /// **'Cancha por definir'**
  String get scheduleCourtTbd;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Tu sesion expiro. Inicia sesion nuevamente.'**
  String get errorSessionExpired;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'No tienes acceso a este recurso.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Recurso no encontrado.'**
  String get errorNotFound;

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'La accion entra en conflicto con el estado actual.'**
  String get errorConflict;

  /// No description provided for @errorBusinessRule.
  ///
  /// In en, this message translates to:
  /// **'Esta accion viola una regla de negocio.'**
  String get errorBusinessRule;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Los datos enviados no son validos.'**
  String get errorValidation;

  /// No description provided for @errorInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'Formato de respuesta API invalido'**
  String get errorInvalidResponse;

  /// No description provided for @errorUnknownApi.
  ///
  /// In en, this message translates to:
  /// **'Error de API desconocido'**
  String get errorUnknownApi;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
