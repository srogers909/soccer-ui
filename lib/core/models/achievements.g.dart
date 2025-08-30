// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
  playerId: json['playerId'] as String?,
  teamId: json['teamId'] as String?,
  dateEarned: DateTime.parse(json['dateEarned'] as String),
  context: json['context'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  iconPath: json['iconPath'] as String?,
  isRare: json['isRare'] as bool? ?? false,
);

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'playerId': instance.playerId,
      'teamId': instance.teamId,
      'dateEarned': instance.dateEarned.toIso8601String(),
      'context': instance.context,
      'metadata': instance.metadata,
      'iconPath': instance.iconPath,
      'isRare': instance.isRare,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.goals: 'goals',
  AchievementType.assists: 'assists',
  AchievementType.cleanSheets: 'cleanSheets',
  AchievementType.wins: 'wins',
  AchievementType.trophies: 'trophies',
  AchievementType.career: 'career',
  AchievementType.seasonal: 'seasonal',
  AchievementType.special: 'special',
};

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
  id: json['id'] as String,
  type: $enumDecode(_$RecordTypeEnumMap, json['type']),
  recordHolderName: json['recordHolderName'] as String,
  playerId: json['playerId'] as String?,
  teamId: json['teamId'] as String?,
  value: (json['value'] as num).toDouble(),
  displayValue: json['displayValue'] as String,
  dateSet: DateTime.parse(json['dateSet'] as String),
  context: json['context'] as String?,
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$RecordTypeEnumMap[instance.type]!,
  'recordHolderName': instance.recordHolderName,
  'playerId': instance.playerId,
  'teamId': instance.teamId,
  'value': instance.value,
  'displayValue': instance.displayValue,
  'dateSet': instance.dateSet.toIso8601String(),
  'context': instance.context,
  'description': instance.description,
  'metadata': instance.metadata,
};

const _$RecordTypeEnumMap = {
  RecordType.mostGoalsInGame: 'mostGoalsInGame',
  RecordType.mostGoalsInSeason: 'mostGoalsInSeason',
  RecordType.mostGoalsInCareer: 'mostGoalsInCareer',
  RecordType.mostAssistsInGame: 'mostAssistsInGame',
  RecordType.mostAssistsInSeason: 'mostAssistsInSeason',
  RecordType.mostAssistsInCareer: 'mostAssistsInCareer',
  RecordType.highestRating: 'highestRating',
  RecordType.longestWinStreak: 'longestWinStreak',
  RecordType.longestUnbeatenRun: 'longestUnbeatenRun',
  RecordType.fastestGoal: 'fastestGoal',
  RecordType.youngestScorer: 'youngestScorer',
  RecordType.oldestScorer: 'oldestScorer',
  RecordType.mostAppearances: 'mostAppearances',
  RecordType.cleanSheets: 'cleanSheets',
};

RecordBook _$RecordBookFromJson(Map<String, dynamic> json) => RecordBook(
  records: (json['records'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$RecordTypeEnumMap, k),
      Record.fromJson(e as Map<String, dynamic>),
    ),
  ),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$RecordBookToJson(RecordBook instance) =>
    <String, dynamic>{
      'records': instance.records.map(
        (k, e) => MapEntry(_$RecordTypeEnumMap[k]!, e),
      ),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

AchievementStats _$AchievementStatsFromJson(Map<String, dynamic> json) =>
    AchievementStats(
      totalAchievements: (json['totalAchievements'] as num?)?.toInt() ?? 0,
      rareAchievements: (json['rareAchievements'] as num?)?.toInt() ?? 0,
      achievementsByType:
          (json['achievementsByType'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              $enumDecode(_$AchievementTypeEnumMap, k),
              (e as num).toInt(),
            ),
          ) ??
          const {},
      firstAchievement: json['firstAchievement'] == null
          ? null
          : DateTime.parse(json['firstAchievement'] as String),
      lastAchievement: json['lastAchievement'] == null
          ? null
          : DateTime.parse(json['lastAchievement'] as String),
    );

Map<String, dynamic> _$AchievementStatsToJson(AchievementStats instance) =>
    <String, dynamic>{
      'totalAchievements': instance.totalAchievements,
      'rareAchievements': instance.rareAchievements,
      'achievementsByType': instance.achievementsByType.map(
        (k, e) => MapEntry(_$AchievementTypeEnumMap[k]!, e),
      ),
      'firstAchievement': instance.firstAchievement?.toIso8601String(),
      'lastAchievement': instance.lastAchievement?.toIso8601String(),
    };
