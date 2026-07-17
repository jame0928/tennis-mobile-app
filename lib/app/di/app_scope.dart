import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../core/auth/auth_controller.dart';
import '../../core/auth/secure_token_provider.dart';
import '../../core/config/app_environment.dart';
import '../../core/network/api_client.dart';
import '../../core/network/error_mapper.dart';
import '../../core/telemetry/safe_telemetry.dart';
import '../../features/academies/data/datasources/academy_remote_data_source.dart';
import '../../features/academies/data/repositories/academy_repository_impl.dart';
import '../../features/academies/domain/usecases/get_academy_detail.dart';
import '../../features/academies/domain/usecases/list_academies.dart';
import '../../features/academies/presentation/academies_controller.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/presentation/auth_controller.dart' as auth_presentation;
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/profile_controller.dart';
import '../../features/rankings/data/datasources/ranking_remote_data_source.dart';
import '../../features/rankings/data/repositories/ranking_repository_impl.dart';
import '../../features/rankings/domain/usecases/get_ranking_detail.dart';
import '../../features/rankings/domain/usecases/list_rankings.dart';
import '../../features/rankings/presentation/rankings_controller.dart';
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
    final tokenProvider = SecureTokenProvider();
    final sessionController = AuthController(tokenProvider: tokenProvider);
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
    final authRepo = AuthRepositoryImpl(AuthRemoteDataSource(apiClient));
    final rankingsRepo = RankingRepositoryImpl(
      RankingRemoteDataSource(apiClient),
    );
    final academiesRepo = AcademyRepositoryImpl(
      AcademyRemoteDataSource(apiClient),
    );

    sessionController.initialize();

    return MultiProvider(
      providers: [
        Provider<ErrorMapper>.value(value: errorMapper),
        ChangeNotifierProvider<AuthController>.value(value: sessionController),
        ChangeNotifierProvider(
          create: (_) => auth_presentation.AuthController(
            loginUseCase: Login(authRepo),
            errorMapper: errorMapper,
            sessionController: sessionController,
          ),
        ),
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
        ChangeNotifierProvider(
          create: (_) => RankingsController(
            listRankings: ListRankings(rankingsRepo),
            getRankingDetail: GetRankingDetail(rankingsRepo),
            errorMapper: errorMapper,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AcademiesController(
            listAcademies: ListAcademies(academiesRepo),
            getAcademyDetail: GetAcademyDetail(academiesRepo),
            errorMapper: errorMapper,
          ),
        ),
      ],
      child: child,
    );
  }
}
