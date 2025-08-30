import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_statistics.g.dart';

/// Represents statistics for a single game
@JsonSerializable()
class PlayerGameStats extends Equatable {
  final String playerId;
  final String gameId;
  final DateTime date;
  final int minutesPlayed;
  final int goals;
  final int assists;
  final int shots;
  final int shotsOnTarget;
  final int passes;
  final int passesCompleted;
  final int tackles;
  final int interceptions;
  final int fouls;
  final int yellowCards;
  final int redCards;
  final double rating;
  final String? position;

  const PlayerGameStats({
    required this.playerId,
    required this.gameId,
    required this.date,
    this.minutesPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.shots = 0,
    this.shotsOnTarget = 0,
    this.passes = 0,
    this.passesCompleted = 0,
    this.tackles = 0,
    this.interceptions = 0,
    this.fouls = 0,
    this.yellowCards = 0,
    this.redCards = 0,
    this.rating = 0.0,
    this.position,
  });

  factory PlayerGameStats.fromJson(Map<String, dynamic> json) => 
      _$PlayerGameStatsFromJson(json);
  
  Map<String, dynamic> toJson() => _$PlayerGameStatsToJson(this);

  @override
  List<Object?> get props => [
    playerId, gameId, date, minutesPlayed, goals, assists, shots,
    shotsOnTarget, passes, passesCompleted, tackles, interceptions,
    fouls, yellowCards, redCards, rating, position,
  ];
}

/// Represents aggregated statistics for a season
@JsonSerializable()
class PlayerSeasonStats extends Equatable {
  final String playerId;
  final String seasonId;
  final int year;
  final String competition;
  final int gamesPlayed;
  final int minutesPlayed;
  final int goals;
  final int assists;
  final int shots;
  final int shotsOnTarget;
  final int passes;
  final int passesCompleted;
  final int tackles;
  final int interceptions;
  final int fouls;
  final int yellowCards;
  final int redCards;
  final double averageRating;
  final int manOfTheMatchAwards;

  const PlayerSeasonStats({
    required this.playerId,
    required this.seasonId,
    required this.year,
    required this.competition,
    this.gamesPlayed = 0,
    this.minutesPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.shots = 0,
    this.shotsOnTarget = 0,
    this.passes = 0,
    this.passesCompleted = 0,
    this.tackles = 0,
    this.interceptions = 0,
    this.fouls = 0,
    this.yellowCards = 0,
    this.redCards = 0,
    this.averageRating = 0.0,
    this.manOfTheMatchAwards = 0,
  });

  factory PlayerSeasonStats.fromJson(Map<String, dynamic> json) => 
      _$PlayerSeasonStatsFromJson(json);
  
  Map<String, dynamic> toJson() => _$PlayerSeasonStatsToJson(this);

  /// Creates season stats by aggregating game stats
  factory PlayerSeasonStats.fromGameStats({
    required String playerId,
    required String seasonId,
    required int year,
    required String competition,
    required List<PlayerGameStats> gameStats,
  }) {
    if (gameStats.isEmpty) {
      return PlayerSeasonStats(
        playerId: playerId,
        seasonId: seasonId,
        year: year,
        competition: competition,
      );
    }

    final totalRating = gameStats.fold<double>(0.0, (sum, stat) => sum + stat.rating);
    final averageRating = totalRating / gameStats.length;

    return PlayerSeasonStats(
      playerId: playerId,
      seasonId: seasonId,
      year: year,
      competition: competition,
      gamesPlayed: gameStats.length,
      minutesPlayed: gameStats.fold(0, (sum, stat) => sum + stat.minutesPlayed),
      goals: gameStats.fold(0, (sum, stat) => sum + stat.goals),
      assists: gameStats.fold(0, (sum, stat) => sum + stat.assists),
      shots: gameStats.fold(0, (sum, stat) => sum + stat.shots),
      shotsOnTarget: gameStats.fold(0, (sum, stat) => sum + stat.shotsOnTarget),
      passes: gameStats.fold(0, (sum, stat) => sum + stat.passes),
      passesCompleted: gameStats.fold(0, (sum, stat) => sum + stat.passesCompleted),
      tackles: gameStats.fold(0, (sum, stat) => sum + stat.tackles),
      interceptions: gameStats.fold(0, (sum, stat) => sum + stat.interceptions),
      fouls: gameStats.fold(0, (sum, stat) => sum + stat.fouls),
      yellowCards: gameStats.fold(0, (sum, stat) => sum + stat.yellowCards),
      redCards: gameStats.fold(0, (sum, stat) => sum + stat.redCards),
      averageRating: averageRating,
    );
  }

