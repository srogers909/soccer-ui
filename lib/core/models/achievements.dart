import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievements.g.dart';

/// Types of achievements that can be earned
enum AchievementType {
  goals,
  assists,
  cleanSheets,
  wins,
  trophies,
  career,
  seasonal,
  special,
}

/// Types of records that can be tracked
enum RecordType {
  mostGoalsInGame,
  mostGoalsInSeason,
  mostGoalsInCareer,
  mostAssistsInGame,
  mostAssistsInSeason,
  mostAssistsInCareer,
  highestRating,
  longestWinStreak,
  longestUnbeatenRun,
  fastestGoal,
  youngestScorer,
  oldestScorer,
  mostAppearances,
  cleanSheets,
}

/// Represents a specific achievement earned by a player or team
@JsonSerializable()
class Achievement extends Equatable {
  final String id;
  final String name;
  final String description;
  final AchievementType type;
  final String? playerId;
  final String? teamId;
  final DateTime dateEarned;
  final String? context; // e.g., "Premier League 2025"
  final Map<String, dynamic>? metadata; // Additional data about the achievement
  final String? iconPath;
  final bool isRare;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.playerId,
    this.teamId,
    required this.dateEarned,
    this.context,
    this.metadata,
    this.iconPath,
    this.isRare = false,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => 
      _$AchievementFromJson(json);
  
  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  @override
  List<Object?> get props => [
    id, name, description, type, playerId, teamId, dateEarned,
    context, metadata, iconPath, isRare,
  ];
}

/// Represents a record (best performance) in various categories
@JsonSerializable()
class Record extends Equatable {
  final String id;
  final RecordType type;
  final String recordHolderName;
  final String? playerId;
  final String? teamId;
  final double value;
  final String displayValue; // Formatted value for display
  final DateTime dateSet;
  final String? context; // Match, season, or competition context
  final String? description;
  final Map<String, dynamic>? metadata;

  const Record({
    required this.id,
    required this.type,
    required this.recordHolderName,
    this.playerId,
    this.teamId,
    required this.value,
    required this.displayValue,
    required this.dateSet,
    this.context,
    this.description,
    this.metadata,
  });

  factory Record.fromJson(Map<String, dynamic> json) => 
      _$RecordFromJson(json);
  
  Map<String, dynamic> toJson() => _$RecordToJson(this);

  @override
  List<Object?> get props => [
    id, type, recordHolderName, playerId, teamId, value,
    displayValue, dateSet, context, description, metadata,
  ];
}

/// Predefined achievement definitions
class AchievementDefinitions {
  static const List<AchievementDefinition> definitions = [
    // Goal-scoring achievements
    AchievementDefinition(
      id: 'first_goal',
      name: 'Off the Mark',
      description: 'Score your first goal',
      type: AchievementType.goals,
      trigger: AchievementTrigger.firstGoal,
    ),
    AchievementDefinition(
      id: 'hat_trick',
      name: 'Hat Trick Hero',
      description: 'Score a hat trick in a single match',
      type: AchievementType.goals,
      trigger: AchievementTrigger.hatTrick,
    ),
    AchievementDefinition(
      id: 'season_20_goals',
      name: 'Prolific Scorer',
      description: 'Score 20 goals in a season',
      type: AchievementType.seasonal,
      trigger: AchievementTrigger.seasonGoals,
      threshold: 20,
    ),
    AchievementDefinition(
      id: 'career_100_goals',
      name: 'Century Striker',
      description: 'Score 100 career goals',
      type: AchievementType.career,
      trigger: AchievementTrigger.careerGoals,
      threshold: 100,
    ),
    
    // Assist achievements
    AchievementDefinition(
      id: 'first_assist',
      name: 'Team Player',
      description: 'Record your first assist',
      type: AchievementType.assists,
      trigger: AchievementTrigger.firstAssist,
    ),
    AchievementDefinition(
      id: 'season_15_assists',
      name: 'Creative Genius',
      description: 'Record 15 assists in a season',
      type: AchievementType.seasonal,
      trigger: AchievementTrigger.seasonAssists,
      threshold: 15,
    ),
    
    // Team achievements
    AchievementDefinition(
      id: 'first_win',
      name: 'Taste of Victory',
      description: 'Win your first match',
      type: AchievementType.wins,
      trigger: AchievementTrigger.firstWin,
    ),
    AchievementDefinition(
      id: 'win_streak_10',
      name: 'Unstoppable',
      description: 'Win 10 matches in a row',
      type: AchievementType.wins,
      trigger: AchievementTrigger.winStreak,
      threshold: 10,
      isRare: true,
    ),
    
    // Special achievements
    AchievementDefinition(
      id: 'perfect_rating',
      name: 'Perfect Performance',
      description: 'Achieve a 10.0 match rating',
      type: AchievementType.special,
      trigger: AchievementTrigger.perfectRating,
      isRare: true,
    ),
    AchievementDefinition(
      id: 'debut_goal',
      name: 'Dream Debut',
      description: 'Score on your debut',
      type: AchievementType.special,
      trigger: AchievementTrigger.debutGoal,
    ),
  ];
}

