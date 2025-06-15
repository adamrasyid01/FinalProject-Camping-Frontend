import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/usecases/get_detail_site.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCampingLocation getCampingLocation;
  final GetCampingSite getCampingSite;
  final GetDetailSite getDetailSite;

  HomeBloc({
    required this.getCampingLocation,
    required this.getCampingSite,
    required this.getDetailSite,
  }) : super(const HomeStateInitial()) {
    
    // Camping Locations
    on<HomeEventGetCampingLocations>((event, emit) async {
      emit(const HomeStateLoading());
      final result = await getCampingLocation.execute(filter: event.filter);
      result.fold(
        (failure) => emit(HomeStateError(failure.message)),
        (locations) => emit(HomeStateSuccessLocations(campingLocations: locations)),
      );
    });

    // Camping Sites (Paginated)
    on<HomeEventGetCampingSite>((event, emit) async {
      try {
        if (event.page == 1) {
          emit(const HomeStateLoading());
        } else {
          emit(HomeStateLoadingMoreSites(campingSites: state.campingSites));
        }

        final result = await getCampingSite.execute(
          event.locationId,
          search: event.search,
          page: event.page,
          limit: event.limit,
        );

        result.fold(
          (failure) => emit(HomeStateError(failure.message)),
          (sites) {
            if (event.page == 1 ) {
              emit(HomeStateSuccessSites(
                campingSites: sites,
                hasReachedMax: sites.length < event.limit,
                currentPage: event.page,
              ));
            } else {
              final combined = [...state.campingSites, ...sites];
              emit(HomeStateSuccessSites(
                campingSites: combined,
                hasReachedMax: sites.length < event.limit,
                currentPage: event.page,
              ));
            }
          },
        );
      } catch (e) {
        emit(HomeStateError(e.toString()));
      }
    });

    // Detail Camping Site
    on<HomeEventGetDetailSites>((event, emit) async {
      try {
        final result = await getDetailSite.execute(event.campingLocationId, event.campingSiteId);
        result.fold(
          (failure) => emit(HomeStateError(failure.message)),
          (campingSite) => emit(HomeStateGetDetailSites(campingSite: campingSite)),
        );
      } catch (e) {
        emit(HomeStateError(e.toString()));
      }
    });
  }
}
