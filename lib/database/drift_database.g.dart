// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $ScheduledTable extends Scheduled
    with TableInfo<$ScheduledTable, ScheduledData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduledTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endUsedMeta = const VerificationMeta(
    'endUsed',
  );
  @override
  late final GeneratedColumn<bool> endUsed = GeneratedColumn<bool>(
    'end_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("end_used" IN (0, 1))',
    ),
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repeatTypeMeta = const VerificationMeta(
    'repeatType',
  );
  @override
  late final GeneratedColumn<String> repeatType = GeneratedColumn<String>(
    'repeat_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _repeatEndUsedMeta = const VerificationMeta(
    'repeatEndUsed',
  );
  @override
  late final GeneratedColumn<bool> repeatEndUsed = GeneratedColumn<bool>(
    'repeat_end_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("repeat_end_used" IN (0, 1))',
    ),
  );
  static const VerificationMeta _repeatEndDateMeta = const VerificationMeta(
    'repeatEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> repeatEndDate =
      GeneratedColumn<DateTime>(
        'repeat_end_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _missedMeta = const VerificationMeta('missed');
  @override
  late final GeneratedColumn<bool> missed = GeneratedColumn<bool>(
    'missed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("missed" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _missedCommentMeta = const VerificationMeta(
    'missedComment',
  );
  @override
  late final GeneratedColumn<String> missedComment = GeneratedColumn<String>(
    'missed_comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    color,
    date,
    startTime,
    endUsed,
    endTime,
    repeatType,
    repeatEndUsed,
    repeatEndDate,
    completed,
    missed,
    missedComment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scheduled';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduledData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_used')) {
      context.handle(
        _endUsedMeta,
        endUsed.isAcceptableOrUnknown(data['end_used']!, _endUsedMeta),
      );
    } else if (isInserting) {
      context.missing(_endUsedMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('repeat_type')) {
      context.handle(
        _repeatTypeMeta,
        repeatType.isAcceptableOrUnknown(data['repeat_type']!, _repeatTypeMeta),
      );
    }
    if (data.containsKey('repeat_end_used')) {
      context.handle(
        _repeatEndUsedMeta,
        repeatEndUsed.isAcceptableOrUnknown(
          data['repeat_end_used']!,
          _repeatEndUsedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repeatEndUsedMeta);
    }
    if (data.containsKey('repeat_end_date')) {
      context.handle(
        _repeatEndDateMeta,
        repeatEndDate.isAcceptableOrUnknown(
          data['repeat_end_date']!,
          _repeatEndDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repeatEndDateMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('missed')) {
      context.handle(
        _missedMeta,
        missed.isAcceptableOrUnknown(data['missed']!, _missedMeta),
      );
    }
    if (data.containsKey('missed_comment')) {
      context.handle(
        _missedCommentMeta,
        missedComment.isAcceptableOrUnknown(
          data['missed_comment']!,
          _missedCommentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduledData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduledData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      ),
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      startTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}start_time'],
          )!,
      endUsed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}end_used'],
          )!,
      endTime:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}end_time'],
          )!,
      repeatType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}repeat_type'],
          )!,
      repeatEndUsed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}repeat_end_used'],
          )!,
      repeatEndDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}repeat_end_date'],
          )!,
      completed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}completed'],
          )!,
      missed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}missed'],
          )!,
      missedComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}missed_comment'],
      ),
    );
  }

  @override
  $ScheduledTable createAlias(String alias) {
    return $ScheduledTable(attachedDatabase, alias);
  }
}

class ScheduledData extends DataClass implements Insertable<ScheduledData> {
  final int id;
  final String title;
  final int? color;
  final DateTime date;
  final int startTime;
  final bool endUsed;
  final int endTime;
  final String repeatType;
  final bool repeatEndUsed;
  final DateTime repeatEndDate;
  final bool completed;
  final bool missed;
  final String? missedComment;
  const ScheduledData({
    required this.id,
    required this.title,
    this.color,
    required this.date,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.repeatType,
    required this.repeatEndUsed,
    required this.repeatEndDate,
    required this.completed,
    required this.missed,
    this.missedComment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int>(color);
    }
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<int>(startTime);
    map['end_used'] = Variable<bool>(endUsed);
    map['end_time'] = Variable<int>(endTime);
    map['repeat_type'] = Variable<String>(repeatType);
    map['repeat_end_used'] = Variable<bool>(repeatEndUsed);
    map['repeat_end_date'] = Variable<DateTime>(repeatEndDate);
    map['completed'] = Variable<bool>(completed);
    map['missed'] = Variable<bool>(missed);
    if (!nullToAbsent || missedComment != null) {
      map['missed_comment'] = Variable<String>(missedComment);
    }
    return map;
  }