  @override
  List<Object?> get props => [
    playerId, seasonId, year, competition, gamesPlayed, minutesPlayed,
    goals, assists, shots, shotsOnTarget, passes, passesCompleted,
    tackles, interceptions, fouls, yellowCards, redCards, averageRating,
    manOfTheMatchAwards,
  ];
}

/// Represents career totals across all competitions and seasons
@JsonSerializable()
class PlayerCareerStats extends Equatable {
  final String playerId;
  final int totalGames;
  final int totalMinutes;
  final int totalGoals;
  final int totalAssists;
  final int totalShots;
  final int totalShotsOnTarget;
  final int totalPasses;
  final int totalPassesCompleted;
  final int totalTackles;
  final int totalInterceptions;
  final int totalFouls;
  final int totalYellowCards;
  final int totalRedCards;
  final double careerAverageRating;
  final int totalManOfTheMatchAwards;
  final int seasonsPlayed;
  final List<String> competitionsPlayed;
  final DateTime? careerStart;
  final DateTime? lastUpdated;

  const PlayerCareerStats({
    required this.playerId,
    this.totalGames = 0,
    this.totalMinutes = 0,
    this.totalGoals = 0,
    this.totalAssists = 0,
    this.totalShots = 0,
    this.totalShotsOnTarget = 0,
    this.totalPasses = 0,
    this.totalPassesCompleted = 0,
    this.totalTackles = 0,
    this.totalInterceptions = 0,
    this.totalFouls = 0,
    this.totalYellowCards = 0,
    this.totalRedCards = 0,
    this.careerAverageRating = 0.0,
    this.totalManOfTheMatchAwards = 0,
    this.seasonsPlayed = 0,
    this.competitionsPlayed = const [],
    this.careerStart,
    this.lastUpdated,
  });

  factory PlayerCareerStats.fromJson(Map<String, dynamic> json) => 
      _$PlayerCareerStatsFromJson(json);
  
  Map<String, dynamic> toJson() => _$PlayerCareerStatsToJson(this);

  /// Creates career stats by aggregating season stats
  factory PlayerCareerStats.fromSeasonStats({
    required String playerId,
    required List<PlayerSeasonStats> seasonStats,
  }) {
    if (seasonStats.isEmpty) {
      return PlayerCareerStats(playerId: playerId);
    }

    final competitions = seasonStats.map((s) => s.competition).toSet().toList();
    final totalRating = seasonStats.fold<double>(0.0, (sum, stat) => sum + (stat.averageRating * stat.gamesPlayed));
    final totalGames = seasonStats.fold(0, (sum, stat) => sum + stat.gamesPlayed);
    final careerAverage = totalGames > 0 ? totalRating / totalGames : 0.0;

    return PlayerCareerStats(
      playerId: playerId,
      totalGames: totalGames,
      totalMinutes: seasonStats.fold(0, (sum, stat) => sum + stat.minutesPlayed),
      totalGoals: seasonStats.fold(0, (sum, stat) => sum + stat.goals),
      totalAssists: seasonStats.fold(0, (sum, stat) => sum + stat.assists),
      totalShots: seasonStats.fold(0, (sum, stat) => sum + stat.shots),
      totalShotsOnTarget: seasonStats.fold(0, (sum, stat) => sum + stat.shotsOnTarget),
      totalPasses: seasonStats.fold(0, (sum, stat) => sum + stat.passes),
      totalPassesCompleted: seasonStats.fold(0, (sum, stat) => sum + stat.passesCompleted),
      totalTackles: seasonStats.fold(0, (sum, stat) => sum + stat.tackles),
      totalInterceptions: seasonStats.fold(0, (sum, stat) => sum + stat.interceptions),
      totalFouls: seasonStats.fold(0, (sum, stat) => sum + stat.fouls),
      totalYellowCards: seasonStats.fold(0, (sum, stat) => sum + stat.yellowCards),
      totalRedCards: seasonStats.fold(0, (sum, stat) => sum + stat.redCards),
      careerAverageRating: careerAverage,
      totalManOfTheMatchAwards: seasonStats.fold(0, (sum, stat) => sum + stat.manOfTheMatchAwards),
      seasonsPlayed: seasonStats.length,
      competitionsPlayed: competitions,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    playerId, totalGames, totalMinutes, totalGoals, totalAssists,
    totalShots, totalShotsOnTarget, totalPasses, totalPassesCompleted,
    totalTackles, totalInterceptions, totalFouls, totalYellowCards,
    totalRedCards, careerAverageRating, totalManOfTheMatchAwards,
    seasonsPlayed, competitionsPlayed, careerStart, lastUpdated,
  ];
}
