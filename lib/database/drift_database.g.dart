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
  static const VerificationMeta _repeateTypeMeta = const VerificationMeta(
    'repeateType',
  );
  @override
  late final GeneratedColumn<String> repeateType = GeneratedColumn<String>(
    'repeate_type',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    color,
    date,
    startTime,
    endUsed,
    endTime,
    repeateType,
    repeatEndUsed,
    repeatEndDate,
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
    if (data.containsKey('repeate_type')) {
      context.handle(
        _repeateTypeMeta,
        repeateType.isAcceptableOrUnknown(
          data['repeate_type']!,
          _repeateTypeMeta,
        ),
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
      repeateType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}repeate_type'],
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
  final String repeateType;
  final bool repeatEndUsed;
  final DateTime repeatEndDate;
  const ScheduledData({
    required this.id,
    required this.title,
    this.color,
    required this.date,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.repeateType,
    required this.repeatEndUsed,
    required this.repeatEndDate,
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
    map['repeate_type'] = Variable<String>(repeateType);
    map['repeat_end_used'] = Variable<bool>(repeatEndUsed);
    map['repeat_end_date'] = Variable<DateTime>(repeatEndDate);
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
      repeateType: Value(repeateType),
      repeatEndUsed: Value(repeatEndUsed),
      repeatEndDate: Value(repeatEndDate),
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
      repeateType: serializer.fromJson<String>(json['repeateType']),
      repeatEndUsed: serializer.fromJson<bool>(json['repeatEndUsed']),
      repeatEndDate: serializer.fromJson<DateTime>(json['repeatEndDate']),
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
      'repeateType': serializer.toJson<String>(repeateType),
      'repeatEndUsed': serializer.toJson<bool>(repeatEndUsed),
      'repeatEndDate': serializer.toJson<DateTime>(repeatEndDate),
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
    String? repeateType,
    bool? repeatEndUsed,
    DateTime? repeatEndDate,
  }) => ScheduledData(
    id: id ?? this.id,
    title: title ?? this.title,
    color: color.present ? color.value : this.color,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endUsed: endUsed ?? this.endUsed,
    endTime: endTime ?? this.endTime,
    repeateType: repeateType ?? this.repeateType,
    repeatEndUsed: repeatEndUsed ?? this.repeatEndUsed,
    repeatEndDate: repeatEndDate ?? this.repeatEndDate,
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
      repeateType:
          data.repeateType.present ? data.repeateType.value : this.repeateType,
      repeatEndUsed:
          data.repeatEndUsed.present
              ? data.repeatEndUsed.value
              : this.repeatEndUsed,
      repeatEndDate:
          data.repeatEndDate.present
              ? data.repeatEndDate.value
              : this.repeatEndDate,
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
          ..write('repeateType: $repeateType, ')
          ..write('repeatEndUsed: $repeatEndUsed, ')
          ..write('repeatEndDate: $repeatEndDate')
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
    repeateType,
    repeatEndUsed,
    repeatEndDate,
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
          other.repeateType == this.repeateType &&
          other.repeatEndUsed == this.repeatEndUsed &&
          other.repeatEndDate == this.repeatEndDate);
}

class ScheduledCompanion extends UpdateCompanion<ScheduledData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> color;
  final Value<DateTime> date;
  final Value<int> startTime;
  final Value<bool> endUsed;
  final Value<int> endTime;
  final Value<String> repeateType;
  final Value<bool> repeatEndUsed;
  final Value<DateTime> repeatEndDate;
  const ScheduledCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.color = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endUsed = const Value.absent(),
    this.endTime = const Value.absent(),
    this.repeateType = const Value.absent(),
    this.repeatEndUsed = const Value.absent(),
    this.repeatEndDate = const Value.absent(),
  });
  ScheduledCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.color = const Value.absent(),
    required DateTime date,
    required int startTime,
    required bool endUsed,
    required int endTime,
    this.repeateType = const Value.absent(),
    required bool repeatEndUsed,
    required DateTime repeatEndDate,
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
    Expression<String>? repeateType,
    Expression<bool>? repeatEndUsed,
    Expression<DateTime>? repeatEndDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (color != null) 'color': color,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endUsed != null) 'end_used': endUsed,
      if (endTime != null) 'end_time': endTime,
      if (repeateType != null) 'repeate_type': repeateType,
      if (repeatEndUsed != null) 'repeat_end_used': repeatEndUsed,
      if (repeatEndDate != null) 'repeat_end_date': repeatEndDate,
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
    Value<String>? repeateType,
    Value<bool>? repeatEndUsed,
    Value<DateTime>? repeatEndDate,
  }) {
    return ScheduledCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endUsed: endUsed ?? this.endUsed,
      endTime: endTime ?? this.endTime,
      repeateType: repeateType ?? this.repeateType,
      repeatEndUsed: repeatEndUsed ?? this.repeatEndUsed,
      repeatEndDate: repeatEndDate ?? this.repeatEndDate,
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
    if (repeateType.present) {
      map['repeate_type'] = Variable<String>(repeateType.value);
    }
    if (repeatEndUsed.present) {
      map['repeat_end_used'] = Variable<bool>(repeatEndUsed.value);
    }
    if (repeatEndDate.present) {
      map['repeat_end_date'] = Variable<DateTime>(repeatEndDate.value);
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
          ..write('repeateType: $repeateType, ')
          ..write('repeatEndUsed: $repeatEndUsed, ')
          ..write('repeatEndDate: $repeatEndDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $ScheduledTable scheduled = $ScheduledTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scheduled];
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
      Value<String> repeateType,
      required bool repeatEndUsed,
      required DateTime repeatEndDate,
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
      Value<String> repeateType,
      Value<bool> repeatEndUsed,
      Value<DateTime> repeatEndDate,
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

  ColumnFilters<String> get repeateType => $composableBuilder(
    column: $table.repeateType,
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

  ColumnOrderings<String> get repeateType => $composableBuilder(
    column: $table.repeateType,
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

  GeneratedColumn<String> get repeateType => $composableBuilder(
    column: $table.repeateType,
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
                Value<String> repeateType = const Value.absent(),
                Value<bool> repeatEndUsed = const Value.absent(),
                Value<DateTime> repeatEndDate = const Value.absent(),
              }) => ScheduledCompanion(
                id: id,
                title: title,
                color: color,
                date: date,
                startTime: startTime,
                endUsed: endUsed,
                endTime: endTime,
                repeateType: repeateType,
                repeatEndUsed: repeatEndUsed,
                repeatEndDate: repeatEndDate,
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
                Value<String> repeateType = const Value.absent(),
                required bool repeatEndUsed,
                required DateTime repeatEndDate,
              }) => ScheduledCompanion.insert(
                id: id,
                title: title,
                color: color,
                date: date,
                startTime: startTime,
                endUsed: endUsed,
                endTime: endTime,
                repeateType: repeateType,
                repeatEndUsed: repeatEndUsed,
                repeatEndDate: repeatEndDate,
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

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$ScheduledTableTableManager get scheduled =>
      $$ScheduledTableTableManager(_db, _db.scheduled);
}