  ScheduledCompanion toCompanion(bool nullToAbsent) {
    return ScheduledCompanion(
      id: Value(id),
      title: Value(title),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      date: Value(date),
      startTime: Value(startTime),
      endUsed: Value(endUsed),
      endTime: Value(endTime),
      repeatType: Value(repeatType),
      repeatEndUsed: Value(repeatEndUsed),
      repeatEndDate: Value(repeatEndDate),
      completed: Value(completed),
      missed: Value(missed),
      missedComment:
          missedComment == null && nullToAbsent
              ? const Value.absent()
              : Value(missedComment),
    );
  }

  factory ScheduledData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduledData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      color: serializer.fromJson<int?>(json['color']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endUsed: serializer.fromJson<bool>(json['endUsed']),
      endTime: serializer.fromJson<int>(json['endTime']),
      repeatType: serializer.fromJson<String>(json['repeatType']),
      repeatEndUsed: serializer.fromJson<bool>(json['repeatEndUsed']),
      repeatEndDate: serializer.fromJson<DateTime>(json['repeatEndDate']),
      completed: serializer.fromJson<bool>(json['completed']),
      missed: serializer.fromJson<bool>(json['missed']),
      missedComment: serializer.fromJson<String?>(json['missedComment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'color': serializer.toJson<int?>(color),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<int>(startTime),
      'endUsed': serializer.toJson<bool>(endUsed),
      'endTime': serializer.toJson<int>(endTime),
      'repeatType': serializer.toJson<String>(repeatType),
      'repeatEndUsed': serializer.toJson<bool>(repeatEndUsed),
      'repeatEndDate': serializer.toJson<DateTime>(repeatEndDate),
      'completed': serializer.toJson<bool>(completed),
      'missed': serializer.toJson<bool>(missed),
      'missedComment': serializer.toJson<String?>(missedComment),
    };
  }

  ScheduledData copyWith({
    int? id,
    String? title,
    Value<int?> color = const Value.absent(),
    DateTime? date,
    int? startTime,
    bool? endUsed,
    int? endTime,
    String? repeatType,
    bool? repeatEndUsed,
    DateTime? repeatEndDate,
    bool? completed,
    bool? missed,
    Value<String?> missedComment = const Value.absent(),
  }) => ScheduledData(
    id: id ?? this.id,
    title: title ?? this.title,
    color: color.present ? color.value : this.color,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endUsed: endUsed ?? this.endUsed,
    endTime: endTime ?? this.endTime,
    repeatType: repeatType ?? this.repeatType,
    repeatEndUsed: repeatEndUsed ?? this.repeatEndUsed,
    repeatEndDate: repeatEndDate ?? this.repeatEndDate,
    completed: completed ?? this.completed,
    missed: missed ?? this.missed,
    missedComment:
        missedComment.present ? missedComment.value : this.missedComment,
  );
  ScheduledData copyWithCompanion(ScheduledCompanion data) {
    return ScheduledData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      color: data.color.present ? data.color.value : this.color,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endUsed: data.endUsed.present ? data.endUsed.value : this.endUsed,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      repeatType:
          data.repeatType.present ? data.repeatType.value : this.repeatType,
      repeatEndUsed:
          data.repeatEndUsed.present
              ? data.repeatEndUsed.value
              : this.repeatEndUsed,
      repeatEndDate:
          data.repeatEndDate.present
              ? data.repeatEndDate.value
              : this.repeatEndDate,
      completed: data.completed.present ? data.completed.value : this.completed,
      missed: data.missed.present ? data.missed.value : this.missed,
      missedComment:
          data.missedComment.present
              ? data.missedComment.value
              : this.missedComment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endUsed: $endUsed, ')
          ..write('endTime: $endTime, ')
          ..write('repeatType: $repeatType, ')
          ..write('repeatEndUsed: $repeatEndUsed, ')
          ..write('repeatEndDate: $repeatEndDate, ')
          ..write('completed: $completed, ')
          ..write('missed: $missed, ')
          ..write('missedComment: $missedComment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    color,
    date,
    startTime,
    endUsed,
    endTime,
    repeatType,
    repeatEndUsed,
    repeatEndDate,
    completed,
    missed,
    missedComment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduledData &&
          other.id == this.id &&
          other.title == this.title &&
          other.color == this.color &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endUsed == this.endUsed &&
          other.endTime == this.endTime &&
          other.repeatType == this.repeatType &&
          other.repeatEndUsed == this.repeatEndUsed &&
          other.repeatEndDate == this.repeatEndDate &&
          other.completed == this.completed &&
          other.missed == this.missed &&
          other.missedComment == this.missedComment);
}

class ScheduledCompanion extends UpdateCompanion<ScheduledData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> color;
  final Value<DateTime> date;
  final Value<int> startTime;
  final Value<bool> endUsed;
  final Value<int> endTime;
  final Value<String> repeatType;
  final Value<bool> repeatEndUsed;
  final Value<DateTime> repeatEndDate;
  final Value<bool> completed;
  final Value<bool> missed;
  final Value<String?> missedComment;
  const ScheduledCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endUsed = const Value.absent(),
    this.endTime = const Value.absent(),
    this.repeatType = const Value.absent(),
    this.repeatEndUsed = const Value.absent(),
    this.repeatEndDate = const Value.absent(),
    this.completed = const Value.absent(),
    this.missed = const Value.absent(),
    this.missedComment = const Value.absent(),
  });
  ScheduledCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    required DateTime date,
    required int startTime,
    required bool endUsed,
    required int endTime,
    this.repeatType = const Value.absent(),
    required bool repeatEndUsed,
    required DateTime repeatEndDate,
    this.completed = const Value.absent(),
    this.missed = const Value.absent(),
    this.missedComment = const Value.absent(),
  }) : title = Value(title),
       date = Value(date),
       startTime = Value(startTime),
       endUsed = Value(endUsed),
       endTime = Value(endTime),
       repeatEndUsed = Value(repeatEndUsed),
       repeatEndDate = Value(repeatEndDate);
  static Insertable<ScheduledData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? color,
    Expression<DateTime>? date,
    Expression<int>? startTime,
    Expression<bool>? endUsed,
    Expression<int>? endTime,
    Expression<String>? repeatType,
    Expression<bool>? repeatEndUsed,
    Expression<DateTime>? repeatEndDate,
    Expression<bool>? completed,
    Expression<bool>? missed,
    Expression<String>? missedComment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endUsed != null) 'end_used': endUsed,
      if (endTime != null) 'end_time': endTime,
      if (repeatType != null) 'repeat_type': repeatType,
      if (repeatEndUsed != null) 'repeat_end_used': repeatEndUsed,
      if (repeatEndDate != null) 'repeat_end_date': repeatEndDate,
      if (completed != null) 'completed': completed,
      if (missed != null) 'missed': missed,
      if (missedComment != null) 'missed_comment': missedComment,
    });
  }

  ScheduledCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int?>? color,
    Value<DateTime>? date,
    Value<int>? startTime,
    Value<bool>? endUsed,
    Value<int>? endTime,
    Value<String>? repeatType,
    Value<bool>? repeatEndUsed,
    Value<DateTime>? repeatEndDate,
    Value<bool>? completed,
    Value<bool>? missed,
    Value<String?>? missedComment,
  }) {
    return ScheduledCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endUsed: endUsed ?? this.endUsed,
      endTime: endTime ?? this.endTime,
      repeatType: repeatType ?? this.repeatType,
      repeatEndUsed: repeatEndUsed ?? this.repeatEndUsed,
      repeatEndDate: repeatEndDate ?? this.repeatEndDate,
      completed: completed ?? this.completed,
      missed: missed ?? this.missed,
      missedComment: missedComment ?? this.missedComment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endUsed.present) {
      map['end_used'] = Variable<bool>(endUsed.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (repeatType.present) {
      map['repeat_type'] = Variable<String>(repeatType.value);
    }
    if (repeatEndUsed.present) {
      map['repeat_end_used'] = Variable<bool>(repeatEndUsed.value);
    }
    if (repeatEndDate.present) {
      map['repeat_end_date'] = Variable<DateTime>(repeatEndDate.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (missed.present) {
      map['missed'] = Variable<bool>(missed.value);
    }
    if (missedComment.present) {
      map['missed_comment'] = Variable<String>(missedComment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduledCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('color: $color, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endUsed: $endUsed, ')
          ..write('endTime: $endTime, ')
          ..write('repeatType: $repeatType, ')
          ..write('repeatEndUsed: $repeatEndUsed, ')
          ..write('repeatEndDate: $repeatEndDate, ')
          ..write('completed: $completed, ')
          ..write('missed: $missed, ')
          ..write('missedComment: $missedComment')
          ..write(')'))
        .toString();
  }
}

class $CompletedPhotosTable extends CompletedPhotos
    with TableInfo<$CompletedPhotosTable, CompletedPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompletedPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scheduledIdMeta = const VerificationMeta(
    'scheduledId',
  );
  @override
  late final GeneratedColumn<int> scheduledId = GeneratedColumn<int>(
    'scheduled_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES scheduled(id)',
  );
  static const VerificationMeta _frontImgPathMeta = const VerificationMeta(
    'frontImgPath',
  );
  @override
  late final GeneratedColumn<String> frontImgPath = GeneratedColumn<String>(
    'front_img_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rearImgPathMeta = const VerificationMeta(
    'rearImgPath',
  );
  @override
  late final GeneratedColumn<String> rearImgPath = GeneratedColumn<String>(
    'rear_img_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scheduledId,
    frontImgPath,
    rearImgPath,
    takenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'completed_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompletedPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scheduled_id')) {
      context.handle(
        _scheduledIdMeta,
        scheduledId.isAcceptableOrUnknown(
          data['scheduled_id']!,
          _scheduledIdMeta,
        ),
      );
    }
    if (data.containsKey('front_img_path')) {
      context.handle(
        _frontImgPathMeta,
        frontImgPath.isAcceptableOrUnknown(
          data['front_img_path']!,
          _frontImgPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frontImgPathMeta);
    }
    if (data.containsKey('rear_img_path')) {
      context.handle(
        _rearImgPathMeta,
        rearImgPath.isAcceptableOrUnknown(
          data['rear_img_path']!,
          _rearImgPathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rearImgPathMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompletedPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompletedPhoto(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      scheduledId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scheduled_id'],
      ),
      frontImgPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}front_img_path'],
          )!,
      rearImgPath:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rear_img_path'],
          )!,
      takenAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}taken_at'],
          )!,
    );
  }

  @override
  $CompletedPhotosTable createAlias(String alias) {
    return $CompletedPhotosTable(attachedDatabase, alias);
  }
}

