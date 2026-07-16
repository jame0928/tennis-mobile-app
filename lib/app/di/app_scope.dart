import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../core/auth/in_memory_token_provider.dart';
import '../../core/config/app_environment.dart';
import '../../core/network/api_client.dart';
import '../../core/network/error_mapper.dart';
import '../../core/telemetry/safe_telemetry.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/profile_controller.dart';
import '../../features/registrations/data/datasources/registration_remote_data_source.dart';
import '../../features/registrations/data/repositories/registration_repository_impl.dart';
import '../../features/registrations/domain/usecases/create_registration.dart';
import '../../features/registrations/domain/usecases/list_my_registrations.dart';
import '../../features/registrations/domain/usecases/withdraw_registration.dart';
import '../../features/registrations/presentation/registrations_controller.dart';
import '../../features/schedule/data/datasources/schedule_remote_data_source.dart';
import '../../features/schedule/data/repositories/schedule_repository_impl.dart';
import '../../features/schedule/domain/usecases/list_my_schedule.dart';
import '../../features/schedule/domain/usecases/list_tournament_schedule.dart';
import '../../features/schedule/presentation/schedule_controller.dart';
import '../../features/tournaments/data/datasources/tournament_remote_data_source.dart';
import '../../features/tournaments/data/repositories/tournament_repository_impl.dart';
import '../../features/tournaments/domain/usecases/get_tournament_detail.dart';
import '../../features/tournaments/domain/usecases/list_tournaments.dart';
import '../../features/tournaments/presentation/tournaments_controller.dart';

class AppScope extends StatelessWidget {
  const AppScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokenProvider = InMemoryTokenProvider(initialToken: 'demo-token');
    final telemetry = SafeTelemetry();
    final errorMapper = ErrorMapper();
    final apiClient = ApiClient(
      baseUrl: AppEnvironment.baseUrl,
      httpClient: http.Client(),
      tokenProvider: tokenProvider,
      telemetry: telemetry,
    );

    final profileRepo = ProfileRepositoryImpl(
      ProfileRemoteDataSource(apiClient),
    );
    final tournamentRepo = TournamentRepositoryImpl(
      TournamentRemoteDataSource(apiClient),
    );
    final registrationRepo = RegistrationRepositoryImpl(
      RegistrationRemoteDataSource(apiClient),
    );
    final scheduleRepo = ScheduleRepositoryImpl(
      ScheduleRemoteDataSource(apiClient),
    );

    return MultiProvider(
      providers: [
        Provider<ErrorMapper>.value(value: errorMapper),
        ChangeNotifierProvider(
          create: (_) => ProfileController(
            getProfile: GetProfile(profileRepo),
            updateProfile: UpdateProfile(profileRepo),
            errorMapper: errorMapper,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TournamentsController(
            listTournaments: ListTournaments(tournamentRepo),
            getTournamentDetail: GetTournamentDetail(tournamentRepo),
            errorMapper: errorMapper,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RegistrationsController(
            createRegistration: CreateRegistration(registrationRepo),
            listMyRegistrations: ListMyRegistrations(registrationRepo),
            withdrawRegistration: WithdrawRegistration(registrationRepo),
            errorMapper: errorMapper,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleController(
            listMySchedule: ListMySchedule(scheduleRepo),
            listTournamentSchedule: ListTournamentSchedule(scheduleRepo),
            errorMapper: errorMapper,
          ),
        ),
      ],
      child: child,
    );
  }
}
