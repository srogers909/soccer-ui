// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerGameStats _$PlayerGameStatsFromJson(Map<String, dynamic> json) =>
    PlayerGameStats(
      playerId: json['playerId'] as String,
      gameId: json['gameId'] as String,
      date: DateTime.parse(json['date'] as String),
      minutesPlayed: (json['minutesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      shots: (json['shots'] as num?)?.toInt() ?? 0,
      shotsOnTarget: (json['shotsOnTarget'] as num?)?.toInt() ?? 0,
      passes: (json['passes'] as num?)?.toInt() ?? 0,
      passesCompleted: (json['passesCompleted'] as num?)?.toInt() ?? 0,
      tackles: (json['tackles'] as num?)?.toInt() ?? 0,
      interceptions: (json['interceptions'] as num?)?.toInt() ?? 0,
      fouls: (json['fouls'] as num?)?.toInt() ?? 0,
      yellowCards: (json['yellowCards'] as num?)?.toInt() ?? 0,
      redCards: (json['redCards'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      position: json['position'] as String?,
    );

Map<String, dynamic> _$PlayerGameStatsToJson(PlayerGameStats instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'gameId': instance.gameId,
      'date': instance.date.toIso8601String(),
      'minutesPlayed': instance.minutesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'shots': instance.shots,
      'shotsOnTarget': instance.shotsOnTarget,
      'passes': instance.passes,
      'passesCompleted': instance.passesCompleted,
      'tackles': instance.tackles,
      'interceptions': instance.interceptions,
      'fouls': instance.fouls,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
      'rating': instance.rating,
      'position': instance.position,
    };

PlayerSeasonStats _$PlayerSeasonStatsFromJson(Map<String, dynamic> json) =>
    PlayerSeasonStats(
      playerId: json['playerId'] as String,
      seasonId: json['seasonId'] as String,
      year: (json['year'] as num).toInt(),
      competition: json['competition'] as String,
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      minutesPlayed: (json['minutesPlayed'] as num?)?.toInt() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      shots: (json['shots'] as num?)?.toInt() ?? 0,
      shotsOnTarget: (json['shotsOnTarget'] as num?)?.toInt() ?? 0,
      passes: (json['passes'] as num?)?.toInt() ?? 0,
      passesCompleted: (json['passesCompleted'] as num?)?.toInt() ?? 0,
      tackles: (json['tackles'] as num?)?.toInt() ?? 0,
      interceptions: (json['interceptions'] as num?)?.toInt() ?? 0,
      fouls: (json['fouls'] as num?)?.toInt() ?? 0,
      yellowCards: (json['yellowCards'] as num?)?.toInt() ?? 0,
      redCards: (json['redCards'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      manOfTheMatchAwards: (json['manOfTheMatchAwards'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlayerSeasonStatsToJson(PlayerSeasonStats instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'seasonId': instance.seasonId,
      'year': instance.year,
      'competition': instance.competition,
      'gamesPlayed': instance.gamesPlayed,
      'minutesPlayed': instance.minutesPlayed,
      'goals': instance.goals,
      'assists': instance.assists,
      'shots': instance.shots,
      'shotsOnTarget': instance.shotsOnTarget,
      'passes': instance.passes,
      'passesCompleted': instance.passesCompleted,
      'tackles': instance.tackles,
      'interceptions': instance.interceptions,
      'fouls': instance.fouls,
      'yellowCards': instance.yellowCards,
      'redCards': instance.redCards,
      'averageRating': instance.averageRating,
      'manOfTheMatchAwards': instance.manOfTheMatchAwards,
    };

PlayerCareerStats _$PlayerCareerStatsFromJson(
  Map<String, dynamic> json,
) => PlayerCareerStats(
  playerId: json['playerId'] as String,
  totalGames: (json['totalGames'] as num?)?.toInt() ?? 0,
  totalMinutes: (json['totalMinutes'] as num?)?.toInt() ?? 0,
  totalGoals: (json['totalGoals'] as num?)?.toInt() ?? 0,
  totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
  totalShots: (json['totalShots'] as num?)?.toInt() ?? 0,
  totalShotsOnTarget: (json['totalShotsOnTarget'] as num?)?.toInt() ?? 0,
  totalPasses: (json['totalPasses'] as num?)?.toInt() ?? 0,
  totalPassesCompleted: (json['totalPassesCompleted'] as num?)?.toInt() ?? 0,
  totalTackles: (json['totalTackles'] as num?)?.toInt() ?? 0,
  totalInterceptions: (json['totalInterceptions'] as num?)?.toInt() ?? 0,
  totalFouls: (json['totalFouls'] as num?)?.toInt() ?? 0,
  totalYellowCards: (json['totalYellowCards'] as num?)?.toInt() ?? 0,
  totalRedCards: (json['totalRedCards'] as num?)?.toInt() ?? 0,
  careerAverageRating: (json['careerAverageRating'] as num?)?.toDouble() ?? 0.0,
  totalManOfTheMatchAwards:
      (json['totalManOfTheMatchAwards'] as num?)?.toInt() ?? 0,
  seasonsPlayed: (json['seasonsPlayed'] as num?)?.toInt() ?? 0,
  competitionsPlayed:
      (json['competitionsPlayed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  careerStart: json['careerStart'] == null
      ? null
      : DateTime.parse(json['careerStart'] as String),
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$PlayerCareerStatsToJson(PlayerCareerStats instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'totalGames': instance.totalGames,
      'totalMinutes': instance.totalMinutes,
      'totalGoals': instance.totalGoals,
      'totalAssists': instance.totalAssists,
      'totalShots': instance.totalShots,
      'totalShotsOnTarget': instance.totalShotsOnTarget,
      'totalPasses': instance.totalPasses,
      'totalPassesCompleted': instance.totalPassesCompleted,
      'totalTackles': instance.totalTackles,
      'totalInterceptions': instance.totalInterceptions,
      'totalFouls': instance.totalFouls,
      'totalYellowCards': instance.totalYellowCards,
      'totalRedCards': instance.totalRedCards,
      'careerAverageRating': instance.careerAverageRating,
      'totalManOfTheMatchAwards': instance.totalManOfTheMatchAwards,
      'seasonsPlayed': instance.seasonsPlayed,
      'competitionsPlayed': instance.competitionsPlayed,
      'careerStart': instance.careerStart?.toIso8601String(),
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