class CompletedPhoto extends DataClass implements Insertable<CompletedPhoto> {
  final int id;
  final int? scheduledId;
  final String frontImgPath;
  final String rearImgPath;
  final DateTime takenAt;
  const CompletedPhoto({
    required this.id,
    this.scheduledId,
    required this.frontImgPath,
    required this.rearImgPath,
    required this.takenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || scheduledId != null) {
      map['scheduled_id'] = Variable<int>(scheduledId);
    }
    map['front_img_path'] = Variable<String>(frontImgPath);
    map['rear_img_path'] = Variable<String>(rearImgPath);
    map['taken_at'] = Variable<DateTime>(takenAt);
    return map;
  }

  CompletedPhotosCompanion toCompanion(bool nullToAbsent) {
    return CompletedPhotosCompanion(
      id: Value(id),
      scheduledId:
          scheduledId == null && nullToAbsent
              ? const Value.absent()
              : Value(scheduledId),
      frontImgPath: Value(frontImgPath),
      rearImgPath: Value(rearImgPath),
      takenAt: Value(takenAt),
    );
  }

  factory CompletedPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompletedPhoto(
      id: serializer.fromJson<int>(json['id']),
      scheduledId: serializer.fromJson<int?>(json['scheduledId']),
      frontImgPath: serializer.fromJson<String>(json['frontImgPath']),
      rearImgPath: serializer.fromJson<String>(json['rearImgPath']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scheduledId': serializer.toJson<int?>(scheduledId),
      'frontImgPath': serializer.toJson<String>(frontImgPath),
      'rearImgPath': serializer.toJson<String>(rearImgPath),
      'takenAt': serializer.toJson<DateTime>(takenAt),
    };
  }