/// Definition of how an achievement can be triggered
enum AchievementTrigger {
  firstGoal,
  hatTrick,
  seasonGoals,
  careerGoals,
  firstAssist,
  seasonAssists,
  firstWin,
  winStreak,
  perfectRating,
  debutGoal,
  cleanSheet,
  trophyWin,
}

/// Template for creating achievements
class AchievementDefinition {
  final String id;
  final String name;
  final String description;
  final AchievementType type;
  final AchievementTrigger trigger;
  final int? threshold;
  final bool isRare;
  final String? iconPath;

  const AchievementDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.trigger,
    this.threshold,
    this.isRare = false,
    this.iconPath,
  });
}

/// Container for all records in the game
@JsonSerializable()
class RecordBook extends Equatable {
  final Map<RecordType, Record> records;
  final DateTime lastUpdated;

  const RecordBook({
    required this.records,
    required this.lastUpdated,
  });

  factory RecordBook.fromJson(Map<String, dynamic> json) => 
      _$RecordBookFromJson(json);
  
  Map<String, dynamic> toJson() => _$RecordBookToJson(this);

  /// Creates an empty record book
  factory RecordBook.empty() {
    return RecordBook(
      records: {},
      lastUpdated: DateTime.now(),
    );
  }

  /// Updates a record if the new value is better
  RecordBook updateRecord(Record newRecord) {
    final currentRecord = records[newRecord.type];
    
    // If no existing record or new record is better
    if (currentRecord == null || _isBetterRecord(newRecord, currentRecord)) {
      final updatedRecords = Map<RecordType, Record>.from(records);
      updatedRecords[newRecord.type] = newRecord;
      
      return RecordBook(
        records: updatedRecords,
        lastUpdated: DateTime.now(),
      );
    }
    
    return this;
  }

  /// Determines if a new record is better than the existing one
  bool _isBetterRecord(Record newRecord, Record existingRecord) {
    // For most records, higher is better
    switch (newRecord.type) {
      case RecordType.fastestGoal:
        // For fastest goal, lower is better (less time)
        return newRecord.value < existingRecord.value;
      case RecordType.youngestScorer:
        // For youngest scorer, lower age is better
        return newRecord.value < existingRecord.value;
      default:
        // For everything else, higher is better
        return newRecord.value > existingRecord.value;
    }
  }

  @override
  List<Object?> get props => [records, lastUpdated];
}

/// Statistics tracking for achievements system
@JsonSerializable()
class AchievementStats extends Equatable {
  final int totalAchievements;
  final int rareAchievements;
  final Map<AchievementType, int> achievementsByType;
  final DateTime? firstAchievement;
  final DateTime? lastAchievement;

  const AchievementStats({
    this.totalAchievements = 0,
    this.rareAchievements = 0,
    this.achievementsByType = const {},
    this.firstAchievement,
    this.lastAchievement,
  });

  factory AchievementStats.fromJson(Map<String, dynamic> json) => 
      _$AchievementStatsFromJson(json);
  
  Map<String, dynamic> toJson() => _$AchievementStatsToJson(this);

  @override
  List<Object?> get props => [
    totalAchievements, rareAchievements, achievementsByType,
    firstAchievement, lastAchievement,
  ];
}