  CompletedPhoto copyWith({
    int? id,
    Value<int?> scheduledId = const Value.absent(),
    String? frontImgPath,
    String? rearImgPath,
    DateTime? takenAt,
  }) => CompletedPhoto(
    id: id ?? this.id,
    scheduledId: scheduledId.present ? scheduledId.value : this.scheduledId,
    frontImgPath: frontImgPath ?? this.frontImgPath,
    rearImgPath: rearImgPath ?? this.rearImgPath,
    takenAt: takenAt ?? this.takenAt,
  );
  CompletedPhoto copyWithCompanion(CompletedPhotosCompanion data) {
    return CompletedPhoto(
      id: data.id.present ? data.id.value : this.id,
      scheduledId:
          data.scheduledId.present ? data.scheduledId.value : this.scheduledId,
      frontImgPath:
          data.frontImgPath.present
              ? data.frontImgPath.value
              : this.frontImgPath,
      rearImgPath:
          data.rearImgPath.present ? data.rearImgPath.value : this.rearImgPath,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompletedPhoto(')
          ..write('id: $id, ')
          ..write('scheduledId: $scheduledId, ')
          ..write('frontImgPath: $frontImgPath, ')
          ..write('rearImgPath: $rearImgPath, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, scheduledId, frontImgPath, rearImgPath, takenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompletedPhoto &&
          other.id == this.id &&
          other.scheduledId == this.scheduledId &&
          other.frontImgPath == this.frontImgPath &&
          other.rearImgPath == this.rearImgPath &&
          other.takenAt == this.takenAt);
}

class CompletedPhotosCompanion extends UpdateCompanion<CompletedPhoto> {
  final Value<int> id;
  final Value<int?> scheduledId;
  final Value<String> frontImgPath;
  final Value<String> rearImgPath;
  final Value<DateTime> takenAt;
  const CompletedPhotosCompanion({
    this.id = const Value.absent(),
    this.scheduledId = const Value.absent(),
    this.frontImgPath = const Value.absent(),
    this.rearImgPath = const Value.absent(),
    this.takenAt = const Value.absent(),
  });
  CompletedPhotosCompanion.insert({
    this.id = const Value.absent(),
    this.scheduledId = const Value.absent(),
    required String frontImgPath,
    required String rearImgPath,
    required DateTime takenAt,
  }) : frontImgPath = Value(frontImgPath),
       rearImgPath = Value(rearImgPath),
       takenAt = Value(takenAt);
  static Insertable<CompletedPhoto> custom({
    Expression<int>? id,
    Expression<int>? scheduledId,
    Expression<String>? frontImgPath,
    Expression<String>? rearImgPath,
    Expression<DateTime>? takenAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduledId != null) 'scheduled_id': scheduledId,
      if (frontImgPath != null) 'front_img_path': frontImgPath,
      if (rearImgPath != null) 'rear_img_path': rearImgPath,
      if (takenAt != null) 'taken_at': takenAt,
    });
  }

  CompletedPhotosCompanion copyWith({
    Value<int>? id,
    Value<int?>? scheduledId,
    Value<String>? frontImgPath,
    Value<String>? rearImgPath,
    Value<DateTime>? takenAt,
  }) {
    return CompletedPhotosCompanion(
      id: id ?? this.id,
      scheduledId: scheduledId ?? this.scheduledId,
      frontImgPath: frontImgPath ?? this.frontImgPath,
      rearImgPath: rearImgPath ?? this.rearImgPath,
      takenAt: takenAt ?? this.takenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scheduledId.present) {
      map['scheduled_id'] = Variable<int>(scheduledId.value);
    }
    if (frontImgPath.present) {
      map['front_img_path'] = Variable<String>(frontImgPath.value);
    }
    if (rearImgPath.present) {
      map['rear_img_path'] = Variable<String>(rearImgPath.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompletedPhotosCompanion(')
          ..write('id: $id, ')
          ..write('scheduledId: $scheduledId, ')
          ..write('frontImgPath: $frontImgPath, ')
          ..write('rearImgPath: $rearImgPath, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ScheduledTable scheduled = $ScheduledTable(this);
  late final $CompletedPhotosTable completedPhotos = $CompletedPhotosTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scheduled,
    completedPhotos,
  ];
}

typedef $$ScheduledTableCreateCompanionBuilder =
    ScheduledCompanion Function({
      Value<int> id,
      required String title,
      Value<int?> color,
      required DateTime date,
      required int startTime,
      required bool endUsed,
      required int endTime,
      Value<String> repeatType,
      required bool repeatEndUsed,
      required DateTime repeatEndDate,
      Value<bool> completed,
      Value<bool> missed,
      Value<String?> missedComment,
    });
typedef $$ScheduledTableUpdateCompanionBuilder =
    ScheduledCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int?> color,
      Value<DateTime> date,
      Value<int> startTime,
      Value<bool> endUsed,
      Value<int> endTime,
      Value<String> repeatType,
      Value<bool> repeatEndUsed,
      Value<DateTime> repeatEndDate,
      Value<bool> completed,
      Value<bool> missed,
      Value<String?> missedComment,
    });

class $$ScheduledTableFilterComposer
    extends Composer<_$LocalDatabase, $ScheduledTable> {
  $$ScheduledTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get endUsed => $composableBuilder(
    column: $table.endUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get repeatEndUsed => $composableBuilder(
    column: $table.repeatEndUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get repeatEndDate => $composableBuilder(
    column: $table.repeatEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get missed => $composableBuilder(
    column: $table.missed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get missedComment => $composableBuilder(
    column: $table.missedComment,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduledTableOrderingComposer
    extends Composer<_$LocalDatabase, $ScheduledTable> {
  $$ScheduledTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get endUsed => $composableBuilder(
    column: $table.endUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get repeatEndUsed => $composableBuilder(
    column: $table.repeatEndUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get repeatEndDate => $composableBuilder(
    column: $table.repeatEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get missed => $composableBuilder(
    column: $table.missed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get missedComment => $composableBuilder(
    column: $table.missedComment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduledTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ScheduledTable> {
  $$ScheduledTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<bool> get endUsed =>
      $composableBuilder(column: $table.endUsed, builder: (column) => column);

  GeneratedColumn<int> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get repeatEndUsed => $composableBuilder(
    column: $table.repeatEndUsed,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get repeatEndDate => $composableBuilder(
    column: $table.repeatEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<bool> get missed =>
      $composableBuilder(column: $table.missed, builder: (column) => column);

  GeneratedColumn<String> get missedComment => $composableBuilder(
    column: $table.missedComment,
    builder: (column) => column,
  );
}

class $$ScheduledTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ScheduledTable,
          ScheduledData,
          $$ScheduledTableFilterComposer,
          $$ScheduledTableOrderingComposer,
          $$ScheduledTableAnnotationComposer,
          $$ScheduledTableCreateCompanionBuilder,
          $$ScheduledTableUpdateCompanionBuilder,
          (
            ScheduledData,
            BaseReferences<_$LocalDatabase, $ScheduledTable, ScheduledData>,
          ),
          ScheduledData,
          PrefetchHooks Function()
        > {
  $$ScheduledTableTableManager(_$LocalDatabase db, $ScheduledTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ScheduledTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ScheduledTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ScheduledTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> color = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> startTime = const Value.absent(),
                Value<bool> endUsed = const Value.absent(),
                Value<int> endTime = const Value.absent(),
                Value<String> repeatType = const Value.absent(),
                Value<bool> repeatEndUsed = const Value.absent(),
                Value<DateTime> repeatEndDate = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<bool> missed = const Value.absent(),
                Value<String?> missedComment = const Value.absent(),
              }) => ScheduledCompanion(
                id: id,
                title: title,
                color: color,
                date: date,
                startTime: startTime,
                endUsed: endUsed,
                endTime: endTime,
                repeatType: repeatType,
                repeatEndUsed: repeatEndUsed,
                repeatEndDate: repeatEndDate,
                completed: completed,
                missed: missed,
                missedComment: missedComment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<int?> color = const Value.absent(),
                required DateTime date,
                required int startTime,
                required bool endUsed,
                required int endTime,
                Value<String> repeatType = const Value.absent(),
                required bool repeatEndUsed,
                required DateTime repeatEndDate,
                Value<bool> completed = const Value.absent(),
                Value<bool> missed = const Value.absent(),
                Value<String?> missedComment = const Value.absent(),
              }) => ScheduledCompanion.insert(
                id: id,
                title: title,
                color: color,
                date: date,
                startTime: startTime,
                endUsed: endUsed,
                endTime: endTime,
                repeatType: repeatType,
                repeatEndUsed: repeatEndUsed,
                repeatEndDate: repeatEndDate,
                completed: completed,
                missed: missed,
                missedComment: missedComment,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduledTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ScheduledTable,
      ScheduledData,
      $$ScheduledTableFilterComposer,
      $$ScheduledTableOrderingComposer,
      $$ScheduledTableAnnotationComposer,
      $$ScheduledTableCreateCompanionBuilder,
      $$ScheduledTableUpdateCompanionBuilder,
      (
        ScheduledData,
        BaseReferences<_$LocalDatabase, $ScheduledTable, ScheduledData>,
      ),
      ScheduledData,
      PrefetchHooks Function()
    >;
typedef $$CompletedPhotosTableCreateCompanionBuilder =
    CompletedPhotosCompanion Function({
      Value<int> id,
      Value<int?> scheduledId,
      required String frontImgPath,
      required String rearImgPath,
      required DateTime takenAt,
    });
typedef $$CompletedPhotosTableUpdateCompanionBuilder =
    CompletedPhotosCompanion Function({
      Value<int> id,
      Value<int?> scheduledId,
      Value<String> frontImgPath,
      Value<String> rearImgPath,
      Value<DateTime> takenAt,
    });

class $$CompletedPhotosTableFilterComposer
    extends Composer<_$LocalDatabase, $CompletedPhotosTable> {
  $$CompletedPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scheduledId => $composableBuilder(
    column: $table.scheduledId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frontImgPath => $composableBuilder(
    column: $table.frontImgPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rearImgPath => $composableBuilder(
    column: $table.rearImgPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompletedPhotosTableOrderingComposer
    extends Composer<_$LocalDatabase, $CompletedPhotosTable> {
  $$CompletedPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledId => $composableBuilder(
    column: $table.scheduledId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frontImgPath => $composableBuilder(
    column: $table.frontImgPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rearImgPath => $composableBuilder(
    column: $table.rearImgPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompletedPhotosTableAnnotationComposer
    extends Composer<_$LocalDatabase, $CompletedPhotosTable> {
  $$CompletedPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get scheduledId => $composableBuilder(
    column: $table.scheduledId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frontImgPath => $composableBuilder(
    column: $table.frontImgPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rearImgPath => $composableBuilder(
    column: $table.rearImgPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);
}

class $$CompletedPhotosTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $CompletedPhotosTable,
          CompletedPhoto,
          $$CompletedPhotosTableFilterComposer,
          $$CompletedPhotosTableOrderingComposer,
          $$CompletedPhotosTableAnnotationComposer,
          $$CompletedPhotosTableCreateCompanionBuilder,
          $$CompletedPhotosTableUpdateCompanionBuilder,
          (
            CompletedPhoto,
            BaseReferences<
              _$LocalDatabase,
              $CompletedPhotosTable,
              CompletedPhoto
            >,
          ),
          CompletedPhoto,
          PrefetchHooks Function()
        > {
  $$CompletedPhotosTableTableManager(
    _$LocalDatabase db,
    $CompletedPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CompletedPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CompletedPhotosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CompletedPhotosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduledId = const Value.absent(),
                Value<String> frontImgPath = const Value.absent(),
                Value<String> rearImgPath = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
              }) => CompletedPhotosCompanion(
                id: id,
                scheduledId: scheduledId,
                frontImgPath: frontImgPath,
                rearImgPath: rearImgPath,
                takenAt: takenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> scheduledId = const Value.absent(),
                required String frontImgPath,
                required String rearImgPath,
                required DateTime takenAt,
              }) => CompletedPhotosCompanion.insert(
                id: id,
                scheduledId: scheduledId,
                frontImgPath: frontImgPath,
                rearImgPath: rearImgPath,
                takenAt: takenAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompletedPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $CompletedPhotosTable,
      CompletedPhoto,
      $$CompletedPhotosTableFilterComposer,
      $$CompletedPhotosTableOrderingComposer,
      $$CompletedPhotosTableAnnotationComposer,
      $$CompletedPhotosTableCreateCompanionBuilder,
      $$CompletedPhotosTableUpdateCompanionBuilder,
      (
        CompletedPhoto,
        BaseReferences<_$LocalDatabase, $CompletedPhotosTable, CompletedPhoto>,
      ),
      CompletedPhoto,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ScheduledTableTableManager get scheduled =>
      $$ScheduledTableTableManager(_db, _db.scheduled);
  $$CompletedPhotosTableTableManager get completedPhotos =>
      $$CompletedPhotosTableTableManager(_db, _db.completedPhotos);
}
