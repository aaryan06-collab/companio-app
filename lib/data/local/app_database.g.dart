// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    role,
    username,
    passwordHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String name;
  final String role;
  final String? username;
  final String? passwordHash;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.name,
    required this.role,
    this.username,
    this.passwordHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      username: serializer.fromJson<String?>(json['username']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'username': serializer.toJson<String?>(username),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? role,
    Value<String?> username = const Value.absent(),
    Value<String?> passwordHash = const Value.absent(),
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    role: role ?? this.role,
    username: username.present ? username.value : this.username,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, role, username, passwordHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String?> username;
  final Value<String?> passwordHash;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String role,
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role),
       createdAt = Value(createdAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? role,
    Value<String?>? username,
    Value<String?>? passwordHash,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PatientProfilesTable extends PatientProfiles
    with TableInfo<$PatientProfilesTable, PatientProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi'),
  );
  static const VerificationMeta _voiceLanguageMeta = const VerificationMeta(
    'voiceLanguage',
  );
  @override
  late final GeneratedColumn<String> voiceLanguage = GeneratedColumn<String>(
    'voice_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi-IN'),
  );
  static const VerificationMeta _avatarEmojiMeta = const VerificationMeta(
    'avatarEmoji',
  );
  @override
  late final GeneratedColumn<String> avatarEmoji = GeneratedColumn<String>(
    'avatar_emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('🌸'),
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    displayName,
    region,
    language,
    voiceLanguage,
    avatarEmoji,
    dateOfBirth,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patient_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatientProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('voice_language')) {
      context.handle(
        _voiceLanguageMeta,
        voiceLanguage.isAcceptableOrUnknown(
          data['voice_language']!,
          _voiceLanguageMeta,
        ),
      );
    }
    if (data.containsKey('avatar_emoji')) {
      context.handle(
        _avatarEmojiMeta,
        avatarEmoji.isAcceptableOrUnknown(
          data['avatar_emoji']!,
          _avatarEmojiMeta,
        ),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PatientProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatientProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      voiceLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_language'],
      )!,
      avatarEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_emoji'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PatientProfilesTable createAlias(String alias) {
    return $PatientProfilesTable(attachedDatabase, alias);
  }
}

class PatientProfile extends DataClass implements Insertable<PatientProfile> {
  final String id;
  final String userId;
  final String displayName;
  final String? region;
  final String language;
  final String voiceLanguage;
  final String avatarEmoji;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  const PatientProfile({
    required this.id,
    required this.userId,
    required this.displayName,
    this.region,
    required this.language,
    required this.voiceLanguage,
    required this.avatarEmoji,
    this.dateOfBirth,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['language'] = Variable<String>(language);
    map['voice_language'] = Variable<String>(voiceLanguage);
    map['avatar_emoji'] = Variable<String>(avatarEmoji);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PatientProfilesCompanion toCompanion(bool nullToAbsent) {
    return PatientProfilesCompanion(
      id: Value(id),
      userId: Value(userId),
      displayName: Value(displayName),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      language: Value(language),
      voiceLanguage: Value(voiceLanguage),
      avatarEmoji: Value(avatarEmoji),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      createdAt: Value(createdAt),
    );
  }

  factory PatientProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatientProfile(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      region: serializer.fromJson<String?>(json['region']),
      language: serializer.fromJson<String>(json['language']),
      voiceLanguage: serializer.fromJson<String>(json['voiceLanguage']),
      avatarEmoji: serializer.fromJson<String>(json['avatarEmoji']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'displayName': serializer.toJson<String>(displayName),
      'region': serializer.toJson<String?>(region),
      'language': serializer.toJson<String>(language),
      'voiceLanguage': serializer.toJson<String>(voiceLanguage),
      'avatarEmoji': serializer.toJson<String>(avatarEmoji),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PatientProfile copyWith({
    String? id,
    String? userId,
    String? displayName,
    Value<String?> region = const Value.absent(),
    String? language,
    String? voiceLanguage,
    String? avatarEmoji,
    Value<DateTime?> dateOfBirth = const Value.absent(),
    DateTime? createdAt,
  }) => PatientProfile(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    displayName: displayName ?? this.displayName,
    region: region.present ? region.value : this.region,
    language: language ?? this.language,
    voiceLanguage: voiceLanguage ?? this.voiceLanguage,
    avatarEmoji: avatarEmoji ?? this.avatarEmoji,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    createdAt: createdAt ?? this.createdAt,
  );
  PatientProfile copyWithCompanion(PatientProfilesCompanion data) {
    return PatientProfile(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      region: data.region.present ? data.region.value : this.region,
      language: data.language.present ? data.language.value : this.language,
      voiceLanguage: data.voiceLanguage.present
          ? data.voiceLanguage.value
          : this.voiceLanguage,
      avatarEmoji: data.avatarEmoji.present
          ? data.avatarEmoji.value
          : this.avatarEmoji,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfile(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('displayName: $displayName, ')
          ..write('region: $region, ')
          ..write('language: $language, ')
          ..write('voiceLanguage: $voiceLanguage, ')
          ..write('avatarEmoji: $avatarEmoji, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    displayName,
    region,
    language,
    voiceLanguage,
    avatarEmoji,
    dateOfBirth,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatientProfile &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.displayName == this.displayName &&
          other.region == this.region &&
          other.language == this.language &&
          other.voiceLanguage == this.voiceLanguage &&
          other.avatarEmoji == this.avatarEmoji &&
          other.dateOfBirth == this.dateOfBirth &&
          other.createdAt == this.createdAt);
}

class PatientProfilesCompanion extends UpdateCompanion<PatientProfile> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> displayName;
  final Value<String?> region;
  final Value<String> language;
  final Value<String> voiceLanguage;
  final Value<String> avatarEmoji;
  final Value<DateTime?> dateOfBirth;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PatientProfilesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.region = const Value.absent(),
    this.language = const Value.absent(),
    this.voiceLanguage = const Value.absent(),
    this.avatarEmoji = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatientProfilesCompanion.insert({
    required String id,
    required String userId,
    required String displayName,
    this.region = const Value.absent(),
    this.language = const Value.absent(),
    this.voiceLanguage = const Value.absent(),
    this.avatarEmoji = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<PatientProfile> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? displayName,
    Expression<String>? region,
    Expression<String>? language,
    Expression<String>? voiceLanguage,
    Expression<String>? avatarEmoji,
    Expression<DateTime>? dateOfBirth,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (displayName != null) 'display_name': displayName,
      if (region != null) 'region': region,
      if (language != null) 'language': language,
      if (voiceLanguage != null) 'voice_language': voiceLanguage,
      if (avatarEmoji != null) 'avatar_emoji': avatarEmoji,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatientProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? displayName,
    Value<String?>? region,
    Value<String>? language,
    Value<String>? voiceLanguage,
    Value<String>? avatarEmoji,
    Value<DateTime?>? dateOfBirth,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PatientProfilesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      region: region ?? this.region,
      language: language ?? this.language,
      voiceLanguage: voiceLanguage ?? this.voiceLanguage,
      avatarEmoji: avatarEmoji ?? this.avatarEmoji,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (voiceLanguage.present) {
      map['voice_language'] = Variable<String>(voiceLanguage.value);
    }
    if (avatarEmoji.present) {
      map['avatar_emoji'] = Variable<String>(avatarEmoji.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientProfilesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('displayName: $displayName, ')
          ..write('region: $region, ')
          ..write('language: $language, ')
          ..write('voiceLanguage: $voiceLanguage, ')
          ..write('avatarEmoji: $avatarEmoji, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaregiverLinksTable extends CaregiverLinks
    with TableInfo<$CaregiverLinksTable, CaregiverLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaregiverLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caregiverIdMeta = const VerificationMeta(
    'caregiverId',
  );
  @override
  late final GeneratedColumn<String> caregiverId = GeneratedColumn<String>(
    'caregiver_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationshipMeta = const VerificationMeta(
    'relationship',
  );
  @override
  late final GeneratedColumn<String> relationship = GeneratedColumn<String>(
    'relationship',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caregiverId,
    patientId,
    relationship,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'caregiver_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaregiverLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('caregiver_id')) {
      context.handle(
        _caregiverIdMeta,
        caregiverId.isAcceptableOrUnknown(
          data['caregiver_id']!,
          _caregiverIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caregiverIdMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('relationship')) {
      context.handle(
        _relationshipMeta,
        relationship.isAcceptableOrUnknown(
          data['relationship']!,
          _relationshipMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaregiverLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaregiverLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caregiverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caregiver_id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      relationship: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relationship'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CaregiverLinksTable createAlias(String alias) {
    return $CaregiverLinksTable(attachedDatabase, alias);
  }
}

class CaregiverLink extends DataClass implements Insertable<CaregiverLink> {
  final String id;
  final String caregiverId;
  final String patientId;
  final String? relationship;
  final DateTime createdAt;
  const CaregiverLink({
    required this.id,
    required this.caregiverId,
    required this.patientId,
    this.relationship,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['caregiver_id'] = Variable<String>(caregiverId);
    map['patient_id'] = Variable<String>(patientId);
    if (!nullToAbsent || relationship != null) {
      map['relationship'] = Variable<String>(relationship);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CaregiverLinksCompanion toCompanion(bool nullToAbsent) {
    return CaregiverLinksCompanion(
      id: Value(id),
      caregiverId: Value(caregiverId),
      patientId: Value(patientId),
      relationship: relationship == null && nullToAbsent
          ? const Value.absent()
          : Value(relationship),
      createdAt: Value(createdAt),
    );
  }

  factory CaregiverLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaregiverLink(
      id: serializer.fromJson<String>(json['id']),
      caregiverId: serializer.fromJson<String>(json['caregiverId']),
      patientId: serializer.fromJson<String>(json['patientId']),
      relationship: serializer.fromJson<String?>(json['relationship']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caregiverId': serializer.toJson<String>(caregiverId),
      'patientId': serializer.toJson<String>(patientId),
      'relationship': serializer.toJson<String?>(relationship),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CaregiverLink copyWith({
    String? id,
    String? caregiverId,
    String? patientId,
    Value<String?> relationship = const Value.absent(),
    DateTime? createdAt,
  }) => CaregiverLink(
    id: id ?? this.id,
    caregiverId: caregiverId ?? this.caregiverId,
    patientId: patientId ?? this.patientId,
    relationship: relationship.present ? relationship.value : this.relationship,
    createdAt: createdAt ?? this.createdAt,
  );
  CaregiverLink copyWithCompanion(CaregiverLinksCompanion data) {
    return CaregiverLink(
      id: data.id.present ? data.id.value : this.id,
      caregiverId: data.caregiverId.present
          ? data.caregiverId.value
          : this.caregiverId,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      relationship: data.relationship.present
          ? data.relationship.value
          : this.relationship,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverLink(')
          ..write('id: $id, ')
          ..write('caregiverId: $caregiverId, ')
          ..write('patientId: $patientId, ')
          ..write('relationship: $relationship, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, caregiverId, patientId, relationship, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaregiverLink &&
          other.id == this.id &&
          other.caregiverId == this.caregiverId &&
          other.patientId == this.patientId &&
          other.relationship == this.relationship &&
          other.createdAt == this.createdAt);
}

class CaregiverLinksCompanion extends UpdateCompanion<CaregiverLink> {
  final Value<String> id;
  final Value<String> caregiverId;
  final Value<String> patientId;
  final Value<String?> relationship;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CaregiverLinksCompanion({
    this.id = const Value.absent(),
    this.caregiverId = const Value.absent(),
    this.patientId = const Value.absent(),
    this.relationship = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaregiverLinksCompanion.insert({
    required String id,
    required String caregiverId,
    required String patientId,
    this.relationship = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       caregiverId = Value(caregiverId),
       patientId = Value(patientId),
       createdAt = Value(createdAt);
  static Insertable<CaregiverLink> custom({
    Expression<String>? id,
    Expression<String>? caregiverId,
    Expression<String>? patientId,
    Expression<String>? relationship,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caregiverId != null) 'caregiver_id': caregiverId,
      if (patientId != null) 'patient_id': patientId,
      if (relationship != null) 'relationship': relationship,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaregiverLinksCompanion copyWith({
    Value<String>? id,
    Value<String>? caregiverId,
    Value<String>? patientId,
    Value<String?>? relationship,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CaregiverLinksCompanion(
      id: id ?? this.id,
      caregiverId: caregiverId ?? this.caregiverId,
      patientId: patientId ?? this.patientId,
      relationship: relationship ?? this.relationship,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caregiverId.present) {
      map['caregiver_id'] = Variable<String>(caregiverId.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (relationship.present) {
      map['relationship'] = Variable<String>(relationship.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverLinksCompanion(')
          ..write('id: $id, ')
          ..write('caregiverId: $caregiverId, ')
          ..write('patientId: $patientId, ')
          ..write('relationship: $relationship, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmergencyContactsTable extends EmergencyContacts
    with TableInfo<$EmergencyContactsTable, EmergencyContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EscalationPriority, String>
  priority =
      GeneratedColumn<String>(
        'priority',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EscalationPriority>(
        $EmergencyContactsTable.$converterpriority,
      );
  static const VerificationMeta _canCallMeta = const VerificationMeta(
    'canCall',
  );
  @override
  late final GeneratedColumn<bool> canCall = GeneratedColumn<bool>(
    'can_call',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_call" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _canSmsMeta = const VerificationMeta('canSms');
  @override
  late final GeneratedColumn<bool> canSms = GeneratedColumn<bool>(
    'can_sms',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_sms" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    name,
    phone,
    relation,
    priority,
    canCall,
    canSms,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyContact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    }
    if (data.containsKey('can_call')) {
      context.handle(
        _canCallMeta,
        canCall.isAcceptableOrUnknown(data['can_call']!, _canCallMeta),
      );
    }
    if (data.containsKey('can_sms')) {
      context.handle(
        _canSmsMeta,
        canSms.isAcceptableOrUnknown(data['can_sms']!, _canSmsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyContact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      ),
      priority: $EmergencyContactsTable.$converterpriority.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}priority'],
        )!,
      ),
      canCall: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_call'],
      )!,
      canSms: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_sms'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EmergencyContactsTable createAlias(String alias) {
    return $EmergencyContactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EscalationPriority, String, String>
  $converterpriority = const EnumNameConverter<EscalationPriority>(
    EscalationPriority.values,
  );
}

class EmergencyContact extends DataClass
    implements Insertable<EmergencyContact> {
  final String id;
  final String patientId;
  final String name;
  final String phone;
  final String? relation;
  final EscalationPriority priority;
  final bool canCall;
  final bool canSms;
  final DateTime createdAt;
  const EmergencyContact({
    required this.id,
    required this.patientId,
    required this.name,
    required this.phone,
    this.relation,
    required this.priority,
    required this.canCall,
    required this.canSms,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || relation != null) {
      map['relation'] = Variable<String>(relation);
    }
    {
      map['priority'] = Variable<String>(
        $EmergencyContactsTable.$converterpriority.toSql(priority),
      );
    }
    map['can_call'] = Variable<bool>(canCall);
    map['can_sms'] = Variable<bool>(canSms);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EmergencyContactsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyContactsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      phone: Value(phone),
      relation: relation == null && nullToAbsent
          ? const Value.absent()
          : Value(relation),
      priority: Value(priority),
      canCall: Value(canCall),
      canSms: Value(canSms),
      createdAt: Value(createdAt),
    );
  }

  factory EmergencyContact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyContact(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      relation: serializer.fromJson<String?>(json['relation']),
      priority: $EmergencyContactsTable.$converterpriority.fromJson(
        serializer.fromJson<String>(json['priority']),
      ),
      canCall: serializer.fromJson<bool>(json['canCall']),
      canSms: serializer.fromJson<bool>(json['canSms']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'relation': serializer.toJson<String?>(relation),
      'priority': serializer.toJson<String>(
        $EmergencyContactsTable.$converterpriority.toJson(priority),
      ),
      'canCall': serializer.toJson<bool>(canCall),
      'canSms': serializer.toJson<bool>(canSms),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EmergencyContact copyWith({
    String? id,
    String? patientId,
    String? name,
    String? phone,
    Value<String?> relation = const Value.absent(),
    EscalationPriority? priority,
    bool? canCall,
    bool? canSms,
    DateTime? createdAt,
  }) => EmergencyContact(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    relation: relation.present ? relation.value : this.relation,
    priority: priority ?? this.priority,
    canCall: canCall ?? this.canCall,
    canSms: canSms ?? this.canSms,
    createdAt: createdAt ?? this.createdAt,
  );
  EmergencyContact copyWithCompanion(EmergencyContactsCompanion data) {
    return EmergencyContact(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      relation: data.relation.present ? data.relation.value : this.relation,
      priority: data.priority.present ? data.priority.value : this.priority,
      canCall: data.canCall.present ? data.canCall.value : this.canCall,
      canSms: data.canSms.present ? data.canSms.value : this.canSms,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyContact(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('relation: $relation, ')
          ..write('priority: $priority, ')
          ..write('canCall: $canCall, ')
          ..write('canSms: $canSms, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    name,
    phone,
    relation,
    priority,
    canCall,
    canSms,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyContact &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.relation == this.relation &&
          other.priority == this.priority &&
          other.canCall == this.canCall &&
          other.canSms == this.canSms &&
          other.createdAt == this.createdAt);
}

class EmergencyContactsCompanion extends UpdateCompanion<EmergencyContact> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> relation;
  final Value<EscalationPriority> priority;
  final Value<bool> canCall;
  final Value<bool> canSms;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const EmergencyContactsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.relation = const Value.absent(),
    this.priority = const Value.absent(),
    this.canCall = const Value.absent(),
    this.canSms = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmergencyContactsCompanion.insert({
    required String id,
    required String patientId,
    required String name,
    required String phone,
    this.relation = const Value.absent(),
    required EscalationPriority priority,
    this.canCall = const Value.absent(),
    this.canSms = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       name = Value(name),
       phone = Value(phone),
       priority = Value(priority),
       createdAt = Value(createdAt);
  static Insertable<EmergencyContact> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? relation,
    Expression<String>? priority,
    Expression<bool>? canCall,
    Expression<bool>? canSms,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (relation != null) 'relation': relation,
      if (priority != null) 'priority': priority,
      if (canCall != null) 'can_call': canCall,
      if (canSms != null) 'can_sms': canSms,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmergencyContactsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? relation,
    Value<EscalationPriority>? priority,
    Value<bool>? canCall,
    Value<bool>? canSms,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return EmergencyContactsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      relation: relation ?? this.relation,
      priority: priority ?? this.priority,
      canCall: canCall ?? this.canCall,
      canSms: canSms ?? this.canSms,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(
        $EmergencyContactsTable.$converterpriority.toSql(priority.value),
      );
    }
    if (canCall.present) {
      map['can_call'] = Variable<bool>(canCall.value);
    }
    if (canSms.present) {
      map['can_sms'] = Variable<bool>(canSms.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyContactsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('relation: $relation, ')
          ..write('priority: $priority, ')
          ..write('canCall: $canCall, ')
          ..write('canSms: $canSms, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleKeyMeta = const VerificationMeta(
    'titleKey',
  );
  @override
  late final GeneratedColumn<String> titleKey = GeneratedColumn<String>(
    'title_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtitleKeyMeta = const VerificationMeta(
    'subtitleKey',
  );
  @override
  late final GeneratedColumn<String> subtitleKey = GeneratedColumn<String>(
    'subtitle_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, String>
  baseDifficulty = GeneratedColumn<String>(
    'base_difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Difficulty>($ActivitiesTable.$converterbaseDifficulty);
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(180),
  );
  static const VerificationMeta _contentJsonMeta = const VerificationMeta(
    'contentJson',
  );
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
    'content_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    titleKey,
    subtitleKey,
    category,
    baseDifficulty,
    durationSec,
    contentJson,
    isCustom,
    region,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title_key')) {
      context.handle(
        _titleKeyMeta,
        titleKey.isAcceptableOrUnknown(data['title_key']!, _titleKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_titleKeyMeta);
    }
    if (data.containsKey('subtitle_key')) {
      context.handle(
        _subtitleKeyMeta,
        subtitleKey.isAcceptableOrUnknown(
          data['subtitle_key']!,
          _subtitleKeyMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    }
    if (data.containsKey('content_json')) {
      context.handle(
        _contentJsonMeta,
        contentJson.isAcceptableOrUnknown(
          data['content_json']!,
          _contentJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      titleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_key'],
      )!,
      subtitleKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle_key'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      baseDifficulty: $ActivitiesTable.$converterbaseDifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}base_difficulty'],
        )!,
      ),
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      contentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_json'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, String, String>
  $converterbaseDifficulty = const EnumNameConverter<Difficulty>(
    Difficulty.values,
  );
}

class Activity extends DataClass implements Insertable<Activity> {
  final String id;
  final String type;
  final String titleKey;
  final String? subtitleKey;
  final String category;
  final Difficulty baseDifficulty;
  final int durationSec;
  final String contentJson;
  final bool isCustom;
  final String? region;
  final bool enabled;
  const Activity({
    required this.id,
    required this.type,
    required this.titleKey,
    this.subtitleKey,
    required this.category,
    required this.baseDifficulty,
    required this.durationSec,
    required this.contentJson,
    required this.isCustom,
    this.region,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['title_key'] = Variable<String>(titleKey);
    if (!nullToAbsent || subtitleKey != null) {
      map['subtitle_key'] = Variable<String>(subtitleKey);
    }
    map['category'] = Variable<String>(category);
    {
      map['base_difficulty'] = Variable<String>(
        $ActivitiesTable.$converterbaseDifficulty.toSql(baseDifficulty),
      );
    }
    map['duration_sec'] = Variable<int>(durationSec);
    map['content_json'] = Variable<String>(contentJson);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      type: Value(type),
      titleKey: Value(titleKey),
      subtitleKey: subtitleKey == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitleKey),
      category: Value(category),
      baseDifficulty: Value(baseDifficulty),
      durationSec: Value(durationSec),
      contentJson: Value(contentJson),
      isCustom: Value(isCustom),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      enabled: Value(enabled),
    );
  }

  factory Activity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      titleKey: serializer.fromJson<String>(json['titleKey']),
      subtitleKey: serializer.fromJson<String?>(json['subtitleKey']),
      category: serializer.fromJson<String>(json['category']),
      baseDifficulty: $ActivitiesTable.$converterbaseDifficulty.fromJson(
        serializer.fromJson<String>(json['baseDifficulty']),
      ),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      region: serializer.fromJson<String?>(json['region']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'titleKey': serializer.toJson<String>(titleKey),
      'subtitleKey': serializer.toJson<String?>(subtitleKey),
      'category': serializer.toJson<String>(category),
      'baseDifficulty': serializer.toJson<String>(
        $ActivitiesTable.$converterbaseDifficulty.toJson(baseDifficulty),
      ),
      'durationSec': serializer.toJson<int>(durationSec),
      'contentJson': serializer.toJson<String>(contentJson),
      'isCustom': serializer.toJson<bool>(isCustom),
      'region': serializer.toJson<String?>(region),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  Activity copyWith({
    String? id,
    String? type,
    String? titleKey,
    Value<String?> subtitleKey = const Value.absent(),
    String? category,
    Difficulty? baseDifficulty,
    int? durationSec,
    String? contentJson,
    bool? isCustom,
    Value<String?> region = const Value.absent(),
    bool? enabled,
  }) => Activity(
    id: id ?? this.id,
    type: type ?? this.type,
    titleKey: titleKey ?? this.titleKey,
    subtitleKey: subtitleKey.present ? subtitleKey.value : this.subtitleKey,
    category: category ?? this.category,
    baseDifficulty: baseDifficulty ?? this.baseDifficulty,
    durationSec: durationSec ?? this.durationSec,
    contentJson: contentJson ?? this.contentJson,
    isCustom: isCustom ?? this.isCustom,
    region: region.present ? region.value : this.region,
    enabled: enabled ?? this.enabled,
  );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      titleKey: data.titleKey.present ? data.titleKey.value : this.titleKey,
      subtitleKey: data.subtitleKey.present
          ? data.subtitleKey.value
          : this.subtitleKey,
      category: data.category.present ? data.category.value : this.category,
      baseDifficulty: data.baseDifficulty.present
          ? data.baseDifficulty.value
          : this.baseDifficulty,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      contentJson: data.contentJson.present
          ? data.contentJson.value
          : this.contentJson,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      region: data.region.present ? data.region.value : this.region,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('titleKey: $titleKey, ')
          ..write('subtitleKey: $subtitleKey, ')
          ..write('category: $category, ')
          ..write('baseDifficulty: $baseDifficulty, ')
          ..write('durationSec: $durationSec, ')
          ..write('contentJson: $contentJson, ')
          ..write('isCustom: $isCustom, ')
          ..write('region: $region, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    titleKey,
    subtitleKey,
    category,
    baseDifficulty,
    durationSec,
    contentJson,
    isCustom,
    region,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.type == this.type &&
          other.titleKey == this.titleKey &&
          other.subtitleKey == this.subtitleKey &&
          other.category == this.category &&
          other.baseDifficulty == this.baseDifficulty &&
          other.durationSec == this.durationSec &&
          other.contentJson == this.contentJson &&
          other.isCustom == this.isCustom &&
          other.region == this.region &&
          other.enabled == this.enabled);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> titleKey;
  final Value<String?> subtitleKey;
  final Value<String> category;
  final Value<Difficulty> baseDifficulty;
  final Value<int> durationSec;
  final Value<String> contentJson;
  final Value<bool> isCustom;
  final Value<String?> region;
  final Value<bool> enabled;
  final Value<int> rowid;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.titleKey = const Value.absent(),
    this.subtitleKey = const Value.absent(),
    this.category = const Value.absent(),
    this.baseDifficulty = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.region = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    required String id,
    required String type,
    required String titleKey,
    this.subtitleKey = const Value.absent(),
    required String category,
    required Difficulty baseDifficulty,
    this.durationSec = const Value.absent(),
    required String contentJson,
    this.isCustom = const Value.absent(),
    this.region = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       titleKey = Value(titleKey),
       category = Value(category),
       baseDifficulty = Value(baseDifficulty),
       contentJson = Value(contentJson);
  static Insertable<Activity> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? titleKey,
    Expression<String>? subtitleKey,
    Expression<String>? category,
    Expression<String>? baseDifficulty,
    Expression<int>? durationSec,
    Expression<String>? contentJson,
    Expression<bool>? isCustom,
    Expression<String>? region,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (titleKey != null) 'title_key': titleKey,
      if (subtitleKey != null) 'subtitle_key': subtitleKey,
      if (category != null) 'category': category,
      if (baseDifficulty != null) 'base_difficulty': baseDifficulty,
      if (durationSec != null) 'duration_sec': durationSec,
      if (contentJson != null) 'content_json': contentJson,
      if (isCustom != null) 'is_custom': isCustom,
      if (region != null) 'region': region,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? titleKey,
    Value<String?>? subtitleKey,
    Value<String>? category,
    Value<Difficulty>? baseDifficulty,
    Value<int>? durationSec,
    Value<String>? contentJson,
    Value<bool>? isCustom,
    Value<String?>? region,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      titleKey: titleKey ?? this.titleKey,
      subtitleKey: subtitleKey ?? this.subtitleKey,
      category: category ?? this.category,
      baseDifficulty: baseDifficulty ?? this.baseDifficulty,
      durationSec: durationSec ?? this.durationSec,
      contentJson: contentJson ?? this.contentJson,
      isCustom: isCustom ?? this.isCustom,
      region: region ?? this.region,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (titleKey.present) {
      map['title_key'] = Variable<String>(titleKey.value);
    }
    if (subtitleKey.present) {
      map['subtitle_key'] = Variable<String>(subtitleKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (baseDifficulty.present) {
      map['base_difficulty'] = Variable<String>(
        $ActivitiesTable.$converterbaseDifficulty.toSql(baseDifficulty.value),
      );
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('titleKey: $titleKey, ')
          ..write('subtitleKey: $subtitleKey, ')
          ..write('category: $category, ')
          ..write('baseDifficulty: $baseDifficulty, ')
          ..write('durationSec: $durationSec, ')
          ..write('contentJson: $contentJson, ')
          ..write('isCustom: $isCustom, ')
          ..write('region: $region, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyActivitiesTable extends DailyActivities
    with TableInfo<$DailyActivitiesTable, DailyActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _forDateMeta = const VerificationMeta(
    'forDate',
  );
  @override
  late final GeneratedColumn<String> forDate = GeneratedColumn<String>(
    'for_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DailyStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DailyStatus>($DailyActivitiesTable.$converterstatus);
  static const VerificationMeta _assignedAtMeta = const VerificationMeta(
    'assignedAt',
  );
  @override
  late final GeneratedColumn<DateTime> assignedAt = GeneratedColumn<DateTime>(
    'assigned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    activityId,
    forDate,
    status,
    assignedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('for_date')) {
      context.handle(
        _forDateMeta,
        forDate.isAcceptableOrUnknown(data['for_date']!, _forDateMeta),
      );
    } else if (isInserting) {
      context.missing(_forDateMeta);
    }
    if (data.containsKey('assigned_at')) {
      context.handle(
        _assignedAtMeta,
        assignedAt.isAcceptableOrUnknown(data['assigned_at']!, _assignedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_assignedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyActivity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      forDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}for_date'],
      )!,
      status: $DailyActivitiesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      assignedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assigned_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $DailyActivitiesTable createAlias(String alias) {
    return $DailyActivitiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DailyStatus, String, String> $converterstatus =
      const EnumNameConverter<DailyStatus>(DailyStatus.values);
}

class DailyActivity extends DataClass implements Insertable<DailyActivity> {
  final String id;
  final String patientId;
  final String activityId;
  final String forDate;
  final DailyStatus status;
  final DateTime assignedAt;
  final DateTime? completedAt;
  const DailyActivity({
    required this.id,
    required this.patientId,
    required this.activityId,
    required this.forDate,
    required this.status,
    required this.assignedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['activity_id'] = Variable<String>(activityId);
    map['for_date'] = Variable<String>(forDate);
    {
      map['status'] = Variable<String>(
        $DailyActivitiesTable.$converterstatus.toSql(status),
      );
    }
    map['assigned_at'] = Variable<DateTime>(assignedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DailyActivitiesCompanion toCompanion(bool nullToAbsent) {
    return DailyActivitiesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      activityId: Value(activityId),
      forDate: Value(forDate),
      status: Value(status),
      assignedAt: Value(assignedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DailyActivity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyActivity(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      activityId: serializer.fromJson<String>(json['activityId']),
      forDate: serializer.fromJson<String>(json['forDate']),
      status: $DailyActivitiesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      assignedAt: serializer.fromJson<DateTime>(json['assignedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'activityId': serializer.toJson<String>(activityId),
      'forDate': serializer.toJson<String>(forDate),
      'status': serializer.toJson<String>(
        $DailyActivitiesTable.$converterstatus.toJson(status),
      ),
      'assignedAt': serializer.toJson<DateTime>(assignedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DailyActivity copyWith({
    String? id,
    String? patientId,
    String? activityId,
    String? forDate,
    DailyStatus? status,
    DateTime? assignedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => DailyActivity(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    activityId: activityId ?? this.activityId,
    forDate: forDate ?? this.forDate,
    status: status ?? this.status,
    assignedAt: assignedAt ?? this.assignedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DailyActivity copyWithCompanion(DailyActivitiesCompanion data) {
    return DailyActivity(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      forDate: data.forDate.present ? data.forDate.value : this.forDate,
      status: data.status.present ? data.status.value : this.status,
      assignedAt: data.assignedAt.present
          ? data.assignedAt.value
          : this.assignedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivity(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('activityId: $activityId, ')
          ..write('forDate: $forDate, ')
          ..write('status: $status, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    activityId,
    forDate,
    status,
    assignedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyActivity &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.activityId == this.activityId &&
          other.forDate == this.forDate &&
          other.status == this.status &&
          other.assignedAt == this.assignedAt &&
          other.completedAt == this.completedAt);
}

class DailyActivitiesCompanion extends UpdateCompanion<DailyActivity> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> activityId;
  final Value<String> forDate;
  final Value<DailyStatus> status;
  final Value<DateTime> assignedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const DailyActivitiesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.forDate = const Value.absent(),
    this.status = const Value.absent(),
    this.assignedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyActivitiesCompanion.insert({
    required String id,
    required String patientId,
    required String activityId,
    required String forDate,
    required DailyStatus status,
    required DateTime assignedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       activityId = Value(activityId),
       forDate = Value(forDate),
       status = Value(status),
       assignedAt = Value(assignedAt);
  static Insertable<DailyActivity> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? activityId,
    Expression<String>? forDate,
    Expression<String>? status,
    Expression<DateTime>? assignedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (activityId != null) 'activity_id': activityId,
      if (forDate != null) 'for_date': forDate,
      if (status != null) 'status': status,
      if (assignedAt != null) 'assigned_at': assignedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? activityId,
    Value<String>? forDate,
    Value<DailyStatus>? status,
    Value<DateTime>? assignedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return DailyActivitiesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      activityId: activityId ?? this.activityId,
      forDate: forDate ?? this.forDate,
      status: status ?? this.status,
      assignedAt: assignedAt ?? this.assignedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (forDate.present) {
      map['for_date'] = Variable<String>(forDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $DailyActivitiesTable.$converterstatus.toSql(status.value),
      );
    }
    if (assignedAt.present) {
      map['assigned_at'] = Variable<DateTime>(assignedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('activityId: $activityId, ')
          ..write('forDate: $forDate, ')
          ..write('status: $status, ')
          ..write('assignedAt: $assignedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityAttemptsTable extends ActivityAttempts
    with TableInfo<$ActivityAttemptsTable, ActivityAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dailyActivityIdMeta = const VerificationMeta(
    'dailyActivityId',
  );
  @override
  late final GeneratedColumn<String> dailyActivityId = GeneratedColumn<String>(
    'daily_activity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hintCountMeta = const VerificationMeta(
    'hintCount',
  );
  @override
  late final GeneratedColumn<int> hintCount = GeneratedColumn<int>(
    'hint_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, String> difficulty =
      GeneratedColumn<String>(
        'difficulty',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Difficulty>($ActivityAttemptsTable.$converterdifficulty);
  static const VerificationMeta _resultJsonMeta = const VerificationMeta(
    'resultJson',
  );
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
    'result_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    activityId,
    dailyActivityId,
    startedAt,
    finishedAt,
    completed,
    correctCount,
    totalCount,
    hintCount,
    difficulty,
    resultJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('daily_activity_id')) {
      context.handle(
        _dailyActivityIdMeta,
        dailyActivityId.isAcceptableOrUnknown(
          data['daily_activity_id']!,
          _dailyActivityIdMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    }
    if (data.containsKey('hint_count')) {
      context.handle(
        _hintCountMeta,
        hintCount.isAcceptableOrUnknown(data['hint_count']!, _hintCountMeta),
      );
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      dailyActivityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_activity_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      )!,
      hintCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hint_count'],
      )!,
      difficulty: $ActivityAttemptsTable.$converterdifficulty.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}difficulty'],
        )!,
      ),
      resultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ActivityAttemptsTable createAlias(String alias) {
    return $ActivityAttemptsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, String, String> $converterdifficulty =
      const EnumNameConverter<Difficulty>(Difficulty.values);
}

class ActivityAttempt extends DataClass implements Insertable<ActivityAttempt> {
  final String id;
  final String patientId;
  final String activityId;
  final String? dailyActivityId;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final bool completed;
  final int correctCount;
  final int totalCount;
  final int hintCount;
  final Difficulty difficulty;
  final String? resultJson;
  final DateTime createdAt;
  const ActivityAttempt({
    required this.id,
    required this.patientId,
    required this.activityId,
    this.dailyActivityId,
    required this.startedAt,
    this.finishedAt,
    required this.completed,
    required this.correctCount,
    required this.totalCount,
    required this.hintCount,
    required this.difficulty,
    this.resultJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['activity_id'] = Variable<String>(activityId);
    if (!nullToAbsent || dailyActivityId != null) {
      map['daily_activity_id'] = Variable<String>(dailyActivityId);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['completed'] = Variable<bool>(completed);
    map['correct_count'] = Variable<int>(correctCount);
    map['total_count'] = Variable<int>(totalCount);
    map['hint_count'] = Variable<int>(hintCount);
    {
      map['difficulty'] = Variable<String>(
        $ActivityAttemptsTable.$converterdifficulty.toSql(difficulty),
      );
    }
    if (!nullToAbsent || resultJson != null) {
      map['result_json'] = Variable<String>(resultJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ActivityAttemptsCompanion toCompanion(bool nullToAbsent) {
    return ActivityAttemptsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      activityId: Value(activityId),
      dailyActivityId: dailyActivityId == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyActivityId),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      completed: Value(completed),
      correctCount: Value(correctCount),
      totalCount: Value(totalCount),
      hintCount: Value(hintCount),
      difficulty: Value(difficulty),
      resultJson: resultJson == null && nullToAbsent
          ? const Value.absent()
          : Value(resultJson),
      createdAt: Value(createdAt),
    );
  }

  factory ActivityAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityAttempt(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      activityId: serializer.fromJson<String>(json['activityId']),
      dailyActivityId: serializer.fromJson<String?>(json['dailyActivityId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      completed: serializer.fromJson<bool>(json['completed']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      hintCount: serializer.fromJson<int>(json['hintCount']),
      difficulty: $ActivityAttemptsTable.$converterdifficulty.fromJson(
        serializer.fromJson<String>(json['difficulty']),
      ),
      resultJson: serializer.fromJson<String?>(json['resultJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'activityId': serializer.toJson<String>(activityId),
      'dailyActivityId': serializer.toJson<String?>(dailyActivityId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'completed': serializer.toJson<bool>(completed),
      'correctCount': serializer.toJson<int>(correctCount),
      'totalCount': serializer.toJson<int>(totalCount),
      'hintCount': serializer.toJson<int>(hintCount),
      'difficulty': serializer.toJson<String>(
        $ActivityAttemptsTable.$converterdifficulty.toJson(difficulty),
      ),
      'resultJson': serializer.toJson<String?>(resultJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ActivityAttempt copyWith({
    String? id,
    String? patientId,
    String? activityId,
    Value<String?> dailyActivityId = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
    bool? completed,
    int? correctCount,
    int? totalCount,
    int? hintCount,
    Difficulty? difficulty,
    Value<String?> resultJson = const Value.absent(),
    DateTime? createdAt,
  }) => ActivityAttempt(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    activityId: activityId ?? this.activityId,
    dailyActivityId: dailyActivityId.present
        ? dailyActivityId.value
        : this.dailyActivityId,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    completed: completed ?? this.completed,
    correctCount: correctCount ?? this.correctCount,
    totalCount: totalCount ?? this.totalCount,
    hintCount: hintCount ?? this.hintCount,
    difficulty: difficulty ?? this.difficulty,
    resultJson: resultJson.present ? resultJson.value : this.resultJson,
    createdAt: createdAt ?? this.createdAt,
  );
  ActivityAttempt copyWithCompanion(ActivityAttemptsCompanion data) {
    return ActivityAttempt(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      dailyActivityId: data.dailyActivityId.present
          ? data.dailyActivityId.value
          : this.dailyActivityId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      completed: data.completed.present ? data.completed.value : this.completed,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
      hintCount: data.hintCount.present ? data.hintCount.value : this.hintCount,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityAttempt(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('activityId: $activityId, ')
          ..write('dailyActivityId: $dailyActivityId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('completed: $completed, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('hintCount: $hintCount, ')
          ..write('difficulty: $difficulty, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    activityId,
    dailyActivityId,
    startedAt,
    finishedAt,
    completed,
    correctCount,
    totalCount,
    hintCount,
    difficulty,
    resultJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityAttempt &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.activityId == this.activityId &&
          other.dailyActivityId == this.dailyActivityId &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.completed == this.completed &&
          other.correctCount == this.correctCount &&
          other.totalCount == this.totalCount &&
          other.hintCount == this.hintCount &&
          other.difficulty == this.difficulty &&
          other.resultJson == this.resultJson &&
          other.createdAt == this.createdAt);
}

class ActivityAttemptsCompanion extends UpdateCompanion<ActivityAttempt> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> activityId;
  final Value<String?> dailyActivityId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<bool> completed;
  final Value<int> correctCount;
  final Value<int> totalCount;
  final Value<int> hintCount;
  final Value<Difficulty> difficulty;
  final Value<String?> resultJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ActivityAttemptsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.activityId = const Value.absent(),
    this.dailyActivityId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.completed = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.hintCount = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityAttemptsCompanion.insert({
    required String id,
    required String patientId,
    required String activityId,
    this.dailyActivityId = const Value.absent(),
    required DateTime startedAt,
    this.finishedAt = const Value.absent(),
    this.completed = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.hintCount = const Value.absent(),
    required Difficulty difficulty,
    this.resultJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       activityId = Value(activityId),
       startedAt = Value(startedAt),
       difficulty = Value(difficulty),
       createdAt = Value(createdAt);
  static Insertable<ActivityAttempt> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? activityId,
    Expression<String>? dailyActivityId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<bool>? completed,
    Expression<int>? correctCount,
    Expression<int>? totalCount,
    Expression<int>? hintCount,
    Expression<String>? difficulty,
    Expression<String>? resultJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (activityId != null) 'activity_id': activityId,
      if (dailyActivityId != null) 'daily_activity_id': dailyActivityId,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (completed != null) 'completed': completed,
      if (correctCount != null) 'correct_count': correctCount,
      if (totalCount != null) 'total_count': totalCount,
      if (hintCount != null) 'hint_count': hintCount,
      if (difficulty != null) 'difficulty': difficulty,
      if (resultJson != null) 'result_json': resultJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? activityId,
    Value<String?>? dailyActivityId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<bool>? completed,
    Value<int>? correctCount,
    Value<int>? totalCount,
    Value<int>? hintCount,
    Value<Difficulty>? difficulty,
    Value<String?>? resultJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ActivityAttemptsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      activityId: activityId ?? this.activityId,
      dailyActivityId: dailyActivityId ?? this.dailyActivityId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      completed: completed ?? this.completed,
      correctCount: correctCount ?? this.correctCount,
      totalCount: totalCount ?? this.totalCount,
      hintCount: hintCount ?? this.hintCount,
      difficulty: difficulty ?? this.difficulty,
      resultJson: resultJson ?? this.resultJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (dailyActivityId.present) {
      map['daily_activity_id'] = Variable<String>(dailyActivityId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (hintCount.present) {
      map['hint_count'] = Variable<int>(hintCount.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(
        $ActivityAttemptsTable.$converterdifficulty.toSql(difficulty.value),
      );
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('activityId: $activityId, ')
          ..write('dailyActivityId: $dailyActivityId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('completed: $completed, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('hintCount: $hintCount, ')
          ..write('difficulty: $difficulty, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MemoriesTable extends Memories with TableInfo<$MemoriesTable, Memory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relationMeta = const VerificationMeta(
    'relation',
  );
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
    'relation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaPathMeta = const VerificationMeta(
    'mediaPath',
  );
  @override
  late final GeneratedColumn<String> mediaPath = GeneratedColumn<String>(
    'media_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaUrlMeta = const VerificationMeta(
    'mediaUrl',
  );
  @override
  late final GeneratedColumn<String> mediaUrl = GeneratedColumn<String>(
    'media_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('family'),
  );
  static const VerificationMeta _placeNameMeta = const VerificationMeta(
    'placeName',
  );
  @override
  late final GeneratedColumn<String> placeName = GeneratedColumn<String>(
    'place_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _placementsJsonMeta = const VerificationMeta(
    'placementsJson',
  );
  @override
  late final GeneratedColumn<String> placementsJson = GeneratedColumn<String>(
    'placements_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    kind,
    title,
    caption,
    relation,
    mediaPath,
    mediaUrl,
    category,
    placeName,
    createdBy,
    placementsJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Memory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    if (data.containsKey('relation')) {
      context.handle(
        _relationMeta,
        relation.isAcceptableOrUnknown(data['relation']!, _relationMeta),
      );
    }
    if (data.containsKey('media_path')) {
      context.handle(
        _mediaPathMeta,
        mediaPath.isAcceptableOrUnknown(data['media_path']!, _mediaPathMeta),
      );
    }
    if (data.containsKey('media_url')) {
      context.handle(
        _mediaUrlMeta,
        mediaUrl.isAcceptableOrUnknown(data['media_url']!, _mediaUrlMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('place_name')) {
      context.handle(
        _placeNameMeta,
        placeName.isAcceptableOrUnknown(data['place_name']!, _placeNameMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('placements_json')) {
      context.handle(
        _placementsJsonMeta,
        placementsJson.isAcceptableOrUnknown(
          data['placements_json']!,
          _placementsJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Memory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Memory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
      relation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relation'],
      ),
      mediaPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_path'],
      ),
      mediaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_url'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      placeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_name'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      placementsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}placements_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MemoriesTable createAlias(String alias) {
    return $MemoriesTable(attachedDatabase, alias);
  }
}

class Memory extends DataClass implements Insertable<Memory> {
  final String id;
  final String patientId;
  final String kind;
  final String title;
  final String? caption;
  final String? relation;
  final String? mediaPath;
  final String? mediaUrl;
  final String category;
  final String? placeName;
  final String? createdBy;
  final String placementsJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Memory({
    required this.id,
    required this.patientId,
    required this.kind,
    required this.title,
    this.caption,
    this.relation,
    this.mediaPath,
    this.mediaUrl,
    required this.category,
    this.placeName,
    this.createdBy,
    required this.placementsJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['kind'] = Variable<String>(kind);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    if (!nullToAbsent || relation != null) {
      map['relation'] = Variable<String>(relation);
    }
    if (!nullToAbsent || mediaPath != null) {
      map['media_path'] = Variable<String>(mediaPath);
    }
    if (!nullToAbsent || mediaUrl != null) {
      map['media_url'] = Variable<String>(mediaUrl);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || placeName != null) {
      map['place_name'] = Variable<String>(placeName);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['placements_json'] = Variable<String>(placementsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoriesCompanion toCompanion(bool nullToAbsent) {
    return MemoriesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      kind: Value(kind),
      title: Value(title),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      relation: relation == null && nullToAbsent
          ? const Value.absent()
          : Value(relation),
      mediaPath: mediaPath == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaPath),
      mediaUrl: mediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaUrl),
      category: Value(category),
      placeName: placeName == null && nullToAbsent
          ? const Value.absent()
          : Value(placeName),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      placementsJson: Value(placementsJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Memory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Memory(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      kind: serializer.fromJson<String>(json['kind']),
      title: serializer.fromJson<String>(json['title']),
      caption: serializer.fromJson<String?>(json['caption']),
      relation: serializer.fromJson<String?>(json['relation']),
      mediaPath: serializer.fromJson<String?>(json['mediaPath']),
      mediaUrl: serializer.fromJson<String?>(json['mediaUrl']),
      category: serializer.fromJson<String>(json['category']),
      placeName: serializer.fromJson<String?>(json['placeName']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      placementsJson: serializer.fromJson<String>(json['placementsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'kind': serializer.toJson<String>(kind),
      'title': serializer.toJson<String>(title),
      'caption': serializer.toJson<String?>(caption),
      'relation': serializer.toJson<String?>(relation),
      'mediaPath': serializer.toJson<String?>(mediaPath),
      'mediaUrl': serializer.toJson<String?>(mediaUrl),
      'category': serializer.toJson<String>(category),
      'placeName': serializer.toJson<String?>(placeName),
      'createdBy': serializer.toJson<String?>(createdBy),
      'placementsJson': serializer.toJson<String>(placementsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Memory copyWith({
    String? id,
    String? patientId,
    String? kind,
    String? title,
    Value<String?> caption = const Value.absent(),
    Value<String?> relation = const Value.absent(),
    Value<String?> mediaPath = const Value.absent(),
    Value<String?> mediaUrl = const Value.absent(),
    String? category,
    Value<String?> placeName = const Value.absent(),
    Value<String?> createdBy = const Value.absent(),
    String? placementsJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Memory(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    caption: caption.present ? caption.value : this.caption,
    relation: relation.present ? relation.value : this.relation,
    mediaPath: mediaPath.present ? mediaPath.value : this.mediaPath,
    mediaUrl: mediaUrl.present ? mediaUrl.value : this.mediaUrl,
    category: category ?? this.category,
    placeName: placeName.present ? placeName.value : this.placeName,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    placementsJson: placementsJson ?? this.placementsJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Memory copyWithCompanion(MemoriesCompanion data) {
    return Memory(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      caption: data.caption.present ? data.caption.value : this.caption,
      relation: data.relation.present ? data.relation.value : this.relation,
      mediaPath: data.mediaPath.present ? data.mediaPath.value : this.mediaPath,
      mediaUrl: data.mediaUrl.present ? data.mediaUrl.value : this.mediaUrl,
      category: data.category.present ? data.category.value : this.category,
      placeName: data.placeName.present ? data.placeName.value : this.placeName,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      placementsJson: data.placementsJson.present
          ? data.placementsJson.value
          : this.placementsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Memory(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('caption: $caption, ')
          ..write('relation: $relation, ')
          ..write('mediaPath: $mediaPath, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('category: $category, ')
          ..write('placeName: $placeName, ')
          ..write('createdBy: $createdBy, ')
          ..write('placementsJson: $placementsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    kind,
    title,
    caption,
    relation,
    mediaPath,
    mediaUrl,
    category,
    placeName,
    createdBy,
    placementsJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Memory &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.caption == this.caption &&
          other.relation == this.relation &&
          other.mediaPath == this.mediaPath &&
          other.mediaUrl == this.mediaUrl &&
          other.category == this.category &&
          other.placeName == this.placeName &&
          other.createdBy == this.createdBy &&
          other.placementsJson == this.placementsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MemoriesCompanion extends UpdateCompanion<Memory> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> kind;
  final Value<String> title;
  final Value<String?> caption;
  final Value<String?> relation;
  final Value<String?> mediaPath;
  final Value<String?> mediaUrl;
  final Value<String> category;
  final Value<String?> placeName;
  final Value<String?> createdBy;
  final Value<String> placementsJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MemoriesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.caption = const Value.absent(),
    this.relation = const Value.absent(),
    this.mediaPath = const Value.absent(),
    this.mediaUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.placeName = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.placementsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MemoriesCompanion.insert({
    required String id,
    required String patientId,
    required String kind,
    required String title,
    this.caption = const Value.absent(),
    this.relation = const Value.absent(),
    this.mediaPath = const Value.absent(),
    this.mediaUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.placeName = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.placementsJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       kind = Value(kind),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Memory> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<String>? caption,
    Expression<String>? relation,
    Expression<String>? mediaPath,
    Expression<String>? mediaUrl,
    Expression<String>? category,
    Expression<String>? placeName,
    Expression<String>? createdBy,
    Expression<String>? placementsJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (caption != null) 'caption': caption,
      if (relation != null) 'relation': relation,
      if (mediaPath != null) 'media_path': mediaPath,
      if (mediaUrl != null) 'media_url': mediaUrl,
      if (category != null) 'category': category,
      if (placeName != null) 'place_name': placeName,
      if (createdBy != null) 'created_by': createdBy,
      if (placementsJson != null) 'placements_json': placementsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MemoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? kind,
    Value<String>? title,
    Value<String?>? caption,
    Value<String?>? relation,
    Value<String?>? mediaPath,
    Value<String?>? mediaUrl,
    Value<String>? category,
    Value<String?>? placeName,
    Value<String?>? createdBy,
    Value<String>? placementsJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MemoriesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      caption: caption ?? this.caption,
      relation: relation ?? this.relation,
      mediaPath: mediaPath ?? this.mediaPath,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      category: category ?? this.category,
      placeName: placeName ?? this.placeName,
      createdBy: createdBy ?? this.createdBy,
      placementsJson: placementsJson ?? this.placementsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (mediaPath.present) {
      map['media_path'] = Variable<String>(mediaPath.value);
    }
    if (mediaUrl.present) {
      map['media_url'] = Variable<String>(mediaUrl.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (placeName.present) {
      map['place_name'] = Variable<String>(placeName.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (placementsJson.present) {
      map['placements_json'] = Variable<String>(placementsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoriesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('caption: $caption, ')
          ..write('relation: $relation, ')
          ..write('mediaPath: $mediaPath, ')
          ..write('mediaUrl: $mediaUrl, ')
          ..write('category: $category, ')
          ..write('placeName: $placeName, ')
          ..write('createdBy: $createdBy, ')
          ..write('placementsJson: $placementsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GardensTable extends Gardens with TableInfo<$GardensTable, Garden> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GardensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Memory Garden'),
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _activitiesCompletedMeta =
      const VerificationMeta('activitiesCompleted');
  @override
  late final GeneratedColumn<int> activitiesCompleted = GeneratedColumn<int>(
    'activities_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastGrownAtMeta = const VerificationMeta(
    'lastGrownAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastGrownAt = GeneratedColumn<DateTime>(
    'last_grown_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    name,
    points,
    level,
    activitiesCompleted,
    lastGrownAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gardens';
  @override
  VerificationContext validateIntegrity(
    Insertable<Garden> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('activities_completed')) {
      context.handle(
        _activitiesCompletedMeta,
        activitiesCompleted.isAcceptableOrUnknown(
          data['activities_completed']!,
          _activitiesCompletedMeta,
        ),
      );
    }
    if (data.containsKey('last_grown_at')) {
      context.handle(
        _lastGrownAtMeta,
        lastGrownAt.isAcceptableOrUnknown(
          data['last_grown_at']!,
          _lastGrownAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Garden map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Garden(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      activitiesCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activities_completed'],
      )!,
      lastGrownAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_grown_at'],
      ),
    );
  }

  @override
  $GardensTable createAlias(String alias) {
    return $GardensTable(attachedDatabase, alias);
  }
}

class Garden extends DataClass implements Insertable<Garden> {
  final String id;
  final String patientId;
  final String name;
  final int points;
  final int level;
  final int activitiesCompleted;
  final DateTime? lastGrownAt;
  const Garden({
    required this.id,
    required this.patientId,
    required this.name,
    required this.points,
    required this.level,
    required this.activitiesCompleted,
    this.lastGrownAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    map['points'] = Variable<int>(points);
    map['level'] = Variable<int>(level);
    map['activities_completed'] = Variable<int>(activitiesCompleted);
    if (!nullToAbsent || lastGrownAt != null) {
      map['last_grown_at'] = Variable<DateTime>(lastGrownAt);
    }
    return map;
  }

  GardensCompanion toCompanion(bool nullToAbsent) {
    return GardensCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      points: Value(points),
      level: Value(level),
      activitiesCompleted: Value(activitiesCompleted),
      lastGrownAt: lastGrownAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastGrownAt),
    );
  }

  factory Garden.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Garden(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      points: serializer.fromJson<int>(json['points']),
      level: serializer.fromJson<int>(json['level']),
      activitiesCompleted: serializer.fromJson<int>(
        json['activitiesCompleted'],
      ),
      lastGrownAt: serializer.fromJson<DateTime?>(json['lastGrownAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'points': serializer.toJson<int>(points),
      'level': serializer.toJson<int>(level),
      'activitiesCompleted': serializer.toJson<int>(activitiesCompleted),
      'lastGrownAt': serializer.toJson<DateTime?>(lastGrownAt),
    };
  }

  Garden copyWith({
    String? id,
    String? patientId,
    String? name,
    int? points,
    int? level,
    int? activitiesCompleted,
    Value<DateTime?> lastGrownAt = const Value.absent(),
  }) => Garden(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    name: name ?? this.name,
    points: points ?? this.points,
    level: level ?? this.level,
    activitiesCompleted: activitiesCompleted ?? this.activitiesCompleted,
    lastGrownAt: lastGrownAt.present ? lastGrownAt.value : this.lastGrownAt,
  );
  Garden copyWithCompanion(GardensCompanion data) {
    return Garden(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      points: data.points.present ? data.points.value : this.points,
      level: data.level.present ? data.level.value : this.level,
      activitiesCompleted: data.activitiesCompleted.present
          ? data.activitiesCompleted.value
          : this.activitiesCompleted,
      lastGrownAt: data.lastGrownAt.present
          ? data.lastGrownAt.value
          : this.lastGrownAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Garden(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('points: $points, ')
          ..write('level: $level, ')
          ..write('activitiesCompleted: $activitiesCompleted, ')
          ..write('lastGrownAt: $lastGrownAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    name,
    points,
    level,
    activitiesCompleted,
    lastGrownAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garden &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.points == this.points &&
          other.level == this.level &&
          other.activitiesCompleted == this.activitiesCompleted &&
          other.lastGrownAt == this.lastGrownAt);
}

class GardensCompanion extends UpdateCompanion<Garden> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<int> points;
  final Value<int> level;
  final Value<int> activitiesCompleted;
  final Value<DateTime?> lastGrownAt;
  final Value<int> rowid;
  const GardensCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.points = const Value.absent(),
    this.level = const Value.absent(),
    this.activitiesCompleted = const Value.absent(),
    this.lastGrownAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GardensCompanion.insert({
    required String id,
    required String patientId,
    this.name = const Value.absent(),
    this.points = const Value.absent(),
    this.level = const Value.absent(),
    this.activitiesCompleted = const Value.absent(),
    this.lastGrownAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId);
  static Insertable<Garden> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<int>? points,
    Expression<int>? level,
    Expression<int>? activitiesCompleted,
    Expression<DateTime>? lastGrownAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (points != null) 'points': points,
      if (level != null) 'level': level,
      if (activitiesCompleted != null)
        'activities_completed': activitiesCompleted,
      if (lastGrownAt != null) 'last_grown_at': lastGrownAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GardensCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? name,
    Value<int>? points,
    Value<int>? level,
    Value<int>? activitiesCompleted,
    Value<DateTime?>? lastGrownAt,
    Value<int>? rowid,
  }) {
    return GardensCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      points: points ?? this.points,
      level: level ?? this.level,
      activitiesCompleted: activitiesCompleted ?? this.activitiesCompleted,
      lastGrownAt: lastGrownAt ?? this.lastGrownAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (activitiesCompleted.present) {
      map['activities_completed'] = Variable<int>(activitiesCompleted.value);
    }
    if (lastGrownAt.present) {
      map['last_grown_at'] = Variable<DateTime>(lastGrownAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GardensCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('points: $points, ')
          ..write('level: $level, ')
          ..write('activitiesCompleted: $activitiesCompleted, ')
          ..write('lastGrownAt: $lastGrownAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GardenElementsTable extends GardenElements
    with TableInfo<$GardenElementsTable, GardenElement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GardenElementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gardenIdMeta = const VerificationMeta(
    'gardenId',
  );
  @override
  late final GeneratedColumn<String> gardenId = GeneratedColumn<String>(
    'garden_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectionMeta = const VerificationMeta(
    'section',
  );
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
    'section',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('garden'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlantStage, String> stage =
      GeneratedColumn<String>(
        'stage',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PlantStage>($GardenElementsTable.$converterstage);
  static const VerificationMeta _memoryIdMeta = const VerificationMeta(
    'memoryId',
  );
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
    'memory_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('🌱'),
  );
  static const VerificationMeta _plantedAtMeta = const VerificationMeta(
    'plantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> plantedAt = GeneratedColumn<DateTime>(
    'planted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastGrowthAtMeta = const VerificationMeta(
    'lastGrowthAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastGrowthAt = GeneratedColumn<DateTime>(
    'last_growth_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gardenId,
    kind,
    section,
    stage,
    memoryId,
    label,
    emoji,
    plantedAt,
    lastGrowthAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garden_elements';
  @override
  VerificationContext validateIntegrity(
    Insertable<GardenElement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('garden_id')) {
      context.handle(
        _gardenIdMeta,
        gardenId.isAcceptableOrUnknown(data['garden_id']!, _gardenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gardenIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('section')) {
      context.handle(
        _sectionMeta,
        section.isAcceptableOrUnknown(data['section']!, _sectionMeta),
      );
    }
    if (data.containsKey('memory_id')) {
      context.handle(
        _memoryIdMeta,
        memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    }
    if (data.containsKey('planted_at')) {
      context.handle(
        _plantedAtMeta,
        plantedAt.isAcceptableOrUnknown(data['planted_at']!, _plantedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_plantedAtMeta);
    }
    if (data.containsKey('last_growth_at')) {
      context.handle(
        _lastGrowthAtMeta,
        lastGrowthAt.isAcceptableOrUnknown(
          data['last_growth_at']!,
          _lastGrowthAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GardenElement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GardenElement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gardenId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garden_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      section: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section'],
      )!,
      stage: $GardenElementsTable.$converterstage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stage'],
        )!,
      ),
      memoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memory_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      plantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planted_at'],
      )!,
      lastGrowthAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_growth_at'],
      ),
    );
  }

  @override
  $GardenElementsTable createAlias(String alias) {
    return $GardenElementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlantStage, String, String> $converterstage =
      const EnumNameConverter<PlantStage>(PlantStage.values);
}

class GardenElement extends DataClass implements Insertable<GardenElement> {
  final String id;
  final String gardenId;
  final String kind;
  final String section;
  final PlantStage stage;
  final String? memoryId;
  final String? label;
  final String emoji;
  final DateTime plantedAt;
  final DateTime? lastGrowthAt;
  const GardenElement({
    required this.id,
    required this.gardenId,
    required this.kind,
    required this.section,
    required this.stage,
    this.memoryId,
    this.label,
    required this.emoji,
    required this.plantedAt,
    this.lastGrowthAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garden_id'] = Variable<String>(gardenId);
    map['kind'] = Variable<String>(kind);
    map['section'] = Variable<String>(section);
    {
      map['stage'] = Variable<String>(
        $GardenElementsTable.$converterstage.toSql(stage),
      );
    }
    if (!nullToAbsent || memoryId != null) {
      map['memory_id'] = Variable<String>(memoryId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['emoji'] = Variable<String>(emoji);
    map['planted_at'] = Variable<DateTime>(plantedAt);
    if (!nullToAbsent || lastGrowthAt != null) {
      map['last_growth_at'] = Variable<DateTime>(lastGrowthAt);
    }
    return map;
  }

  GardenElementsCompanion toCompanion(bool nullToAbsent) {
    return GardenElementsCompanion(
      id: Value(id),
      gardenId: Value(gardenId),
      kind: Value(kind),
      section: Value(section),
      stage: Value(stage),
      memoryId: memoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      emoji: Value(emoji),
      plantedAt: Value(plantedAt),
      lastGrowthAt: lastGrowthAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastGrowthAt),
    );
  }

  factory GardenElement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GardenElement(
      id: serializer.fromJson<String>(json['id']),
      gardenId: serializer.fromJson<String>(json['gardenId']),
      kind: serializer.fromJson<String>(json['kind']),
      section: serializer.fromJson<String>(json['section']),
      stage: $GardenElementsTable.$converterstage.fromJson(
        serializer.fromJson<String>(json['stage']),
      ),
      memoryId: serializer.fromJson<String?>(json['memoryId']),
      label: serializer.fromJson<String?>(json['label']),
      emoji: serializer.fromJson<String>(json['emoji']),
      plantedAt: serializer.fromJson<DateTime>(json['plantedAt']),
      lastGrowthAt: serializer.fromJson<DateTime?>(json['lastGrowthAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gardenId': serializer.toJson<String>(gardenId),
      'kind': serializer.toJson<String>(kind),
      'section': serializer.toJson<String>(section),
      'stage': serializer.toJson<String>(
        $GardenElementsTable.$converterstage.toJson(stage),
      ),
      'memoryId': serializer.toJson<String?>(memoryId),
      'label': serializer.toJson<String?>(label),
      'emoji': serializer.toJson<String>(emoji),
      'plantedAt': serializer.toJson<DateTime>(plantedAt),
      'lastGrowthAt': serializer.toJson<DateTime?>(lastGrowthAt),
    };
  }

  GardenElement copyWith({
    String? id,
    String? gardenId,
    String? kind,
    String? section,
    PlantStage? stage,
    Value<String?> memoryId = const Value.absent(),
    Value<String?> label = const Value.absent(),
    String? emoji,
    DateTime? plantedAt,
    Value<DateTime?> lastGrowthAt = const Value.absent(),
  }) => GardenElement(
    id: id ?? this.id,
    gardenId: gardenId ?? this.gardenId,
    kind: kind ?? this.kind,
    section: section ?? this.section,
    stage: stage ?? this.stage,
    memoryId: memoryId.present ? memoryId.value : this.memoryId,
    label: label.present ? label.value : this.label,
    emoji: emoji ?? this.emoji,
    plantedAt: plantedAt ?? this.plantedAt,
    lastGrowthAt: lastGrowthAt.present ? lastGrowthAt.value : this.lastGrowthAt,
  );
  GardenElement copyWithCompanion(GardenElementsCompanion data) {
    return GardenElement(
      id: data.id.present ? data.id.value : this.id,
      gardenId: data.gardenId.present ? data.gardenId.value : this.gardenId,
      kind: data.kind.present ? data.kind.value : this.kind,
      section: data.section.present ? data.section.value : this.section,
      stage: data.stage.present ? data.stage.value : this.stage,
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      label: data.label.present ? data.label.value : this.label,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      plantedAt: data.plantedAt.present ? data.plantedAt.value : this.plantedAt,
      lastGrowthAt: data.lastGrowthAt.present
          ? data.lastGrowthAt.value
          : this.lastGrowthAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GardenElement(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('kind: $kind, ')
          ..write('section: $section, ')
          ..write('stage: $stage, ')
          ..write('memoryId: $memoryId, ')
          ..write('label: $label, ')
          ..write('emoji: $emoji, ')
          ..write('plantedAt: $plantedAt, ')
          ..write('lastGrowthAt: $lastGrowthAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gardenId,
    kind,
    section,
    stage,
    memoryId,
    label,
    emoji,
    plantedAt,
    lastGrowthAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GardenElement &&
          other.id == this.id &&
          other.gardenId == this.gardenId &&
          other.kind == this.kind &&
          other.section == this.section &&
          other.stage == this.stage &&
          other.memoryId == this.memoryId &&
          other.label == this.label &&
          other.emoji == this.emoji &&
          other.plantedAt == this.plantedAt &&
          other.lastGrowthAt == this.lastGrowthAt);
}

class GardenElementsCompanion extends UpdateCompanion<GardenElement> {
  final Value<String> id;
  final Value<String> gardenId;
  final Value<String> kind;
  final Value<String> section;
  final Value<PlantStage> stage;
  final Value<String?> memoryId;
  final Value<String?> label;
  final Value<String> emoji;
  final Value<DateTime> plantedAt;
  final Value<DateTime?> lastGrowthAt;
  final Value<int> rowid;
  const GardenElementsCompanion({
    this.id = const Value.absent(),
    this.gardenId = const Value.absent(),
    this.kind = const Value.absent(),
    this.section = const Value.absent(),
    this.stage = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.label = const Value.absent(),
    this.emoji = const Value.absent(),
    this.plantedAt = const Value.absent(),
    this.lastGrowthAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GardenElementsCompanion.insert({
    required String id,
    required String gardenId,
    required String kind,
    this.section = const Value.absent(),
    required PlantStage stage,
    this.memoryId = const Value.absent(),
    this.label = const Value.absent(),
    this.emoji = const Value.absent(),
    required DateTime plantedAt,
    this.lastGrowthAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gardenId = Value(gardenId),
       kind = Value(kind),
       stage = Value(stage),
       plantedAt = Value(plantedAt);
  static Insertable<GardenElement> custom({
    Expression<String>? id,
    Expression<String>? gardenId,
    Expression<String>? kind,
    Expression<String>? section,
    Expression<String>? stage,
    Expression<String>? memoryId,
    Expression<String>? label,
    Expression<String>? emoji,
    Expression<DateTime>? plantedAt,
    Expression<DateTime>? lastGrowthAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gardenId != null) 'garden_id': gardenId,
      if (kind != null) 'kind': kind,
      if (section != null) 'section': section,
      if (stage != null) 'stage': stage,
      if (memoryId != null) 'memory_id': memoryId,
      if (label != null) 'label': label,
      if (emoji != null) 'emoji': emoji,
      if (plantedAt != null) 'planted_at': plantedAt,
      if (lastGrowthAt != null) 'last_growth_at': lastGrowthAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GardenElementsCompanion copyWith({
    Value<String>? id,
    Value<String>? gardenId,
    Value<String>? kind,
    Value<String>? section,
    Value<PlantStage>? stage,
    Value<String?>? memoryId,
    Value<String?>? label,
    Value<String>? emoji,
    Value<DateTime>? plantedAt,
    Value<DateTime?>? lastGrowthAt,
    Value<int>? rowid,
  }) {
    return GardenElementsCompanion(
      id: id ?? this.id,
      gardenId: gardenId ?? this.gardenId,
      kind: kind ?? this.kind,
      section: section ?? this.section,
      stage: stage ?? this.stage,
      memoryId: memoryId ?? this.memoryId,
      label: label ?? this.label,
      emoji: emoji ?? this.emoji,
      plantedAt: plantedAt ?? this.plantedAt,
      lastGrowthAt: lastGrowthAt ?? this.lastGrowthAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gardenId.present) {
      map['garden_id'] = Variable<String>(gardenId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(
        $GardenElementsTable.$converterstage.toSql(stage.value),
      );
    }
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (plantedAt.present) {
      map['planted_at'] = Variable<DateTime>(plantedAt.value);
    }
    if (lastGrowthAt.present) {
      map['last_growth_at'] = Variable<DateTime>(lastGrowthAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GardenElementsCompanion(')
          ..write('id: $id, ')
          ..write('gardenId: $gardenId, ')
          ..write('kind: $kind, ')
          ..write('section: $section, ')
          ..write('stage: $stage, ')
          ..write('memoryId: $memoryId, ')
          ..write('label: $label, ')
          ..write('emoji: $emoji, ')
          ..write('plantedAt: $plantedAt, ')
          ..write('lastGrowthAt: $lastGrowthAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('routine'),
  );
  static const VerificationMeta _daysJsonMeta = const VerificationMeta(
    'daysJson',
  );
  @override
  late final GeneratedColumn<String> daysJson = GeneratedColumn<String>(
    'days_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    title,
    detail,
    hour,
    minute,
    kind,
    daysJson,
    enabled,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('days_json')) {
      context.handle(
        _daysJsonMeta,
        daysJson.isAcceptableOrUnknown(data['days_json']!, _daysJsonMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      daysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}days_json'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String patientId;
  final String title;
  final String? detail;
  final int hour;
  final int minute;
  final String kind;
  final String daysJson;
  final bool enabled;
  final DateTime createdAt;
  const Reminder({
    required this.id,
    required this.patientId,
    required this.title,
    this.detail,
    required this.hour,
    required this.minute,
    required this.kind,
    required this.daysJson,
    required this.enabled,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['kind'] = Variable<String>(kind);
    map['days_json'] = Variable<String>(daysJson);
    map['enabled'] = Variable<bool>(enabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      patientId: Value(patientId),
      title: Value(title),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      hour: Value(hour),
      minute: Value(minute),
      kind: Value(kind),
      daysJson: Value(daysJson),
      enabled: Value(enabled),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String?>(json['detail']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      kind: serializer.fromJson<String>(json['kind']),
      daysJson: serializer.fromJson<String>(json['daysJson']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String?>(detail),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'kind': serializer.toJson<String>(kind),
      'daysJson': serializer.toJson<String>(daysJson),
      'enabled': serializer.toJson<bool>(enabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith({
    String? id,
    String? patientId,
    String? title,
    Value<String?> detail = const Value.absent(),
    int? hour,
    int? minute,
    String? kind,
    String? daysJson,
    bool? enabled,
    DateTime? createdAt,
  }) => Reminder(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    title: title ?? this.title,
    detail: detail.present ? detail.value : this.detail,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    kind: kind ?? this.kind,
    daysJson: daysJson ?? this.daysJson,
    enabled: enabled ?? this.enabled,
    createdAt: createdAt ?? this.createdAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      kind: data.kind.present ? data.kind.value : this.kind,
      daysJson: data.daysJson.present ? data.daysJson.value : this.daysJson,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('kind: $kind, ')
          ..write('daysJson: $daysJson, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    title,
    detail,
    hour,
    minute,
    kind,
    daysJson,
    enabled,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.kind == this.kind &&
          other.daysJson == this.daysJson &&
          other.enabled == this.enabled &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> title;
  final Value<String?> detail;
  final Value<int> hour;
  final Value<int> minute;
  final Value<String> kind;
  final Value<String> daysJson;
  final Value<bool> enabled;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.kind = const Value.absent(),
    this.daysJson = const Value.absent(),
    this.enabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String patientId,
    required String title,
    this.detail = const Value.absent(),
    required int hour,
    required int minute,
    this.kind = const Value.absent(),
    this.daysJson = const Value.absent(),
    this.enabled = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       title = Value(title),
       hour = Value(hour),
       minute = Value(minute),
       createdAt = Value(createdAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<String>? kind,
    Expression<String>? daysJson,
    Expression<bool>? enabled,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (kind != null) 'kind': kind,
      if (daysJson != null) 'days_json': daysJson,
      if (enabled != null) 'enabled': enabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? title,
    Value<String?>? detail,
    Value<int>? hour,
    Value<int>? minute,
    Value<String>? kind,
    Value<String>? daysJson,
    Value<bool>? enabled,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      kind: kind ?? this.kind,
      daysJson: daysJson ?? this.daysJson,
      enabled: enabled ?? this.enabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (daysJson.present) {
      map['days_json'] = Variable<String>(daysJson.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('kind: $kind, ')
          ..write('daysJson: $daysJson, ')
          ..write('enabled: $enabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('info'),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    title,
    body,
    type,
    isRead,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Notification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String? patientId;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  const Notification({
    required this.id,
    this.patientId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || patientId != null) {
      map['patient_id'] = Variable<String>(patientId);
    }
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['type'] = Variable<String>(type);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      patientId: patientId == null && nullToAbsent
          ? const Value.absent()
          : Value(patientId),
      title: Value(title),
      body: Value(body),
      type: Value(type),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory Notification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String?>(json['patientId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      type: serializer.fromJson<String>(json['type']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String?>(patientId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'type': serializer.toJson<String>(type),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Notification copyWith({
    String? id,
    Value<String?> patientId = const Value.absent(),
    String? title,
    String? body,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) => Notification(
    id: id ?? this.id,
    patientId: patientId.present ? patientId.value : this.patientId,
    title: title ?? this.title,
    body: body ?? this.body,
    type: type ?? this.type,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      type: data.type.present ? data.type.value : this.type,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, patientId, title, body, type, isRead, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.title == this.title &&
          other.body == this.body &&
          other.type == this.type &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String?> patientId;
  final Value<String> title;
  final Value<String> body;
  final Value<String> type;
  final Value<bool> isRead;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.type = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    this.patientId = const Value.absent(),
    required String title,
    required String body,
    this.type = const Value.absent(),
    this.isRead = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? type,
    Expression<bool>? isRead,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (type != null) 'type': type,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith({
    Value<String>? id,
    Value<String?>? patientId,
    Value<String>? title,
    Value<String>? body,
    Value<String>? type,
    Value<bool>? isRead,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SosIncidentsTable extends SosIncidents
    with TableInfo<$SosIncidentsTable, SosIncident> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SosIncidentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SosStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SosStatus>($SosIncidentsTable.$converterstatus);
  static const VerificationMeta _escalationStepMeta = const VerificationMeta(
    'escalationStep',
  );
  @override
  late final GeneratedColumn<int> escalationStep = GeneratedColumn<int>(
    'escalation_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentContactIdMeta = const VerificationMeta(
    'currentContactId',
  );
  @override
  late final GeneratedColumn<String> currentContactId = GeneratedColumn<String>(
    'current_contact_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentMethodMeta = const VerificationMeta(
    'currentMethod',
  );
  @override
  late final GeneratedColumn<String> currentMethod = GeneratedColumn<String>(
    'current_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('call'),
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _acknowledgedAtMeta = const VerificationMeta(
    'acknowledgedAt',
  );
  @override
  late final GeneratedColumn<DateTime> acknowledgedAt =
      GeneratedColumn<DateTime>(
        'acknowledged_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    startedAt,
    status,
    escalationStep,
    currentContactId,
    currentMethod,
    lastAttemptAt,
    acknowledgedAt,
    resolvedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sos_incidents';
  @override
  VerificationContext validateIntegrity(
    Insertable<SosIncident> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('escalation_step')) {
      context.handle(
        _escalationStepMeta,
        escalationStep.isAcceptableOrUnknown(
          data['escalation_step']!,
          _escalationStepMeta,
        ),
      );
    }
    if (data.containsKey('current_contact_id')) {
      context.handle(
        _currentContactIdMeta,
        currentContactId.isAcceptableOrUnknown(
          data['current_contact_id']!,
          _currentContactIdMeta,
        ),
      );
    }
    if (data.containsKey('current_method')) {
      context.handle(
        _currentMethodMeta,
        currentMethod.isAcceptableOrUnknown(
          data['current_method']!,
          _currentMethodMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('acknowledged_at')) {
      context.handle(
        _acknowledgedAtMeta,
        acknowledgedAt.isAcceptableOrUnknown(
          data['acknowledged_at']!,
          _acknowledgedAtMeta,
        ),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SosIncident map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SosIncident(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      status: $SosIncidentsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      escalationStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}escalation_step'],
      )!,
      currentContactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_contact_id'],
      ),
      currentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_method'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      acknowledgedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acknowledged_at'],
      ),
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}resolved_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $SosIncidentsTable createAlias(String alias) {
    return $SosIncidentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SosStatus, String, String> $converterstatus =
      const EnumNameConverter<SosStatus>(SosStatus.values);
}

class SosIncident extends DataClass implements Insertable<SosIncident> {
  final String id;
  final String patientId;
  final DateTime startedAt;
  final SosStatus status;
  final int escalationStep;
  final String? currentContactId;
  final String currentMethod;
  final DateTime? lastAttemptAt;
  final DateTime? acknowledgedAt;
  final DateTime? resolvedAt;
  final String? notes;
  const SosIncident({
    required this.id,
    required this.patientId,
    required this.startedAt,
    required this.status,
    required this.escalationStep,
    this.currentContactId,
    required this.currentMethod,
    this.lastAttemptAt,
    this.acknowledgedAt,
    this.resolvedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['started_at'] = Variable<DateTime>(startedAt);
    {
      map['status'] = Variable<String>(
        $SosIncidentsTable.$converterstatus.toSql(status),
      );
    }
    map['escalation_step'] = Variable<int>(escalationStep);
    if (!nullToAbsent || currentContactId != null) {
      map['current_contact_id'] = Variable<String>(currentContactId);
    }
    map['current_method'] = Variable<String>(currentMethod);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || acknowledgedAt != null) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt);
    }
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SosIncidentsCompanion toCompanion(bool nullToAbsent) {
    return SosIncidentsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      startedAt: Value(startedAt),
      status: Value(status),
      escalationStep: Value(escalationStep),
      currentContactId: currentContactId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentContactId),
      currentMethod: Value(currentMethod),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      acknowledgedAt: acknowledgedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory SosIncident.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SosIncident(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      status: $SosIncidentsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      escalationStep: serializer.fromJson<int>(json['escalationStep']),
      currentContactId: serializer.fromJson<String?>(json['currentContactId']),
      currentMethod: serializer.fromJson<String>(json['currentMethod']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      acknowledgedAt: serializer.fromJson<DateTime?>(json['acknowledgedAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'status': serializer.toJson<String>(
        $SosIncidentsTable.$converterstatus.toJson(status),
      ),
      'escalationStep': serializer.toJson<int>(escalationStep),
      'currentContactId': serializer.toJson<String?>(currentContactId),
      'currentMethod': serializer.toJson<String>(currentMethod),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'acknowledgedAt': serializer.toJson<DateTime?>(acknowledgedAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SosIncident copyWith({
    String? id,
    String? patientId,
    DateTime? startedAt,
    SosStatus? status,
    int? escalationStep,
    Value<String?> currentContactId = const Value.absent(),
    String? currentMethod,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> acknowledgedAt = const Value.absent(),
    Value<DateTime?> resolvedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => SosIncident(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    startedAt: startedAt ?? this.startedAt,
    status: status ?? this.status,
    escalationStep: escalationStep ?? this.escalationStep,
    currentContactId: currentContactId.present
        ? currentContactId.value
        : this.currentContactId,
    currentMethod: currentMethod ?? this.currentMethod,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    acknowledgedAt: acknowledgedAt.present
        ? acknowledgedAt.value
        : this.acknowledgedAt,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  SosIncident copyWithCompanion(SosIncidentsCompanion data) {
    return SosIncident(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      status: data.status.present ? data.status.value : this.status,
      escalationStep: data.escalationStep.present
          ? data.escalationStep.value
          : this.escalationStep,
      currentContactId: data.currentContactId.present
          ? data.currentContactId.value
          : this.currentContactId,
      currentMethod: data.currentMethod.present
          ? data.currentMethod.value
          : this.currentMethod,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      acknowledgedAt: data.acknowledgedAt.present
          ? data.acknowledgedAt.value
          : this.acknowledgedAt,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SosIncident(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('startedAt: $startedAt, ')
          ..write('status: $status, ')
          ..write('escalationStep: $escalationStep, ')
          ..write('currentContactId: $currentContactId, ')
          ..write('currentMethod: $currentMethod, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    startedAt,
    status,
    escalationStep,
    currentContactId,
    currentMethod,
    lastAttemptAt,
    acknowledgedAt,
    resolvedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SosIncident &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.startedAt == this.startedAt &&
          other.status == this.status &&
          other.escalationStep == this.escalationStep &&
          other.currentContactId == this.currentContactId &&
          other.currentMethod == this.currentMethod &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.acknowledgedAt == this.acknowledgedAt &&
          other.resolvedAt == this.resolvedAt &&
          other.notes == this.notes);
}

class SosIncidentsCompanion extends UpdateCompanion<SosIncident> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<DateTime> startedAt;
  final Value<SosStatus> status;
  final Value<int> escalationStep;
  final Value<String?> currentContactId;
  final Value<String> currentMethod;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> acknowledgedAt;
  final Value<DateTime?> resolvedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const SosIncidentsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.escalationStep = const Value.absent(),
    this.currentContactId = const Value.absent(),
    this.currentMethod = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SosIncidentsCompanion.insert({
    required String id,
    required String patientId,
    required DateTime startedAt,
    required SosStatus status,
    this.escalationStep = const Value.absent(),
    this.currentContactId = const Value.absent(),
    this.currentMethod = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<SosIncident> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<DateTime>? startedAt,
    Expression<String>? status,
    Expression<int>? escalationStep,
    Expression<String>? currentContactId,
    Expression<String>? currentMethod,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? acknowledgedAt,
    Expression<DateTime>? resolvedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (startedAt != null) 'started_at': startedAt,
      if (status != null) 'status': status,
      if (escalationStep != null) 'escalation_step': escalationStep,
      if (currentContactId != null) 'current_contact_id': currentContactId,
      if (currentMethod != null) 'current_method': currentMethod,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (acknowledgedAt != null) 'acknowledged_at': acknowledgedAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SosIncidentsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<DateTime>? startedAt,
    Value<SosStatus>? status,
    Value<int>? escalationStep,
    Value<String?>? currentContactId,
    Value<String>? currentMethod,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? acknowledgedAt,
    Value<DateTime?>? resolvedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return SosIncidentsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      startedAt: startedAt ?? this.startedAt,
      status: status ?? this.status,
      escalationStep: escalationStep ?? this.escalationStep,
      currentContactId: currentContactId ?? this.currentContactId,
      currentMethod: currentMethod ?? this.currentMethod,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SosIncidentsTable.$converterstatus.toSql(status.value),
      );
    }
    if (escalationStep.present) {
      map['escalation_step'] = Variable<int>(escalationStep.value);
    }
    if (currentContactId.present) {
      map['current_contact_id'] = Variable<String>(currentContactId.value);
    }
    if (currentMethod.present) {
      map['current_method'] = Variable<String>(currentMethod.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (acknowledgedAt.present) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SosIncidentsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('startedAt: $startedAt, ')
          ..write('status: $status, ')
          ..write('escalationStep: $escalationStep, ')
          ..write('currentContactId: $currentContactId, ')
          ..write('currentMethod: $currentMethod, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('acknowledgedAt: $acknowledgedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SosContactAttemptsTable extends SosContactAttempts
    with TableInfo<$SosContactAttemptsTable, SosContactAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SosContactAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incidentIdMeta = const VerificationMeta(
    'incidentId',
  );
  @override
  late final GeneratedColumn<String> incidentId = GeneratedColumn<String>(
    'incident_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactIdMeta = const VerificationMeta(
    'contactId',
  );
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
    'contact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptOrderMeta = const VerificationMeta(
    'attemptOrder',
  );
  @override
  late final GeneratedColumn<int> attemptOrder = GeneratedColumn<int>(
    'attempt_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContactAttemptStatus, String>
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ContactAttemptStatus>(
        $SosContactAttemptsTable.$converterstatus,
      );
  static const VerificationMeta _attemptedAtMeta = const VerificationMeta(
    'attemptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> attemptedAt = GeneratedColumn<DateTime>(
    'attempted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respondedAtMeta = const VerificationMeta(
    'respondedAt',
  );
  @override
  late final GeneratedColumn<DateTime> respondedAt = GeneratedColumn<DateTime>(
    'responded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    incidentId,
    contactId,
    attemptOrder,
    method,
    status,
    attemptedAt,
    respondedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sos_contact_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<SosContactAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('incident_id')) {
      context.handle(
        _incidentIdMeta,
        incidentId.isAcceptableOrUnknown(data['incident_id']!, _incidentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_incidentIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(
        _contactIdMeta,
        contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('attempt_order')) {
      context.handle(
        _attemptOrderMeta,
        attemptOrder.isAcceptableOrUnknown(
          data['attempt_order']!,
          _attemptOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptOrderMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('attempted_at')) {
      context.handle(
        _attemptedAtMeta,
        attemptedAt.isAcceptableOrUnknown(
          data['attempted_at']!,
          _attemptedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedAtMeta);
    }
    if (data.containsKey('responded_at')) {
      context.handle(
        _respondedAtMeta,
        respondedAt.isAcceptableOrUnknown(
          data['responded_at']!,
          _respondedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SosContactAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SosContactAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      incidentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}incident_id'],
      )!,
      contactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_id'],
      )!,
      attemptOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_order'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      status: $SosContactAttemptsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      attemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attempted_at'],
      )!,
      respondedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}responded_at'],
      ),
    );
  }

  @override
  $SosContactAttemptsTable createAlias(String alias) {
    return $SosContactAttemptsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContactAttemptStatus, String, String>
  $converterstatus = const EnumNameConverter<ContactAttemptStatus>(
    ContactAttemptStatus.values,
  );
}

class SosContactAttempt extends DataClass
    implements Insertable<SosContactAttempt> {
  final String id;
  final String incidentId;
  final String contactId;
  final int attemptOrder;
  final String method;
  final ContactAttemptStatus status;
  final DateTime attemptedAt;
  final DateTime? respondedAt;
  const SosContactAttempt({
    required this.id,
    required this.incidentId,
    required this.contactId,
    required this.attemptOrder,
    required this.method,
    required this.status,
    required this.attemptedAt,
    this.respondedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['incident_id'] = Variable<String>(incidentId);
    map['contact_id'] = Variable<String>(contactId);
    map['attempt_order'] = Variable<int>(attemptOrder);
    map['method'] = Variable<String>(method);
    {
      map['status'] = Variable<String>(
        $SosContactAttemptsTable.$converterstatus.toSql(status),
      );
    }
    map['attempted_at'] = Variable<DateTime>(attemptedAt);
    if (!nullToAbsent || respondedAt != null) {
      map['responded_at'] = Variable<DateTime>(respondedAt);
    }
    return map;
  }

  SosContactAttemptsCompanion toCompanion(bool nullToAbsent) {
    return SosContactAttemptsCompanion(
      id: Value(id),
      incidentId: Value(incidentId),
      contactId: Value(contactId),
      attemptOrder: Value(attemptOrder),
      method: Value(method),
      status: Value(status),
      attemptedAt: Value(attemptedAt),
      respondedAt: respondedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(respondedAt),
    );
  }

  factory SosContactAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SosContactAttempt(
      id: serializer.fromJson<String>(json['id']),
      incidentId: serializer.fromJson<String>(json['incidentId']),
      contactId: serializer.fromJson<String>(json['contactId']),
      attemptOrder: serializer.fromJson<int>(json['attemptOrder']),
      method: serializer.fromJson<String>(json['method']),
      status: $SosContactAttemptsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      attemptedAt: serializer.fromJson<DateTime>(json['attemptedAt']),
      respondedAt: serializer.fromJson<DateTime?>(json['respondedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'incidentId': serializer.toJson<String>(incidentId),
      'contactId': serializer.toJson<String>(contactId),
      'attemptOrder': serializer.toJson<int>(attemptOrder),
      'method': serializer.toJson<String>(method),
      'status': serializer.toJson<String>(
        $SosContactAttemptsTable.$converterstatus.toJson(status),
      ),
      'attemptedAt': serializer.toJson<DateTime>(attemptedAt),
      'respondedAt': serializer.toJson<DateTime?>(respondedAt),
    };
  }

  SosContactAttempt copyWith({
    String? id,
    String? incidentId,
    String? contactId,
    int? attemptOrder,
    String? method,
    ContactAttemptStatus? status,
    DateTime? attemptedAt,
    Value<DateTime?> respondedAt = const Value.absent(),
  }) => SosContactAttempt(
    id: id ?? this.id,
    incidentId: incidentId ?? this.incidentId,
    contactId: contactId ?? this.contactId,
    attemptOrder: attemptOrder ?? this.attemptOrder,
    method: method ?? this.method,
    status: status ?? this.status,
    attemptedAt: attemptedAt ?? this.attemptedAt,
    respondedAt: respondedAt.present ? respondedAt.value : this.respondedAt,
  );
  SosContactAttempt copyWithCompanion(SosContactAttemptsCompanion data) {
    return SosContactAttempt(
      id: data.id.present ? data.id.value : this.id,
      incidentId: data.incidentId.present
          ? data.incidentId.value
          : this.incidentId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      attemptOrder: data.attemptOrder.present
          ? data.attemptOrder.value
          : this.attemptOrder,
      method: data.method.present ? data.method.value : this.method,
      status: data.status.present ? data.status.value : this.status,
      attemptedAt: data.attemptedAt.present
          ? data.attemptedAt.value
          : this.attemptedAt,
      respondedAt: data.respondedAt.present
          ? data.respondedAt.value
          : this.respondedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SosContactAttempt(')
          ..write('id: $id, ')
          ..write('incidentId: $incidentId, ')
          ..write('contactId: $contactId, ')
          ..write('attemptOrder: $attemptOrder, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('attemptedAt: $attemptedAt, ')
          ..write('respondedAt: $respondedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    incidentId,
    contactId,
    attemptOrder,
    method,
    status,
    attemptedAt,
    respondedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SosContactAttempt &&
          other.id == this.id &&
          other.incidentId == this.incidentId &&
          other.contactId == this.contactId &&
          other.attemptOrder == this.attemptOrder &&
          other.method == this.method &&
          other.status == this.status &&
          other.attemptedAt == this.attemptedAt &&
          other.respondedAt == this.respondedAt);
}

class SosContactAttemptsCompanion extends UpdateCompanion<SosContactAttempt> {
  final Value<String> id;
  final Value<String> incidentId;
  final Value<String> contactId;
  final Value<int> attemptOrder;
  final Value<String> method;
  final Value<ContactAttemptStatus> status;
  final Value<DateTime> attemptedAt;
  final Value<DateTime?> respondedAt;
  final Value<int> rowid;
  const SosContactAttemptsCompanion({
    this.id = const Value.absent(),
    this.incidentId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.attemptOrder = const Value.absent(),
    this.method = const Value.absent(),
    this.status = const Value.absent(),
    this.attemptedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SosContactAttemptsCompanion.insert({
    required String id,
    required String incidentId,
    required String contactId,
    required int attemptOrder,
    required String method,
    required ContactAttemptStatus status,
    required DateTime attemptedAt,
    this.respondedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       incidentId = Value(incidentId),
       contactId = Value(contactId),
       attemptOrder = Value(attemptOrder),
       method = Value(method),
       status = Value(status),
       attemptedAt = Value(attemptedAt);
  static Insertable<SosContactAttempt> custom({
    Expression<String>? id,
    Expression<String>? incidentId,
    Expression<String>? contactId,
    Expression<int>? attemptOrder,
    Expression<String>? method,
    Expression<String>? status,
    Expression<DateTime>? attemptedAt,
    Expression<DateTime>? respondedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (incidentId != null) 'incident_id': incidentId,
      if (contactId != null) 'contact_id': contactId,
      if (attemptOrder != null) 'attempt_order': attemptOrder,
      if (method != null) 'method': method,
      if (status != null) 'status': status,
      if (attemptedAt != null) 'attempted_at': attemptedAt,
      if (respondedAt != null) 'responded_at': respondedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SosContactAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? incidentId,
    Value<String>? contactId,
    Value<int>? attemptOrder,
    Value<String>? method,
    Value<ContactAttemptStatus>? status,
    Value<DateTime>? attemptedAt,
    Value<DateTime?>? respondedAt,
    Value<int>? rowid,
  }) {
    return SosContactAttemptsCompanion(
      id: id ?? this.id,
      incidentId: incidentId ?? this.incidentId,
      contactId: contactId ?? this.contactId,
      attemptOrder: attemptOrder ?? this.attemptOrder,
      method: method ?? this.method,
      status: status ?? this.status,
      attemptedAt: attemptedAt ?? this.attemptedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (incidentId.present) {
      map['incident_id'] = Variable<String>(incidentId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (attemptOrder.present) {
      map['attempt_order'] = Variable<int>(attemptOrder.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SosContactAttemptsTable.$converterstatus.toSql(status.value),
      );
    }
    if (attemptedAt.present) {
      map['attempted_at'] = Variable<DateTime>(attemptedAt.value);
    }
    if (respondedAt.present) {
      map['responded_at'] = Variable<DateTime>(respondedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SosContactAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('incidentId: $incidentId, ')
          ..write('contactId: $contactId, ')
          ..write('attemptOrder: $attemptOrder, ')
          ..write('method: $method, ')
          ..write('status: $status, ')
          ..write('attemptedAt: $attemptedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, SyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncStatus>($SyncQueueItemsTable.$converterstatus);
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    status,
    retryCount,
    idempotencyKey,
    createdAt,
    syncedAt,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      status: $SyncQueueItemsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, String, String> $converterstatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final String id;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final SyncStatus status;
  final int retryCount;
  final String idempotencyKey;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final String? lastError;
  const SyncQueueItem({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.status,
    required this.retryCount,
    required this.idempotencyKey,
    required this.createdAt,
    this.syncedAt,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    {
      map['status'] = Variable<String>(
        $SyncQueueItemsTable.$converterstatus.toSql(status),
      );
    }
    map['retry_count'] = Variable<int>(retryCount);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      status: Value(status),
      retryCount: Value(retryCount),
      idempotencyKey: Value(idempotencyKey),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: $SyncQueueItemsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(
        $SyncQueueItemsTable.$converterstatus.toJson(status),
      ),
      'retryCount': serializer.toJson<int>(retryCount),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueItem copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? operation,
    String? payloadJson,
    SyncStatus? status,
    int? retryCount,
    String? idempotencyKey,
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
  }) => SyncQueueItem(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payloadJson,
    status,
    retryCount,
    idempotencyKey,
    createdAt,
    syncedAt,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.idempotencyKey == this.idempotencyKey &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt &&
          other.lastError == this.lastError);
}

class SyncQueueItemsCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<SyncStatus> status;
  final Value<int> retryCount;
  final Value<String> idempotencyKey;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    required SyncStatus status,
    this.retryCount = const Value.absent(),
    required String idempotencyKey,
    required DateTime createdAt,
    this.syncedAt = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       status = Value(status),
       idempotencyKey = Value(idempotencyKey),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueItem> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? idempotencyKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<SyncStatus>? status,
    Value<int>? retryCount,
    Value<String>? idempotencyKey,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncQueueItemsTable.$converterstatus.toSql(status.value),
      );
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi'),
  );
  static const VerificationMeta _voiceLanguageMeta = const VerificationMeta(
    'voiceLanguage',
  );
  @override
  late final GeneratedColumn<String> voiceLanguage = GeneratedColumn<String>(
    'voice_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hi-IN'),
  );
  static const VerificationMeta _speechPromptsMeta = const VerificationMeta(
    'speechPrompts',
  );
  @override
  late final GeneratedColumn<bool> speechPrompts = GeneratedColumn<bool>(
    'speech_prompts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("speech_prompts" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reducedMotionMeta = const VerificationMeta(
    'reducedMotion',
  );
  @override
  late final GeneratedColumn<bool> reducedMotion = GeneratedColumn<bool>(
    'reduced_motion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reduced_motion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _largeTextMeta = const VerificationMeta(
    'largeText',
  );
  @override
  late final GeneratedColumn<bool> largeText = GeneratedColumn<bool>(
    'large_text',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("large_text" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _soundEffectsMeta = const VerificationMeta(
    'soundEffects',
  );
  @override
  late final GeneratedColumn<bool> soundEffects = GeneratedColumn<bool>(
    'sound_effects',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_effects" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _demoModeMeta = const VerificationMeta(
    'demoMode',
  );
  @override
  late final GeneratedColumn<bool> demoMode = GeneratedColumn<bool>(
    'demo_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("demo_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _escalationMinutesMeta = const VerificationMeta(
    'escalationMinutes',
  );
  @override
  late final GeneratedColumn<int> escalationMinutes = GeneratedColumn<int>(
    'escalation_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _onboardedAtMeta = const VerificationMeta(
    'onboardedAt',
  );
  @override
  late final GeneratedColumn<DateTime> onboardedAt = GeneratedColumn<DateTime>(
    'onboarded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    patientId,
    language,
    voiceLanguage,
    speechPrompts,
    reducedMotion,
    largeText,
    soundEffects,
    demoMode,
    escalationMinutes,
    onboardedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('voice_language')) {
      context.handle(
        _voiceLanguageMeta,
        voiceLanguage.isAcceptableOrUnknown(
          data['voice_language']!,
          _voiceLanguageMeta,
        ),
      );
    }
    if (data.containsKey('speech_prompts')) {
      context.handle(
        _speechPromptsMeta,
        speechPrompts.isAcceptableOrUnknown(
          data['speech_prompts']!,
          _speechPromptsMeta,
        ),
      );
    }
    if (data.containsKey('reduced_motion')) {
      context.handle(
        _reducedMotionMeta,
        reducedMotion.isAcceptableOrUnknown(
          data['reduced_motion']!,
          _reducedMotionMeta,
        ),
      );
    }
    if (data.containsKey('large_text')) {
      context.handle(
        _largeTextMeta,
        largeText.isAcceptableOrUnknown(data['large_text']!, _largeTextMeta),
      );
    }
    if (data.containsKey('sound_effects')) {
      context.handle(
        _soundEffectsMeta,
        soundEffects.isAcceptableOrUnknown(
          data['sound_effects']!,
          _soundEffectsMeta,
        ),
      );
    }
    if (data.containsKey('demo_mode')) {
      context.handle(
        _demoModeMeta,
        demoMode.isAcceptableOrUnknown(data['demo_mode']!, _demoModeMeta),
      );
    }
    if (data.containsKey('escalation_minutes')) {
      context.handle(
        _escalationMinutesMeta,
        escalationMinutes.isAcceptableOrUnknown(
          data['escalation_minutes']!,
          _escalationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('onboarded_at')) {
      context.handle(
        _onboardedAtMeta,
        onboardedAt.isAcceptableOrUnknown(
          data['onboarded_at']!,
          _onboardedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientId};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      voiceLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voice_language'],
      )!,
      speechPrompts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}speech_prompts'],
      )!,
      reducedMotion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reduced_motion'],
      )!,
      largeText: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}large_text'],
      )!,
      soundEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_effects'],
      )!,
      demoMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}demo_mode'],
      )!,
      escalationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}escalation_minutes'],
      )!,
      onboardedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}onboarded_at'],
      ),
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final String patientId;
  final String language;
  final String voiceLanguage;
  final bool speechPrompts;
  final bool reducedMotion;
  final bool largeText;
  final bool soundEffects;
  final bool demoMode;
  final int escalationMinutes;
  final DateTime? onboardedAt;
  const UserPreference({
    required this.patientId,
    required this.language,
    required this.voiceLanguage,
    required this.speechPrompts,
    required this.reducedMotion,
    required this.largeText,
    required this.soundEffects,
    required this.demoMode,
    required this.escalationMinutes,
    this.onboardedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['patient_id'] = Variable<String>(patientId);
    map['language'] = Variable<String>(language);
    map['voice_language'] = Variable<String>(voiceLanguage);
    map['speech_prompts'] = Variable<bool>(speechPrompts);
    map['reduced_motion'] = Variable<bool>(reducedMotion);
    map['large_text'] = Variable<bool>(largeText);
    map['sound_effects'] = Variable<bool>(soundEffects);
    map['demo_mode'] = Variable<bool>(demoMode);
    map['escalation_minutes'] = Variable<int>(escalationMinutes);
    if (!nullToAbsent || onboardedAt != null) {
      map['onboarded_at'] = Variable<DateTime>(onboardedAt);
    }
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      patientId: Value(patientId),
      language: Value(language),
      voiceLanguage: Value(voiceLanguage),
      speechPrompts: Value(speechPrompts),
      reducedMotion: Value(reducedMotion),
      largeText: Value(largeText),
      soundEffects: Value(soundEffects),
      demoMode: Value(demoMode),
      escalationMinutes: Value(escalationMinutes),
      onboardedAt: onboardedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(onboardedAt),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      patientId: serializer.fromJson<String>(json['patientId']),
      language: serializer.fromJson<String>(json['language']),
      voiceLanguage: serializer.fromJson<String>(json['voiceLanguage']),
      speechPrompts: serializer.fromJson<bool>(json['speechPrompts']),
      reducedMotion: serializer.fromJson<bool>(json['reducedMotion']),
      largeText: serializer.fromJson<bool>(json['largeText']),
      soundEffects: serializer.fromJson<bool>(json['soundEffects']),
      demoMode: serializer.fromJson<bool>(json['demoMode']),
      escalationMinutes: serializer.fromJson<int>(json['escalationMinutes']),
      onboardedAt: serializer.fromJson<DateTime?>(json['onboardedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientId': serializer.toJson<String>(patientId),
      'language': serializer.toJson<String>(language),
      'voiceLanguage': serializer.toJson<String>(voiceLanguage),
      'speechPrompts': serializer.toJson<bool>(speechPrompts),
      'reducedMotion': serializer.toJson<bool>(reducedMotion),
      'largeText': serializer.toJson<bool>(largeText),
      'soundEffects': serializer.toJson<bool>(soundEffects),
      'demoMode': serializer.toJson<bool>(demoMode),
      'escalationMinutes': serializer.toJson<int>(escalationMinutes),
      'onboardedAt': serializer.toJson<DateTime?>(onboardedAt),
    };
  }

  UserPreference copyWith({
    String? patientId,
    String? language,
    String? voiceLanguage,
    bool? speechPrompts,
    bool? reducedMotion,
    bool? largeText,
    bool? soundEffects,
    bool? demoMode,
    int? escalationMinutes,
    Value<DateTime?> onboardedAt = const Value.absent(),
  }) => UserPreference(
    patientId: patientId ?? this.patientId,
    language: language ?? this.language,
    voiceLanguage: voiceLanguage ?? this.voiceLanguage,
    speechPrompts: speechPrompts ?? this.speechPrompts,
    reducedMotion: reducedMotion ?? this.reducedMotion,
    largeText: largeText ?? this.largeText,
    soundEffects: soundEffects ?? this.soundEffects,
    demoMode: demoMode ?? this.demoMode,
    escalationMinutes: escalationMinutes ?? this.escalationMinutes,
    onboardedAt: onboardedAt.present ? onboardedAt.value : this.onboardedAt,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      language: data.language.present ? data.language.value : this.language,
      voiceLanguage: data.voiceLanguage.present
          ? data.voiceLanguage.value
          : this.voiceLanguage,
      speechPrompts: data.speechPrompts.present
          ? data.speechPrompts.value
          : this.speechPrompts,
      reducedMotion: data.reducedMotion.present
          ? data.reducedMotion.value
          : this.reducedMotion,
      largeText: data.largeText.present ? data.largeText.value : this.largeText,
      soundEffects: data.soundEffects.present
          ? data.soundEffects.value
          : this.soundEffects,
      demoMode: data.demoMode.present ? data.demoMode.value : this.demoMode,
      escalationMinutes: data.escalationMinutes.present
          ? data.escalationMinutes.value
          : this.escalationMinutes,
      onboardedAt: data.onboardedAt.present
          ? data.onboardedAt.value
          : this.onboardedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('patientId: $patientId, ')
          ..write('language: $language, ')
          ..write('voiceLanguage: $voiceLanguage, ')
          ..write('speechPrompts: $speechPrompts, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('largeText: $largeText, ')
          ..write('soundEffects: $soundEffects, ')
          ..write('demoMode: $demoMode, ')
          ..write('escalationMinutes: $escalationMinutes, ')
          ..write('onboardedAt: $onboardedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    patientId,
    language,
    voiceLanguage,
    speechPrompts,
    reducedMotion,
    largeText,
    soundEffects,
    demoMode,
    escalationMinutes,
    onboardedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.patientId == this.patientId &&
          other.language == this.language &&
          other.voiceLanguage == this.voiceLanguage &&
          other.speechPrompts == this.speechPrompts &&
          other.reducedMotion == this.reducedMotion &&
          other.largeText == this.largeText &&
          other.soundEffects == this.soundEffects &&
          other.demoMode == this.demoMode &&
          other.escalationMinutes == this.escalationMinutes &&
          other.onboardedAt == this.onboardedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<String> patientId;
  final Value<String> language;
  final Value<String> voiceLanguage;
  final Value<bool> speechPrompts;
  final Value<bool> reducedMotion;
  final Value<bool> largeText;
  final Value<bool> soundEffects;
  final Value<bool> demoMode;
  final Value<int> escalationMinutes;
  final Value<DateTime?> onboardedAt;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.patientId = const Value.absent(),
    this.language = const Value.absent(),
    this.voiceLanguage = const Value.absent(),
    this.speechPrompts = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.largeText = const Value.absent(),
    this.soundEffects = const Value.absent(),
    this.demoMode = const Value.absent(),
    this.escalationMinutes = const Value.absent(),
    this.onboardedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String patientId,
    this.language = const Value.absent(),
    this.voiceLanguage = const Value.absent(),
    this.speechPrompts = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.largeText = const Value.absent(),
    this.soundEffects = const Value.absent(),
    this.demoMode = const Value.absent(),
    this.escalationMinutes = const Value.absent(),
    this.onboardedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : patientId = Value(patientId);
  static Insertable<UserPreference> custom({
    Expression<String>? patientId,
    Expression<String>? language,
    Expression<String>? voiceLanguage,
    Expression<bool>? speechPrompts,
    Expression<bool>? reducedMotion,
    Expression<bool>? largeText,
    Expression<bool>? soundEffects,
    Expression<bool>? demoMode,
    Expression<int>? escalationMinutes,
    Expression<DateTime>? onboardedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patientId != null) 'patient_id': patientId,
      if (language != null) 'language': language,
      if (voiceLanguage != null) 'voice_language': voiceLanguage,
      if (speechPrompts != null) 'speech_prompts': speechPrompts,
      if (reducedMotion != null) 'reduced_motion': reducedMotion,
      if (largeText != null) 'large_text': largeText,
      if (soundEffects != null) 'sound_effects': soundEffects,
      if (demoMode != null) 'demo_mode': demoMode,
      if (escalationMinutes != null) 'escalation_minutes': escalationMinutes,
      if (onboardedAt != null) 'onboarded_at': onboardedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? patientId,
    Value<String>? language,
    Value<String>? voiceLanguage,
    Value<bool>? speechPrompts,
    Value<bool>? reducedMotion,
    Value<bool>? largeText,
    Value<bool>? soundEffects,
    Value<bool>? demoMode,
    Value<int>? escalationMinutes,
    Value<DateTime?>? onboardedAt,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      patientId: patientId ?? this.patientId,
      language: language ?? this.language,
      voiceLanguage: voiceLanguage ?? this.voiceLanguage,
      speechPrompts: speechPrompts ?? this.speechPrompts,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      largeText: largeText ?? this.largeText,
      soundEffects: soundEffects ?? this.soundEffects,
      demoMode: demoMode ?? this.demoMode,
      escalationMinutes: escalationMinutes ?? this.escalationMinutes,
      onboardedAt: onboardedAt ?? this.onboardedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (voiceLanguage.present) {
      map['voice_language'] = Variable<String>(voiceLanguage.value);
    }
    if (speechPrompts.present) {
      map['speech_prompts'] = Variable<bool>(speechPrompts.value);
    }
    if (reducedMotion.present) {
      map['reduced_motion'] = Variable<bool>(reducedMotion.value);
    }
    if (largeText.present) {
      map['large_text'] = Variable<bool>(largeText.value);
    }
    if (soundEffects.present) {
      map['sound_effects'] = Variable<bool>(soundEffects.value);
    }
    if (demoMode.present) {
      map['demo_mode'] = Variable<bool>(demoMode.value);
    }
    if (escalationMinutes.present) {
      map['escalation_minutes'] = Variable<int>(escalationMinutes.value);
    }
    if (onboardedAt.present) {
      map['onboarded_at'] = Variable<DateTime>(onboardedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('patientId: $patientId, ')
          ..write('language: $language, ')
          ..write('voiceLanguage: $voiceLanguage, ')
          ..write('speechPrompts: $speechPrompts, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('largeText: $largeText, ')
          ..write('soundEffects: $soundEffects, ')
          ..write('demoMode: $demoMode, ')
          ..write('escalationMinutes: $escalationMinutes, ')
          ..write('onboardedAt: $onboardedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdaptiveProfilesTable extends AdaptiveProfiles
    with TableInfo<$AdaptiveProfilesTable, AdaptiveProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdaptiveProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Difficulty, String>
  overallDifficulty =
      GeneratedColumn<String>(
        'overall_difficulty',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Difficulty>(
        $AdaptiveProfilesTable.$converteroverallDifficulty,
      );
  static const VerificationMeta _categoryStatsJsonMeta = const VerificationMeta(
    'categoryStatsJson',
  );
  @override
  late final GeneratedColumn<String> categoryStatsJson =
      GeneratedColumn<String>(
        'category_stats_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    patientId,
    overallDifficulty,
    categoryStatsJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'adaptive_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdaptiveProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('category_stats_json')) {
      context.handle(
        _categoryStatsJsonMeta,
        categoryStatsJson.isAcceptableOrUnknown(
          data['category_stats_json']!,
          _categoryStatsJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientId};
  @override
  AdaptiveProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdaptiveProfile(
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      overallDifficulty: $AdaptiveProfilesTable.$converteroverallDifficulty
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}overall_difficulty'],
            )!,
          ),
      categoryStatsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_stats_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AdaptiveProfilesTable createAlias(String alias) {
    return $AdaptiveProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Difficulty, String, String>
  $converteroverallDifficulty = const EnumNameConverter<Difficulty>(
    Difficulty.values,
  );
}

class AdaptiveProfile extends DataClass implements Insertable<AdaptiveProfile> {
  final String patientId;
  final Difficulty overallDifficulty;
  final String categoryStatsJson;
  final DateTime updatedAt;
  const AdaptiveProfile({
    required this.patientId,
    required this.overallDifficulty,
    required this.categoryStatsJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['patient_id'] = Variable<String>(patientId);
    {
      map['overall_difficulty'] = Variable<String>(
        $AdaptiveProfilesTable.$converteroverallDifficulty.toSql(
          overallDifficulty,
        ),
      );
    }
    map['category_stats_json'] = Variable<String>(categoryStatsJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AdaptiveProfilesCompanion toCompanion(bool nullToAbsent) {
    return AdaptiveProfilesCompanion(
      patientId: Value(patientId),
      overallDifficulty: Value(overallDifficulty),
      categoryStatsJson: Value(categoryStatsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory AdaptiveProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdaptiveProfile(
      patientId: serializer.fromJson<String>(json['patientId']),
      overallDifficulty: $AdaptiveProfilesTable.$converteroverallDifficulty
          .fromJson(serializer.fromJson<String>(json['overallDifficulty'])),
      categoryStatsJson: serializer.fromJson<String>(json['categoryStatsJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientId': serializer.toJson<String>(patientId),
      'overallDifficulty': serializer.toJson<String>(
        $AdaptiveProfilesTable.$converteroverallDifficulty.toJson(
          overallDifficulty,
        ),
      ),
      'categoryStatsJson': serializer.toJson<String>(categoryStatsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AdaptiveProfile copyWith({
    String? patientId,
    Difficulty? overallDifficulty,
    String? categoryStatsJson,
    DateTime? updatedAt,
  }) => AdaptiveProfile(
    patientId: patientId ?? this.patientId,
    overallDifficulty: overallDifficulty ?? this.overallDifficulty,
    categoryStatsJson: categoryStatsJson ?? this.categoryStatsJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AdaptiveProfile copyWithCompanion(AdaptiveProfilesCompanion data) {
    return AdaptiveProfile(
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      overallDifficulty: data.overallDifficulty.present
          ? data.overallDifficulty.value
          : this.overallDifficulty,
      categoryStatsJson: data.categoryStatsJson.present
          ? data.categoryStatsJson.value
          : this.categoryStatsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdaptiveProfile(')
          ..write('patientId: $patientId, ')
          ..write('overallDifficulty: $overallDifficulty, ')
          ..write('categoryStatsJson: $categoryStatsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(patientId, overallDifficulty, categoryStatsJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdaptiveProfile &&
          other.patientId == this.patientId &&
          other.overallDifficulty == this.overallDifficulty &&
          other.categoryStatsJson == this.categoryStatsJson &&
          other.updatedAt == this.updatedAt);
}

class AdaptiveProfilesCompanion extends UpdateCompanion<AdaptiveProfile> {
  final Value<String> patientId;
  final Value<Difficulty> overallDifficulty;
  final Value<String> categoryStatsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AdaptiveProfilesCompanion({
    this.patientId = const Value.absent(),
    this.overallDifficulty = const Value.absent(),
    this.categoryStatsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdaptiveProfilesCompanion.insert({
    required String patientId,
    required Difficulty overallDifficulty,
    this.categoryStatsJson = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : patientId = Value(patientId),
       overallDifficulty = Value(overallDifficulty),
       updatedAt = Value(updatedAt);
  static Insertable<AdaptiveProfile> custom({
    Expression<String>? patientId,
    Expression<String>? overallDifficulty,
    Expression<String>? categoryStatsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patientId != null) 'patient_id': patientId,
      if (overallDifficulty != null) 'overall_difficulty': overallDifficulty,
      if (categoryStatsJson != null) 'category_stats_json': categoryStatsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdaptiveProfilesCompanion copyWith({
    Value<String>? patientId,
    Value<Difficulty>? overallDifficulty,
    Value<String>? categoryStatsJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AdaptiveProfilesCompanion(
      patientId: patientId ?? this.patientId,
      overallDifficulty: overallDifficulty ?? this.overallDifficulty,
      categoryStatsJson: categoryStatsJson ?? this.categoryStatsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (overallDifficulty.present) {
      map['overall_difficulty'] = Variable<String>(
        $AdaptiveProfilesTable.$converteroverallDifficulty.toSql(
          overallDifficulty.value,
        ),
      );
    }
    if (categoryStatsJson.present) {
      map['category_stats_json'] = Variable<String>(categoryStatsJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdaptiveProfilesCompanion(')
          ..write('patientId: $patientId, ')
          ..write('overallDifficulty: $overallDifficulty, ')
          ..write('categoryStatsJson: $categoryStatsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationMemoriesTable extends LocationMemories
    with TableInfo<$LocationMemoriesTable, LocationMemory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationMemoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memoryIdMeta = const VerificationMeta(
    'memoryId',
  );
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
    'memory_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    name,
    region,
    state,
    notes,
    memoryId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_memories';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationMemory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('memory_id')) {
      context.handle(
        _memoryIdMeta,
        memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationMemory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationMemory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      memoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memory_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocationMemoriesTable createAlias(String alias) {
    return $LocationMemoriesTable(attachedDatabase, alias);
  }
}

class LocationMemory extends DataClass implements Insertable<LocationMemory> {
  final String id;
  final String patientId;
  final String name;
  final String? region;
  final String? state;
  final String? notes;
  final String? memoryId;
  final DateTime createdAt;
  const LocationMemory({
    required this.id,
    required this.patientId,
    required this.name,
    this.region,
    this.state,
    this.notes,
    this.memoryId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || memoryId != null) {
      map['memory_id'] = Variable<String>(memoryId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocationMemoriesCompanion toCompanion(bool nullToAbsent) {
    return LocationMemoriesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      name: Value(name),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      memoryId: memoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryId),
      createdAt: Value(createdAt),
    );
  }

  factory LocationMemory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationMemory(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      name: serializer.fromJson<String>(json['name']),
      region: serializer.fromJson<String?>(json['region']),
      state: serializer.fromJson<String?>(json['state']),
      notes: serializer.fromJson<String?>(json['notes']),
      memoryId: serializer.fromJson<String?>(json['memoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'name': serializer.toJson<String>(name),
      'region': serializer.toJson<String?>(region),
      'state': serializer.toJson<String?>(state),
      'notes': serializer.toJson<String?>(notes),
      'memoryId': serializer.toJson<String?>(memoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocationMemory copyWith({
    String? id,
    String? patientId,
    String? name,
    Value<String?> region = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> memoryId = const Value.absent(),
    DateTime? createdAt,
  }) => LocationMemory(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    name: name ?? this.name,
    region: region.present ? region.value : this.region,
    state: state.present ? state.value : this.state,
    notes: notes.present ? notes.value : this.notes,
    memoryId: memoryId.present ? memoryId.value : this.memoryId,
    createdAt: createdAt ?? this.createdAt,
  );
  LocationMemory copyWithCompanion(LocationMemoriesCompanion data) {
    return LocationMemory(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      name: data.name.present ? data.name.value : this.name,
      region: data.region.present ? data.region.value : this.region,
      state: data.state.present ? data.state.value : this.state,
      notes: data.notes.present ? data.notes.value : this.notes,
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationMemory(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('region: $region, ')
          ..write('state: $state, ')
          ..write('notes: $notes, ')
          ..write('memoryId: $memoryId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    name,
    region,
    state,
    notes,
    memoryId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationMemory &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.name == this.name &&
          other.region == this.region &&
          other.state == this.state &&
          other.notes == this.notes &&
          other.memoryId == this.memoryId &&
          other.createdAt == this.createdAt);
}

class LocationMemoriesCompanion extends UpdateCompanion<LocationMemory> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<String> name;
  final Value<String?> region;
  final Value<String?> state;
  final Value<String?> notes;
  final Value<String?> memoryId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocationMemoriesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.name = const Value.absent(),
    this.region = const Value.absent(),
    this.state = const Value.absent(),
    this.notes = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationMemoriesCompanion.insert({
    required String id,
    required String patientId,
    required String name,
    this.region = const Value.absent(),
    this.state = const Value.absent(),
    this.notes = const Value.absent(),
    this.memoryId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LocationMemory> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? name,
    Expression<String>? region,
    Expression<String>? state,
    Expression<String>? notes,
    Expression<String>? memoryId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (name != null) 'name': name,
      if (region != null) 'region': region,
      if (state != null) 'state': state,
      if (notes != null) 'notes': notes,
      if (memoryId != null) 'memory_id': memoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationMemoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<String>? name,
    Value<String?>? region,
    Value<String?>? state,
    Value<String?>? notes,
    Value<String?>? memoryId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocationMemoriesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      region: region ?? this.region,
      state: state ?? this.state,
      notes: notes ?? this.notes,
      memoryId: memoryId ?? this.memoryId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationMemoriesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('name: $name, ')
          ..write('region: $region, ')
          ..write('state: $state, ')
          ..write('notes: $notes, ')
          ..write('memoryId: $memoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyUnlocksTable extends DailyUnlocks
    with TableInfo<$DailyUnlocksTable, DailyUnlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyUnlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _forDateMeta = const VerificationMeta(
    'forDate',
  );
  @override
  late final GeneratedColumn<String> forDate = GeneratedColumn<String>(
    'for_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completionsMeta = const VerificationMeta(
    'completions',
  );
  @override
  late final GeneratedColumn<int> completions = GeneratedColumn<int>(
    'completions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _memoryIdMeta = const VerificationMeta(
    'memoryId',
  );
  @override
  late final GeneratedColumn<String> memoryId = GeneratedColumn<String>(
    'memory_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unlockedMeta = const VerificationMeta(
    'unlocked',
  );
  @override
  late final GeneratedColumn<bool> unlocked = GeneratedColumn<bool>(
    'unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    patientId,
    forDate,
    completions,
    memoryId,
    unlocked,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_unlocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyUnlock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('for_date')) {
      context.handle(
        _forDateMeta,
        forDate.isAcceptableOrUnknown(data['for_date']!, _forDateMeta),
      );
    } else if (isInserting) {
      context.missing(_forDateMeta);
    }
    if (data.containsKey('completions')) {
      context.handle(
        _completionsMeta,
        completions.isAcceptableOrUnknown(
          data['completions']!,
          _completionsMeta,
        ),
      );
    }
    if (data.containsKey('memory_id')) {
      context.handle(
        _memoryIdMeta,
        memoryId.isAcceptableOrUnknown(data['memory_id']!, _memoryIdMeta),
      );
    }
    if (data.containsKey('unlocked')) {
      context.handle(
        _unlockedMeta,
        unlocked.isAcceptableOrUnknown(data['unlocked']!, _unlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patientId, forDate};
  @override
  DailyUnlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyUnlock(
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      forDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}for_date'],
      )!,
      completions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completions'],
      )!,
      memoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memory_id'],
      ),
      unlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $DailyUnlocksTable createAlias(String alias) {
    return $DailyUnlocksTable(attachedDatabase, alias);
  }
}

class DailyUnlock extends DataClass implements Insertable<DailyUnlock> {
  final String patientId;
  final String forDate;
  final int completions;
  final String? memoryId;
  final bool unlocked;
  final DateTime? unlockedAt;
  const DailyUnlock({
    required this.patientId,
    required this.forDate,
    required this.completions,
    this.memoryId,
    required this.unlocked,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['patient_id'] = Variable<String>(patientId);
    map['for_date'] = Variable<String>(forDate);
    map['completions'] = Variable<int>(completions);
    if (!nullToAbsent || memoryId != null) {
      map['memory_id'] = Variable<String>(memoryId);
    }
    map['unlocked'] = Variable<bool>(unlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  DailyUnlocksCompanion toCompanion(bool nullToAbsent) {
    return DailyUnlocksCompanion(
      patientId: Value(patientId),
      forDate: Value(forDate),
      completions: Value(completions),
      memoryId: memoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryId),
      unlocked: Value(unlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory DailyUnlock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyUnlock(
      patientId: serializer.fromJson<String>(json['patientId']),
      forDate: serializer.fromJson<String>(json['forDate']),
      completions: serializer.fromJson<int>(json['completions']),
      memoryId: serializer.fromJson<String?>(json['memoryId']),
      unlocked: serializer.fromJson<bool>(json['unlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patientId': serializer.toJson<String>(patientId),
      'forDate': serializer.toJson<String>(forDate),
      'completions': serializer.toJson<int>(completions),
      'memoryId': serializer.toJson<String?>(memoryId),
      'unlocked': serializer.toJson<bool>(unlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  DailyUnlock copyWith({
    String? patientId,
    String? forDate,
    int? completions,
    Value<String?> memoryId = const Value.absent(),
    bool? unlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => DailyUnlock(
    patientId: patientId ?? this.patientId,
    forDate: forDate ?? this.forDate,
    completions: completions ?? this.completions,
    memoryId: memoryId.present ? memoryId.value : this.memoryId,
    unlocked: unlocked ?? this.unlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  DailyUnlock copyWithCompanion(DailyUnlocksCompanion data) {
    return DailyUnlock(
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      forDate: data.forDate.present ? data.forDate.value : this.forDate,
      completions: data.completions.present
          ? data.completions.value
          : this.completions,
      memoryId: data.memoryId.present ? data.memoryId.value : this.memoryId,
      unlocked: data.unlocked.present ? data.unlocked.value : this.unlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyUnlock(')
          ..write('patientId: $patientId, ')
          ..write('forDate: $forDate, ')
          ..write('completions: $completions, ')
          ..write('memoryId: $memoryId, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    patientId,
    forDate,
    completions,
    memoryId,
    unlocked,
    unlockedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyUnlock &&
          other.patientId == this.patientId &&
          other.forDate == this.forDate &&
          other.completions == this.completions &&
          other.memoryId == this.memoryId &&
          other.unlocked == this.unlocked &&
          other.unlockedAt == this.unlockedAt);
}

class DailyUnlocksCompanion extends UpdateCompanion<DailyUnlock> {
  final Value<String> patientId;
  final Value<String> forDate;
  final Value<int> completions;
  final Value<String?> memoryId;
  final Value<bool> unlocked;
  final Value<DateTime?> unlockedAt;
  final Value<int> rowid;
  const DailyUnlocksCompanion({
    this.patientId = const Value.absent(),
    this.forDate = const Value.absent(),
    this.completions = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyUnlocksCompanion.insert({
    required String patientId,
    required String forDate,
    this.completions = const Value.absent(),
    this.memoryId = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : patientId = Value(patientId),
       forDate = Value(forDate);
  static Insertable<DailyUnlock> custom({
    Expression<String>? patientId,
    Expression<String>? forDate,
    Expression<int>? completions,
    Expression<String>? memoryId,
    Expression<bool>? unlocked,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patientId != null) 'patient_id': patientId,
      if (forDate != null) 'for_date': forDate,
      if (completions != null) 'completions': completions,
      if (memoryId != null) 'memory_id': memoryId,
      if (unlocked != null) 'unlocked': unlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyUnlocksCompanion copyWith({
    Value<String>? patientId,
    Value<String>? forDate,
    Value<int>? completions,
    Value<String?>? memoryId,
    Value<bool>? unlocked,
    Value<DateTime?>? unlockedAt,
    Value<int>? rowid,
  }) {
    return DailyUnlocksCompanion(
      patientId: patientId ?? this.patientId,
      forDate: forDate ?? this.forDate,
      completions: completions ?? this.completions,
      memoryId: memoryId ?? this.memoryId,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (forDate.present) {
      map['for_date'] = Variable<String>(forDate.value);
    }
    if (completions.present) {
      map['completions'] = Variable<int>(completions.value);
    }
    if (memoryId.present) {
      map['memory_id'] = Variable<String>(memoryId.value);
    }
    if (unlocked.present) {
      map['unlocked'] = Variable<bool>(unlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyUnlocksCompanion(')
          ..write('patientId: $patientId, ')
          ..write('forDate: $forDate, ')
          ..write('completions: $completions, ')
          ..write('memoryId: $memoryId, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CognitiveAssessmentsTable extends CognitiveAssessments
    with TableInfo<$CognitiveAssessmentsTable, CognitiveAssessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CognitiveAssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxScoreMeta = const VerificationMeta(
    'maxScore',
  );
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
    'max_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusKeyMeta = const VerificationMeta(
    'statusKey',
  );
  @override
  late final GeneratedColumn<String> statusKey = GeneratedColumn<String>(
    'status_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    score,
    maxScore,
    answersJson,
    statusKey,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cognitive_assessments';
  @override
  VerificationContext validateIntegrity(
    Insertable<CognitiveAssessment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('max_score')) {
      context.handle(
        _maxScoreMeta,
        maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_maxScoreMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answersJsonMeta);
    }
    if (data.containsKey('status_key')) {
      context.handle(
        _statusKeyMeta,
        statusKey.isAcceptableOrUnknown(data['status_key']!, _statusKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_statusKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CognitiveAssessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CognitiveAssessment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      maxScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_score'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      statusKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CognitiveAssessmentsTable createAlias(String alias) {
    return $CognitiveAssessmentsTable(attachedDatabase, alias);
  }
}

class CognitiveAssessment extends DataClass
    implements Insertable<CognitiveAssessment> {
  final String id;
  final String patientId;
  final int score;
  final int maxScore;
  final String answersJson;
  final String statusKey;
  final DateTime createdAt;
  const CognitiveAssessment({
    required this.id,
    required this.patientId,
    required this.score,
    required this.maxScore,
    required this.answersJson,
    required this.statusKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    map['score'] = Variable<int>(score);
    map['max_score'] = Variable<int>(maxScore);
    map['answers_json'] = Variable<String>(answersJson);
    map['status_key'] = Variable<String>(statusKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CognitiveAssessmentsCompanion toCompanion(bool nullToAbsent) {
    return CognitiveAssessmentsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      score: Value(score),
      maxScore: Value(maxScore),
      answersJson: Value(answersJson),
      statusKey: Value(statusKey),
      createdAt: Value(createdAt),
    );
  }

  factory CognitiveAssessment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CognitiveAssessment(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      score: serializer.fromJson<int>(json['score']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      statusKey: serializer.fromJson<String>(json['statusKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'score': serializer.toJson<int>(score),
      'maxScore': serializer.toJson<int>(maxScore),
      'answersJson': serializer.toJson<String>(answersJson),
      'statusKey': serializer.toJson<String>(statusKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CognitiveAssessment copyWith({
    String? id,
    String? patientId,
    int? score,
    int? maxScore,
    String? answersJson,
    String? statusKey,
    DateTime? createdAt,
  }) => CognitiveAssessment(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    score: score ?? this.score,
    maxScore: maxScore ?? this.maxScore,
    answersJson: answersJson ?? this.answersJson,
    statusKey: statusKey ?? this.statusKey,
    createdAt: createdAt ?? this.createdAt,
  );
  CognitiveAssessment copyWithCompanion(CognitiveAssessmentsCompanion data) {
    return CognitiveAssessment(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      score: data.score.present ? data.score.value : this.score,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      statusKey: data.statusKey.present ? data.statusKey.value : this.statusKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CognitiveAssessment(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('answersJson: $answersJson, ')
          ..write('statusKey: $statusKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    score,
    maxScore,
    answersJson,
    statusKey,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CognitiveAssessment &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.score == this.score &&
          other.maxScore == this.maxScore &&
          other.answersJson == this.answersJson &&
          other.statusKey == this.statusKey &&
          other.createdAt == this.createdAt);
}

class CognitiveAssessmentsCompanion
    extends UpdateCompanion<CognitiveAssessment> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<int> score;
  final Value<int> maxScore;
  final Value<String> answersJson;
  final Value<String> statusKey;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CognitiveAssessmentsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.score = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.statusKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CognitiveAssessmentsCompanion.insert({
    required String id,
    required String patientId,
    required int score,
    required int maxScore,
    required String answersJson,
    required String statusKey,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       score = Value(score),
       maxScore = Value(maxScore),
       answersJson = Value(answersJson),
       statusKey = Value(statusKey),
       createdAt = Value(createdAt);
  static Insertable<CognitiveAssessment> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<int>? score,
    Expression<int>? maxScore,
    Expression<String>? answersJson,
    Expression<String>? statusKey,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (score != null) 'score': score,
      if (maxScore != null) 'max_score': maxScore,
      if (answersJson != null) 'answers_json': answersJson,
      if (statusKey != null) 'status_key': statusKey,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CognitiveAssessmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<int>? score,
    Value<int>? maxScore,
    Value<String>? answersJson,
    Value<String>? statusKey,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CognitiveAssessmentsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      answersJson: answersJson ?? this.answersJson,
      statusKey: statusKey ?? this.statusKey,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (statusKey.present) {
      map['status_key'] = Variable<String>(statusKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CognitiveAssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('answersJson: $answersJson, ')
          ..write('statusKey: $statusKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyNotesTable extends DailyNotes
    with TableInfo<$DailyNotesTable, DailyNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<String> patientId = GeneratedColumn<String>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NoteKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('general'),
      ).withConverter<NoteKind>($DailyNotesTable.$converterkind);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, patientId, kind, body, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patient_id'],
      )!,
      kind: $DailyNotesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyNotesTable createAlias(String alias) {
    return $DailyNotesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NoteKind, String, String> $converterkind =
      const EnumNameConverter<NoteKind>(NoteKind.values);
}

class DailyNote extends DataClass implements Insertable<DailyNote> {
  final String id;
  final String patientId;
  final NoteKind kind;
  final String body;
  final DateTime createdAt;
  const DailyNote({
    required this.id,
    required this.patientId,
    required this.kind,
    required this.body,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['patient_id'] = Variable<String>(patientId);
    {
      map['kind'] = Variable<String>(
        $DailyNotesTable.$converterkind.toSql(kind),
      );
    }
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyNotesCompanion toCompanion(bool nullToAbsent) {
    return DailyNotesCompanion(
      id: Value(id),
      patientId: Value(patientId),
      kind: Value(kind),
      body: Value(body),
      createdAt: Value(createdAt),
    );
  }

  factory DailyNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyNote(
      id: serializer.fromJson<String>(json['id']),
      patientId: serializer.fromJson<String>(json['patientId']),
      kind: $DailyNotesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'patientId': serializer.toJson<String>(patientId),
      'kind': serializer.toJson<String>(
        $DailyNotesTable.$converterkind.toJson(kind),
      ),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyNote copyWith({
    String? id,
    String? patientId,
    NoteKind? kind,
    String? body,
    DateTime? createdAt,
  }) => DailyNote(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    kind: kind ?? this.kind,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyNote copyWithCompanion(DailyNotesCompanion data) {
    return DailyNote(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      kind: data.kind.present ? data.kind.value : this.kind,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyNote(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('kind: $kind, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, patientId, kind, body, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyNote &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.kind == this.kind &&
          other.body == this.body &&
          other.createdAt == this.createdAt);
}

class DailyNotesCompanion extends UpdateCompanion<DailyNote> {
  final Value<String> id;
  final Value<String> patientId;
  final Value<NoteKind> kind;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DailyNotesCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.kind = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyNotesCompanion.insert({
    required String id,
    required String patientId,
    this.kind = const Value.absent(),
    required String body,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       patientId = Value(patientId),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<DailyNote> custom({
    Expression<String>? id,
    Expression<String>? patientId,
    Expression<String>? kind,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (kind != null) 'kind': kind,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? patientId,
    Value<NoteKind>? kind,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DailyNotesCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<String>(patientId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $DailyNotesTable.$converterkind.toSql(kind.value),
      );
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyNotesCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('kind: $kind, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CaregiverSettingsTable extends CaregiverSettings
    with TableInfo<$CaregiverSettingsTable, CaregiverSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CaregiverSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fontStepMeta = const VerificationMeta(
    'fontStep',
  );
  @override
  late final GeneratedColumn<int> fontStep = GeneratedColumn<int>(
    'font_step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _highContrastMeta = const VerificationMeta(
    'highContrast',
  );
  @override
  late final GeneratedColumn<bool> highContrast = GeneratedColumn<bool>(
    'high_contrast',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("high_contrast" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _remindersMeta = const VerificationMeta(
    'reminders',
  );
  @override
  late final GeneratedColumn<bool> reminders = GeneratedColumn<bool>(
    'reminders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminders" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _weeklyReportsMeta = const VerificationMeta(
    'weeklyReports',
  );
  @override
  late final GeneratedColumn<bool> weeklyReports = GeneratedColumn<bool>(
    'weekly_reports',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("weekly_reports" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sosAlertsMeta = const VerificationMeta(
    'sosAlerts',
  );
  @override
  late final GeneratedColumn<bool> sosAlerts = GeneratedColumn<bool>(
    'sos_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sos_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fontStep,
    highContrast,
    reminders,
    weeklyReports,
    sosAlerts,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'caregiver_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<CaregiverSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('font_step')) {
      context.handle(
        _fontStepMeta,
        fontStep.isAcceptableOrUnknown(data['font_step']!, _fontStepMeta),
      );
    }
    if (data.containsKey('high_contrast')) {
      context.handle(
        _highContrastMeta,
        highContrast.isAcceptableOrUnknown(
          data['high_contrast']!,
          _highContrastMeta,
        ),
      );
    }
    if (data.containsKey('reminders')) {
      context.handle(
        _remindersMeta,
        reminders.isAcceptableOrUnknown(data['reminders']!, _remindersMeta),
      );
    }
    if (data.containsKey('weekly_reports')) {
      context.handle(
        _weeklyReportsMeta,
        weeklyReports.isAcceptableOrUnknown(
          data['weekly_reports']!,
          _weeklyReportsMeta,
        ),
      );
    }
    if (data.containsKey('sos_alerts')) {
      context.handle(
        _sosAlertsMeta,
        sosAlerts.isAcceptableOrUnknown(data['sos_alerts']!, _sosAlertsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CaregiverSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CaregiverSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fontStep: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}font_step'],
      )!,
      highContrast: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}high_contrast'],
      )!,
      reminders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders'],
      )!,
      weeklyReports: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}weekly_reports'],
      )!,
      sosAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sos_alerts'],
      )!,
    );
  }

  @override
  $CaregiverSettingsTable createAlias(String alias) {
    return $CaregiverSettingsTable(attachedDatabase, alias);
  }
}

class CaregiverSetting extends DataClass
    implements Insertable<CaregiverSetting> {
  final String id;
  final int fontStep;
  final bool highContrast;
  final bool reminders;
  final bool weeklyReports;
  final bool sosAlerts;
  const CaregiverSetting({
    required this.id,
    required this.fontStep,
    required this.highContrast,
    required this.reminders,
    required this.weeklyReports,
    required this.sosAlerts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['font_step'] = Variable<int>(fontStep);
    map['high_contrast'] = Variable<bool>(highContrast);
    map['reminders'] = Variable<bool>(reminders);
    map['weekly_reports'] = Variable<bool>(weeklyReports);
    map['sos_alerts'] = Variable<bool>(sosAlerts);
    return map;
  }

  CaregiverSettingsCompanion toCompanion(bool nullToAbsent) {
    return CaregiverSettingsCompanion(
      id: Value(id),
      fontStep: Value(fontStep),
      highContrast: Value(highContrast),
      reminders: Value(reminders),
      weeklyReports: Value(weeklyReports),
      sosAlerts: Value(sosAlerts),
    );
  }

  factory CaregiverSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CaregiverSetting(
      id: serializer.fromJson<String>(json['id']),
      fontStep: serializer.fromJson<int>(json['fontStep']),
      highContrast: serializer.fromJson<bool>(json['highContrast']),
      reminders: serializer.fromJson<bool>(json['reminders']),
      weeklyReports: serializer.fromJson<bool>(json['weeklyReports']),
      sosAlerts: serializer.fromJson<bool>(json['sosAlerts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fontStep': serializer.toJson<int>(fontStep),
      'highContrast': serializer.toJson<bool>(highContrast),
      'reminders': serializer.toJson<bool>(reminders),
      'weeklyReports': serializer.toJson<bool>(weeklyReports),
      'sosAlerts': serializer.toJson<bool>(sosAlerts),
    };
  }

  CaregiverSetting copyWith({
    String? id,
    int? fontStep,
    bool? highContrast,
    bool? reminders,
    bool? weeklyReports,
    bool? sosAlerts,
  }) => CaregiverSetting(
    id: id ?? this.id,
    fontStep: fontStep ?? this.fontStep,
    highContrast: highContrast ?? this.highContrast,
    reminders: reminders ?? this.reminders,
    weeklyReports: weeklyReports ?? this.weeklyReports,
    sosAlerts: sosAlerts ?? this.sosAlerts,
  );
  CaregiverSetting copyWithCompanion(CaregiverSettingsCompanion data) {
    return CaregiverSetting(
      id: data.id.present ? data.id.value : this.id,
      fontStep: data.fontStep.present ? data.fontStep.value : this.fontStep,
      highContrast: data.highContrast.present
          ? data.highContrast.value
          : this.highContrast,
      reminders: data.reminders.present ? data.reminders.value : this.reminders,
      weeklyReports: data.weeklyReports.present
          ? data.weeklyReports.value
          : this.weeklyReports,
      sosAlerts: data.sosAlerts.present ? data.sosAlerts.value : this.sosAlerts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverSetting(')
          ..write('id: $id, ')
          ..write('fontStep: $fontStep, ')
          ..write('highContrast: $highContrast, ')
          ..write('reminders: $reminders, ')
          ..write('weeklyReports: $weeklyReports, ')
          ..write('sosAlerts: $sosAlerts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fontStep,
    highContrast,
    reminders,
    weeklyReports,
    sosAlerts,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CaregiverSetting &&
          other.id == this.id &&
          other.fontStep == this.fontStep &&
          other.highContrast == this.highContrast &&
          other.reminders == this.reminders &&
          other.weeklyReports == this.weeklyReports &&
          other.sosAlerts == this.sosAlerts);
}

class CaregiverSettingsCompanion extends UpdateCompanion<CaregiverSetting> {
  final Value<String> id;
  final Value<int> fontStep;
  final Value<bool> highContrast;
  final Value<bool> reminders;
  final Value<bool> weeklyReports;
  final Value<bool> sosAlerts;
  final Value<int> rowid;
  const CaregiverSettingsCompanion({
    this.id = const Value.absent(),
    this.fontStep = const Value.absent(),
    this.highContrast = const Value.absent(),
    this.reminders = const Value.absent(),
    this.weeklyReports = const Value.absent(),
    this.sosAlerts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CaregiverSettingsCompanion.insert({
    required String id,
    this.fontStep = const Value.absent(),
    this.highContrast = const Value.absent(),
    this.reminders = const Value.absent(),
    this.weeklyReports = const Value.absent(),
    this.sosAlerts = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CaregiverSetting> custom({
    Expression<String>? id,
    Expression<int>? fontStep,
    Expression<bool>? highContrast,
    Expression<bool>? reminders,
    Expression<bool>? weeklyReports,
    Expression<bool>? sosAlerts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fontStep != null) 'font_step': fontStep,
      if (highContrast != null) 'high_contrast': highContrast,
      if (reminders != null) 'reminders': reminders,
      if (weeklyReports != null) 'weekly_reports': weeklyReports,
      if (sosAlerts != null) 'sos_alerts': sosAlerts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CaregiverSettingsCompanion copyWith({
    Value<String>? id,
    Value<int>? fontStep,
    Value<bool>? highContrast,
    Value<bool>? reminders,
    Value<bool>? weeklyReports,
    Value<bool>? sosAlerts,
    Value<int>? rowid,
  }) {
    return CaregiverSettingsCompanion(
      id: id ?? this.id,
      fontStep: fontStep ?? this.fontStep,
      highContrast: highContrast ?? this.highContrast,
      reminders: reminders ?? this.reminders,
      weeklyReports: weeklyReports ?? this.weeklyReports,
      sosAlerts: sosAlerts ?? this.sosAlerts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fontStep.present) {
      map['font_step'] = Variable<int>(fontStep.value);
    }
    if (highContrast.present) {
      map['high_contrast'] = Variable<bool>(highContrast.value);
    }
    if (reminders.present) {
      map['reminders'] = Variable<bool>(reminders.value);
    }
    if (weeklyReports.present) {
      map['weekly_reports'] = Variable<bool>(weeklyReports.value);
    }
    if (sosAlerts.present) {
      map['sos_alerts'] = Variable<bool>(sosAlerts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CaregiverSettingsCompanion(')
          ..write('id: $id, ')
          ..write('fontStep: $fontStep, ')
          ..write('highContrast: $highContrast, ')
          ..write('reminders: $reminders, ')
          ..write('weeklyReports: $weeklyReports, ')
          ..write('sosAlerts: $sosAlerts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PatientProfilesTable patientProfiles = $PatientProfilesTable(
    this,
  );
  late final $CaregiverLinksTable caregiverLinks = $CaregiverLinksTable(this);
  late final $EmergencyContactsTable emergencyContacts =
      $EmergencyContactsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $DailyActivitiesTable dailyActivities = $DailyActivitiesTable(
    this,
  );
  late final $ActivityAttemptsTable activityAttempts = $ActivityAttemptsTable(
    this,
  );
  late final $MemoriesTable memories = $MemoriesTable(this);
  late final $GardensTable gardens = $GardensTable(this);
  late final $GardenElementsTable gardenElements = $GardenElementsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $SosIncidentsTable sosIncidents = $SosIncidentsTable(this);
  late final $SosContactAttemptsTable sosContactAttempts =
      $SosContactAttemptsTable(this);
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $AdaptiveProfilesTable adaptiveProfiles = $AdaptiveProfilesTable(
    this,
  );
  late final $LocationMemoriesTable locationMemories = $LocationMemoriesTable(
    this,
  );
  late final $DailyUnlocksTable dailyUnlocks = $DailyUnlocksTable(this);
  late final $CognitiveAssessmentsTable cognitiveAssessments =
      $CognitiveAssessmentsTable(this);
  late final $DailyNotesTable dailyNotes = $DailyNotesTable(this);
  late final $CaregiverSettingsTable caregiverSettings =
      $CaregiverSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    patientProfiles,
    caregiverLinks,
    emergencyContacts,
    activities,
    dailyActivities,
    activityAttempts,
    memories,
    gardens,
    gardenElements,
    reminders,
    notifications,
    sosIncidents,
    sosContactAttempts,
    syncQueueItems,
    userPreferences,
    adaptiveProfiles,
    locationMemories,
    dailyUnlocks,
    cognitiveAssessments,
    dailyNotes,
    caregiverSettings,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  required String role,
  Value<String?> username,
  Value<String?> passwordHash,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> role,
  Value<String?> username,
  Value<String?> passwordHash,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                role: role,
                username: username,
                passwordHash: passwordHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String role,
                Value<String?> username = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                role: role,
                username: username,
                passwordHash: passwordHash,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, User>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$PatientProfilesTableCreateCompanionBuilder =
    PatientProfilesCompanion Function({
      required String id,
      required String userId,
      required String displayName,
      Value<String?> region,
      Value<String> language,
      Value<String> voiceLanguage,
      Value<String> avatarEmoji,
      Value<DateTime?> dateOfBirth,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PatientProfilesTableUpdateCompanionBuilder =
    PatientProfilesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> displayName,
      Value<String?> region,
      Value<String> language,
      Value<String> voiceLanguage,
      Value<String> avatarEmoji,
      Value<DateTime?> dateOfBirth,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PatientProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarEmoji => $composableBuilder(
    column: $table.avatarEmoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PatientProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarEmoji => $composableBuilder(
    column: $table.avatarEmoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientProfilesTable> {
  $$PatientProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarEmoji => $composableBuilder(
    column: $table.avatarEmoji,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PatientProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientProfilesTable,
          PatientProfile,
          $$PatientProfilesTableFilterComposer,
          $$PatientProfilesTableOrderingComposer,
          $$PatientProfilesTableAnnotationComposer,
          $$PatientProfilesTableCreateCompanionBuilder,
          $$PatientProfilesTableUpdateCompanionBuilder,
          (
            PatientProfile,
            BaseReferences<
              _$AppDatabase,
              $PatientProfilesTable,
              PatientProfile
            >,
          ),
          PatientProfile,
          PrefetchHooks Function()
        > {
  $$PatientProfilesTableTableManager(
    _$AppDatabase db,
    $PatientProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> voiceLanguage = const Value.absent(),
                Value<String> avatarEmoji = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatientProfilesCompanion(
                id: id,
                userId: userId,
                displayName: displayName,
                region: region,
                language: language,
                voiceLanguage: voiceLanguage,
                avatarEmoji: avatarEmoji,
                dateOfBirth: dateOfBirth,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String displayName,
                Value<String?> region = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> voiceLanguage = const Value.absent(),
                Value<String> avatarEmoji = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PatientProfilesCompanion.insert(
                id: id,
                userId: userId,
                displayName: displayName,
                region: region,
                language: language,
                voiceLanguage: voiceLanguage,
                avatarEmoji: avatarEmoji,
                dateOfBirth: dateOfBirth,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PatientProfilesTable, PatientProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PatientProfilesTable,
                    PatientProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PatientProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientProfilesTable,
      PatientProfile,
      $$PatientProfilesTableFilterComposer,
      $$PatientProfilesTableOrderingComposer,
      $$PatientProfilesTableAnnotationComposer,
      $$PatientProfilesTableCreateCompanionBuilder,
      $$PatientProfilesTableUpdateCompanionBuilder,
      (
        PatientProfile,
        BaseReferences<_$AppDatabase, $PatientProfilesTable, PatientProfile>,
      ),
      PatientProfile,
      PrefetchHooks Function()
    >;
typedef $$CaregiverLinksTableCreateCompanionBuilder =
    CaregiverLinksCompanion Function({
      required String id,
      required String caregiverId,
      required String patientId,
      Value<String?> relationship,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CaregiverLinksTableUpdateCompanionBuilder =
    CaregiverLinksCompanion Function({
      Value<String> id,
      Value<String> caregiverId,
      Value<String> patientId,
      Value<String?> relationship,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CaregiverLinksTableFilterComposer
    extends Composer<_$AppDatabase, $CaregiverLinksTable> {
  $$CaregiverLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caregiverId => $composableBuilder(
    column: $table.caregiverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CaregiverLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $CaregiverLinksTable> {
  $$CaregiverLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caregiverId => $composableBuilder(
    column: $table.caregiverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CaregiverLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaregiverLinksTable> {
  $$CaregiverLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get caregiverId => $composableBuilder(
    column: $table.caregiverId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get relationship => $composableBuilder(
    column: $table.relationship,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CaregiverLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaregiverLinksTable,
          CaregiverLink,
          $$CaregiverLinksTableFilterComposer,
          $$CaregiverLinksTableOrderingComposer,
          $$CaregiverLinksTableAnnotationComposer,
          $$CaregiverLinksTableCreateCompanionBuilder,
          $$CaregiverLinksTableUpdateCompanionBuilder,
          (
            CaregiverLink,
            BaseReferences<_$AppDatabase, $CaregiverLinksTable, CaregiverLink>,
          ),
          CaregiverLink,
          PrefetchHooks Function()
        > {
  $$CaregiverLinksTableTableManager(
    _$AppDatabase db,
    $CaregiverLinksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaregiverLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaregiverLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaregiverLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> caregiverId = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String?> relationship = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaregiverLinksCompanion(
                id: id,
                caregiverId: caregiverId,
                patientId: patientId,
                relationship: relationship,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String caregiverId,
                required String patientId,
                Value<String?> relationship = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CaregiverLinksCompanion.insert(
                id: id,
                caregiverId: caregiverId,
                patientId: patientId,
                relationship: relationship,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CaregiverLinksTable, CaregiverLink>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CaregiverLinksTable,
                    CaregiverLink
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CaregiverLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaregiverLinksTable,
      CaregiverLink,
      $$CaregiverLinksTableFilterComposer,
      $$CaregiverLinksTableOrderingComposer,
      $$CaregiverLinksTableAnnotationComposer,
      $$CaregiverLinksTableCreateCompanionBuilder,
      $$CaregiverLinksTableUpdateCompanionBuilder,
      (
        CaregiverLink,
        BaseReferences<_$AppDatabase, $CaregiverLinksTable, CaregiverLink>,
      ),
      CaregiverLink,
      PrefetchHooks Function()
    >;
typedef $$EmergencyContactsTableCreateCompanionBuilder =
    EmergencyContactsCompanion Function({
      required String id,
      required String patientId,
      required String name,
      required String phone,
      Value<String?> relation,
      required EscalationPriority priority,
      Value<bool> canCall,
      Value<bool> canSms,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$EmergencyContactsTableUpdateCompanionBuilder =
    EmergencyContactsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> name,
      Value<String> phone,
      Value<String?> relation,
      Value<EscalationPriority> priority,
      Value<bool> canCall,
      Value<bool> canSms,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$EmergencyContactsTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyContactsTable> {
  $$EmergencyContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EscalationPriority, EscalationPriority, String>
  get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get canCall => $composableBuilder(
    column: $table.canCall,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canSms => $composableBuilder(
    column: $table.canSms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyContactsTable> {
  $$EmergencyContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canCall => $composableBuilder(
    column: $table.canCall,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canSms => $composableBuilder(
    column: $table.canSms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyContactsTable> {
  $$EmergencyContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EscalationPriority, String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get canCall =>
      $composableBuilder(column: $table.canCall, builder: (column) => column);

  GeneratedColumn<bool> get canSms =>
      $composableBuilder(column: $table.canSms, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EmergencyContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyContactsTable,
          EmergencyContact,
          $$EmergencyContactsTableFilterComposer,
          $$EmergencyContactsTableOrderingComposer,
          $$EmergencyContactsTableAnnotationComposer,
          $$EmergencyContactsTableCreateCompanionBuilder,
          $$EmergencyContactsTableUpdateCompanionBuilder,
          (
            EmergencyContact,
            BaseReferences<
              _$AppDatabase,
              $EmergencyContactsTable,
              EmergencyContact
            >,
          ),
          EmergencyContact,
          PrefetchHooks Function()
        > {
  $$EmergencyContactsTableTableManager(
    _$AppDatabase db,
    $EmergencyContactsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyContactsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> relation = const Value.absent(),
                Value<EscalationPriority> priority = const Value.absent(),
                Value<bool> canCall = const Value.absent(),
                Value<bool> canSms = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmergencyContactsCompanion(
                id: id,
                patientId: patientId,
                name: name,
                phone: phone,
                relation: relation,
                priority: priority,
                canCall: canCall,
                canSms: canSms,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String name,
                required String phone,
                Value<String?> relation = const Value.absent(),
                required EscalationPriority priority,
                Value<bool> canCall = const Value.absent(),
                Value<bool> canSms = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => EmergencyContactsCompanion.insert(
                id: id,
                patientId: patientId,
                name: name,
                phone: phone,
                relation: relation,
                priority: priority,
                canCall: canCall,
                canSms: canSms,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmergencyContactsTable, EmergencyContact>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $EmergencyContactsTable,
                    EmergencyContact
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyContactsTable,
      EmergencyContact,
      $$EmergencyContactsTableFilterComposer,
      $$EmergencyContactsTableOrderingComposer,
      $$EmergencyContactsTableAnnotationComposer,
      $$EmergencyContactsTableCreateCompanionBuilder,
      $$EmergencyContactsTableUpdateCompanionBuilder,
      (
        EmergencyContact,
        BaseReferences<
          _$AppDatabase,
          $EmergencyContactsTable,
          EmergencyContact
        >,
      ),
      EmergencyContact,
      PrefetchHooks Function()
    >;
typedef $$ActivitiesTableCreateCompanionBuilder = ActivitiesCompanion Function({
  required String id,
  required String type,
  required String titleKey,
  Value<String?> subtitleKey,
  required String category,
  required Difficulty baseDifficulty,
  Value<int> durationSec,
  required String contentJson,
  Value<bool> isCustom,
  Value<String?> region,
  Value<bool> enabled,
  Value<int> rowid,
});
typedef $$ActivitiesTableUpdateCompanionBuilder = ActivitiesCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String> titleKey,
  Value<String?> subtitleKey,
  Value<String> category,
  Value<Difficulty> baseDifficulty,
  Value<int> durationSec,
  Value<String> contentJson,
  Value<bool> isCustom,
  Value<String?> region,
  Value<bool> enabled,
  Value<int> rowid,
});

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitleKey => $composableBuilder(
    column: $table.subtitleKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, String>
  get baseDifficulty => $composableBuilder(
    column: $table.baseDifficulty,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleKey => $composableBuilder(
    column: $table.titleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitleKey => $composableBuilder(
    column: $table.subtitleKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseDifficulty => $composableBuilder(
    column: $table.baseDifficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get titleKey =>
      $composableBuilder(column: $table.titleKey, builder: (column) => column);

  GeneratedColumn<String> get subtitleKey => $composableBuilder(
    column: $table.subtitleKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, String> get baseDifficulty =>
      $composableBuilder(
        column: $table.baseDifficulty,
        builder: (column) => column,
      );

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
          Activity,
          PrefetchHooks Function()
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> titleKey = const Value.absent(),
                Value<String?> subtitleKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<Difficulty> baseDifficulty = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<String> contentJson = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion(
                id: id,
                type: type,
                titleKey: titleKey,
                subtitleKey: subtitleKey,
                category: category,
                baseDifficulty: baseDifficulty,
                durationSec: durationSec,
                contentJson: contentJson,
                isCustom: isCustom,
                region: region,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String titleKey,
                Value<String?> subtitleKey = const Value.absent(),
                required String category,
                required Difficulty baseDifficulty,
                Value<int> durationSec = const Value.absent(),
                required String contentJson,
                Value<bool> isCustom = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                id: id,
                type: type,
                titleKey: titleKey,
                subtitleKey: subtitleKey,
                category: category,
                baseDifficulty: baseDifficulty,
                durationSec: durationSec,
                contentJson: contentJson,
                isCustom: isCustom,
                region: region,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivitiesTable, Activity>(table),
                  BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
      Activity,
      PrefetchHooks Function()
    >;
typedef $$DailyActivitiesTableCreateCompanionBuilder =
    DailyActivitiesCompanion Function({
      required String id,
      required String patientId,
      required String activityId,
      required String forDate,
      required DailyStatus status,
      required DateTime assignedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$DailyActivitiesTableUpdateCompanionBuilder =
    DailyActivitiesCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> activityId,
      Value<String> forDate,
      Value<DailyStatus> status,
      Value<DateTime> assignedAt,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$DailyActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get forDate => $composableBuilder(
    column: $table.forDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DailyStatus, DailyStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get forDate => $composableBuilder(
    column: $table.forDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyActivitiesTable> {
  $$DailyActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get forDate =>
      $composableBuilder(column: $table.forDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DailyStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get assignedAt => $composableBuilder(
    column: $table.assignedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$DailyActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyActivitiesTable,
          DailyActivity,
          $$DailyActivitiesTableFilterComposer,
          $$DailyActivitiesTableOrderingComposer,
          $$DailyActivitiesTableAnnotationComposer,
          $$DailyActivitiesTableCreateCompanionBuilder,
          $$DailyActivitiesTableUpdateCompanionBuilder,
          (
            DailyActivity,
            BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>,
          ),
          DailyActivity,
          PrefetchHooks Function()
        > {
  $$DailyActivitiesTableTableManager(
    _$AppDatabase db,
    $DailyActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<String> forDate = const Value.absent(),
                Value<DailyStatus> status = const Value.absent(),
                Value<DateTime> assignedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyActivitiesCompanion(
                id: id,
                patientId: patientId,
                activityId: activityId,
                forDate: forDate,
                status: status,
                assignedAt: assignedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String activityId,
                required String forDate,
                required DailyStatus status,
                required DateTime assignedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyActivitiesCompanion.insert(
                id: id,
                patientId: patientId,
                activityId: activityId,
                forDate: forDate,
                status: status,
                assignedAt: assignedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyActivitiesTable, DailyActivity>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyActivitiesTable,
                    DailyActivity
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyActivitiesTable,
      DailyActivity,
      $$DailyActivitiesTableFilterComposer,
      $$DailyActivitiesTableOrderingComposer,
      $$DailyActivitiesTableAnnotationComposer,
      $$DailyActivitiesTableCreateCompanionBuilder,
      $$DailyActivitiesTableUpdateCompanionBuilder,
      (
        DailyActivity,
        BaseReferences<_$AppDatabase, $DailyActivitiesTable, DailyActivity>,
      ),
      DailyActivity,
      PrefetchHooks Function()
    >;
typedef $$ActivityAttemptsTableCreateCompanionBuilder =
    ActivityAttemptsCompanion Function({
      required String id,
      required String patientId,
      required String activityId,
      Value<String?> dailyActivityId,
      required DateTime startedAt,
      Value<DateTime?> finishedAt,
      Value<bool> completed,
      Value<int> correctCount,
      Value<int> totalCount,
      Value<int> hintCount,
      required Difficulty difficulty,
      Value<String?> resultJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ActivityAttemptsTableUpdateCompanionBuilder =
    ActivityAttemptsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> activityId,
      Value<String?> dailyActivityId,
      Value<DateTime> startedAt,
      Value<DateTime?> finishedAt,
      Value<bool> completed,
      Value<int> correctCount,
      Value<int> totalCount,
      Value<int> hintCount,
      Value<Difficulty> difficulty,
      Value<String?> resultJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ActivityAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityAttemptsTable> {
  $$ActivityAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailyActivityId => $composableBuilder(
    column: $table.dailyActivityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintCount => $composableBuilder(
    column: $table.hintCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, String>
  get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityAttemptsTable> {
  $$ActivityAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailyActivityId => $composableBuilder(
    column: $table.dailyActivityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintCount => $composableBuilder(
    column: $table.hintCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityAttemptsTable> {
  $$ActivityAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dailyActivityId => $composableBuilder(
    column: $table.dailyActivityId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hintCount =>
      $composableBuilder(column: $table.hintCount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, String> get difficulty =>
      $composableBuilder(
        column: $table.difficulty,
        builder: (column) => column,
      );

  GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ActivityAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityAttemptsTable,
          ActivityAttempt,
          $$ActivityAttemptsTableFilterComposer,
          $$ActivityAttemptsTableOrderingComposer,
          $$ActivityAttemptsTableAnnotationComposer,
          $$ActivityAttemptsTableCreateCompanionBuilder,
          $$ActivityAttemptsTableUpdateCompanionBuilder,
          (
            ActivityAttempt,
            BaseReferences<
              _$AppDatabase,
              $ActivityAttemptsTable,
              ActivityAttempt
            >,
          ),
          ActivityAttempt,
          PrefetchHooks Function()
        > {
  $$ActivityAttemptsTableTableManager(
    _$AppDatabase db,
    $ActivityAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<String?> dailyActivityId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<int> hintCount = const Value.absent(),
                Value<Difficulty> difficulty = const Value.absent(),
                Value<String?> resultJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityAttemptsCompanion(
                id: id,
                patientId: patientId,
                activityId: activityId,
                dailyActivityId: dailyActivityId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                completed: completed,
                correctCount: correctCount,
                totalCount: totalCount,
                hintCount: hintCount,
                difficulty: difficulty,
                resultJson: resultJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String activityId,
                Value<String?> dailyActivityId = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<int> hintCount = const Value.absent(),
                required Difficulty difficulty,
                Value<String?> resultJson = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ActivityAttemptsCompanion.insert(
                id: id,
                patientId: patientId,
                activityId: activityId,
                dailyActivityId: dailyActivityId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                completed: completed,
                correctCount: correctCount,
                totalCount: totalCount,
                hintCount: hintCount,
                difficulty: difficulty,
                resultJson: resultJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivityAttemptsTable, ActivityAttempt>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ActivityAttemptsTable,
                    ActivityAttempt
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityAttemptsTable,
      ActivityAttempt,
      $$ActivityAttemptsTableFilterComposer,
      $$ActivityAttemptsTableOrderingComposer,
      $$ActivityAttemptsTableAnnotationComposer,
      $$ActivityAttemptsTableCreateCompanionBuilder,
      $$ActivityAttemptsTableUpdateCompanionBuilder,
      (
        ActivityAttempt,
        BaseReferences<_$AppDatabase, $ActivityAttemptsTable, ActivityAttempt>,
      ),
      ActivityAttempt,
      PrefetchHooks Function()
    >;
typedef $$MemoriesTableCreateCompanionBuilder = MemoriesCompanion Function({
  required String id,
  required String patientId,
  required String kind,
  required String title,
  Value<String?> caption,
  Value<String?> relation,
  Value<String?> mediaPath,
  Value<String?> mediaUrl,
  Value<String> category,
  Value<String?> placeName,
  Value<String?> createdBy,
  Value<String> placementsJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$MemoriesTableUpdateCompanionBuilder = MemoriesCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> kind,
  Value<String> title,
  Value<String?> caption,
  Value<String?> relation,
  Value<String?> mediaPath,
  Value<String?> mediaUrl,
  Value<String> category,
  Value<String?> placeName,
  Value<String?> createdBy,
  Value<String> placementsJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$MemoriesTableFilterComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaPath => $composableBuilder(
    column: $table.mediaPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaUrl => $composableBuilder(
    column: $table.mediaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeName => $composableBuilder(
    column: $table.placeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placementsJson => $composableBuilder(
    column: $table.placementsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MemoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relation => $composableBuilder(
    column: $table.relation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaPath => $composableBuilder(
    column: $table.mediaPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaUrl => $composableBuilder(
    column: $table.mediaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeName => $composableBuilder(
    column: $table.placeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placementsJson => $composableBuilder(
    column: $table.placementsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MemoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemoriesTable> {
  $$MemoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<String> get mediaPath =>
      $composableBuilder(column: $table.mediaPath, builder: (column) => column);

  GeneratedColumn<String> get mediaUrl =>
      $composableBuilder(column: $table.mediaUrl, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get placeName =>
      $composableBuilder(column: $table.placeName, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get placementsJson => $composableBuilder(
    column: $table.placementsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MemoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MemoriesTable,
          Memory,
          $$MemoriesTableFilterComposer,
          $$MemoriesTableOrderingComposer,
          $$MemoriesTableAnnotationComposer,
          $$MemoriesTableCreateCompanionBuilder,
          $$MemoriesTableUpdateCompanionBuilder,
          (Memory, BaseReferences<_$AppDatabase, $MemoriesTable, Memory>),
          Memory,
          PrefetchHooks Function()
        > {
  $$MemoriesTableTableManager(_$AppDatabase db, $MemoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<String?> relation = const Value.absent(),
                Value<String?> mediaPath = const Value.absent(),
                Value<String?> mediaUrl = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> placeName = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String> placementsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MemoriesCompanion(
                id: id,
                patientId: patientId,
                kind: kind,
                title: title,
                caption: caption,
                relation: relation,
                mediaPath: mediaPath,
                mediaUrl: mediaUrl,
                category: category,
                placeName: placeName,
                createdBy: createdBy,
                placementsJson: placementsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String kind,
                required String title,
                Value<String?> caption = const Value.absent(),
                Value<String?> relation = const Value.absent(),
                Value<String?> mediaPath = const Value.absent(),
                Value<String?> mediaUrl = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> placeName = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String> placementsJson = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MemoriesCompanion.insert(
                id: id,
                patientId: patientId,
                kind: kind,
                title: title,
                caption: caption,
                relation: relation,
                mediaPath: mediaPath,
                mediaUrl: mediaUrl,
                category: category,
                placeName: placeName,
                createdBy: createdBy,
                placementsJson: placementsJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MemoriesTable, Memory>(table),
                  BaseReferences<_$AppDatabase, $MemoriesTable, Memory>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MemoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MemoriesTable,
      Memory,
      $$MemoriesTableFilterComposer,
      $$MemoriesTableOrderingComposer,
      $$MemoriesTableAnnotationComposer,
      $$MemoriesTableCreateCompanionBuilder,
      $$MemoriesTableUpdateCompanionBuilder,
      (Memory, BaseReferences<_$AppDatabase, $MemoriesTable, Memory>),
      Memory,
      PrefetchHooks Function()
    >;
typedef $$GardensTableCreateCompanionBuilder = GardensCompanion Function({
  required String id,
  required String patientId,
  Value<String> name,
  Value<int> points,
  Value<int> level,
  Value<int> activitiesCompleted,
  Value<DateTime?> lastGrownAt,
  Value<int> rowid,
});
typedef $$GardensTableUpdateCompanionBuilder = GardensCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> name,
  Value<int> points,
  Value<int> level,
  Value<int> activitiesCompleted,
  Value<DateTime?> lastGrownAt,
  Value<int> rowid,
});

class $$GardensTableFilterComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activitiesCompleted => $composableBuilder(
    column: $table.activitiesCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastGrownAt => $composableBuilder(
    column: $table.lastGrownAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GardensTableOrderingComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activitiesCompleted => $composableBuilder(
    column: $table.activitiesCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastGrownAt => $composableBuilder(
    column: $table.lastGrownAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GardensTableAnnotationComposer
    extends Composer<_$AppDatabase, $GardensTable> {
  $$GardensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get activitiesCompleted => $composableBuilder(
    column: $table.activitiesCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastGrownAt => $composableBuilder(
    column: $table.lastGrownAt,
    builder: (column) => column,
  );
}

class $$GardensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GardensTable,
          Garden,
          $$GardensTableFilterComposer,
          $$GardensTableOrderingComposer,
          $$GardensTableAnnotationComposer,
          $$GardensTableCreateCompanionBuilder,
          $$GardensTableUpdateCompanionBuilder,
          (Garden, BaseReferences<_$AppDatabase, $GardensTable, Garden>),
          Garden,
          PrefetchHooks Function()
        > {
  $$GardensTableTableManager(_$AppDatabase db, $GardensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GardensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GardensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GardensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> activitiesCompleted = const Value.absent(),
                Value<DateTime?> lastGrownAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardensCompanion(
                id: id,
                patientId: patientId,
                name: name,
                points: points,
                level: level,
                activitiesCompleted: activitiesCompleted,
                lastGrownAt: lastGrownAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<String> name = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> activitiesCompleted = const Value.absent(),
                Value<DateTime?> lastGrownAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardensCompanion.insert(
                id: id,
                patientId: patientId,
                name: name,
                points: points,
                level: level,
                activitiesCompleted: activitiesCompleted,
                lastGrownAt: lastGrownAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GardensTable, Garden>(table),
                  BaseReferences<_$AppDatabase, $GardensTable, Garden>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GardensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GardensTable,
      Garden,
      $$GardensTableFilterComposer,
      $$GardensTableOrderingComposer,
      $$GardensTableAnnotationComposer,
      $$GardensTableCreateCompanionBuilder,
      $$GardensTableUpdateCompanionBuilder,
      (Garden, BaseReferences<_$AppDatabase, $GardensTable, Garden>),
      Garden,
      PrefetchHooks Function()
    >;
typedef $$GardenElementsTableCreateCompanionBuilder =
    GardenElementsCompanion Function({
      required String id,
      required String gardenId,
      required String kind,
      Value<String> section,
      required PlantStage stage,
      Value<String?> memoryId,
      Value<String?> label,
      Value<String> emoji,
      required DateTime plantedAt,
      Value<DateTime?> lastGrowthAt,
      Value<int> rowid,
    });
typedef $$GardenElementsTableUpdateCompanionBuilder =
    GardenElementsCompanion Function({
      Value<String> id,
      Value<String> gardenId,
      Value<String> kind,
      Value<String> section,
      Value<PlantStage> stage,
      Value<String?> memoryId,
      Value<String?> label,
      Value<String> emoji,
      Value<DateTime> plantedAt,
      Value<DateTime?> lastGrowthAt,
      Value<int> rowid,
    });

class $$GardenElementsTableFilterComposer
    extends Composer<_$AppDatabase, $GardenElementsTable> {
  $$GardenElementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gardenId => $composableBuilder(
    column: $table.gardenId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlantStage, PlantStage, String> get stage =>
      $composableBuilder(
        column: $table.stage,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plantedAt => $composableBuilder(
    column: $table.plantedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastGrowthAt => $composableBuilder(
    column: $table.lastGrowthAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GardenElementsTableOrderingComposer
    extends Composer<_$AppDatabase, $GardenElementsTable> {
  $$GardenElementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gardenId => $composableBuilder(
    column: $table.gardenId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get section => $composableBuilder(
    column: $table.section,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plantedAt => $composableBuilder(
    column: $table.plantedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastGrowthAt => $composableBuilder(
    column: $table.lastGrowthAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GardenElementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GardenElementsTable> {
  $$GardenElementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gardenId =>
      $composableBuilder(column: $table.gardenId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get section =>
      $composableBuilder(column: $table.section, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlantStage, String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get memoryId =>
      $composableBuilder(column: $table.memoryId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<DateTime> get plantedAt =>
      $composableBuilder(column: $table.plantedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastGrowthAt => $composableBuilder(
    column: $table.lastGrowthAt,
    builder: (column) => column,
  );
}

class $$GardenElementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GardenElementsTable,
          GardenElement,
          $$GardenElementsTableFilterComposer,
          $$GardenElementsTableOrderingComposer,
          $$GardenElementsTableAnnotationComposer,
          $$GardenElementsTableCreateCompanionBuilder,
          $$GardenElementsTableUpdateCompanionBuilder,
          (
            GardenElement,
            BaseReferences<_$AppDatabase, $GardenElementsTable, GardenElement>,
          ),
          GardenElement,
          PrefetchHooks Function()
        > {
  $$GardenElementsTableTableManager(
    _$AppDatabase db,
    $GardenElementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GardenElementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GardenElementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GardenElementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gardenId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> section = const Value.absent(),
                Value<PlantStage> stage = const Value.absent(),
                Value<String?> memoryId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<DateTime> plantedAt = const Value.absent(),
                Value<DateTime?> lastGrowthAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardenElementsCompanion(
                id: id,
                gardenId: gardenId,
                kind: kind,
                section: section,
                stage: stage,
                memoryId: memoryId,
                label: label,
                emoji: emoji,
                plantedAt: plantedAt,
                lastGrowthAt: lastGrowthAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gardenId,
                required String kind,
                Value<String> section = const Value.absent(),
                required PlantStage stage,
                Value<String?> memoryId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                required DateTime plantedAt,
                Value<DateTime?> lastGrowthAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GardenElementsCompanion.insert(
                id: id,
                gardenId: gardenId,
                kind: kind,
                section: section,
                stage: stage,
                memoryId: memoryId,
                label: label,
                emoji: emoji,
                plantedAt: plantedAt,
                lastGrowthAt: lastGrowthAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GardenElementsTable, GardenElement>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GardenElementsTable,
                    GardenElement
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GardenElementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GardenElementsTable,
      GardenElement,
      $$GardenElementsTableFilterComposer,
      $$GardenElementsTableOrderingComposer,
      $$GardenElementsTableAnnotationComposer,
      $$GardenElementsTableCreateCompanionBuilder,
      $$GardenElementsTableUpdateCompanionBuilder,
      (
        GardenElement,
        BaseReferences<_$AppDatabase, $GardenElementsTable, GardenElement>,
      ),
      GardenElement,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String patientId,
  required String title,
  Value<String?> detail,
  required int hour,
  required int minute,
  Value<String> kind,
  Value<String> daysJson,
  Value<bool> enabled,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<String> title,
  Value<String?> detail,
  Value<int> hour,
  Value<int> minute,
  Value<String> kind,
  Value<String> daysJson,
  Value<bool> enabled,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get daysJson => $composableBuilder(
    column: $table.daysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get daysJson => $composableBuilder(
    column: $table.daysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get daysJson =>
      $composableBuilder(column: $table.daysJson, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> daysJson = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                patientId: patientId,
                title: title,
                detail: detail,
                hour: hour,
                minute: minute,
                kind: kind,
                daysJson: daysJson,
                enabled: enabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String title,
                Value<String?> detail = const Value.absent(),
                required int hour,
                required int minute,
                Value<String> kind = const Value.absent(),
                Value<String> daysJson = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                patientId: patientId,
                title: title,
                detail: detail,
                hour: hour,
                minute: minute,
                kind: kind,
                daysJson: daysJson,
                enabled: enabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  BaseReferences<_$AppDatabase, $RemindersTable, Reminder>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      required String id,
      Value<String?> patientId,
      required String title,
      required String body,
      Value<String> type,
      Value<bool> isRead,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<String> id,
      Value<String?> patientId,
      Value<String> title,
      Value<String> body,
      Value<String> type,
      Value<bool> isRead,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (
            Notification,
            BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
          ),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> patientId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                patientId: patientId,
                title: title,
                body: body,
                type: type,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> patientId = const Value.absent(),
                required String title,
                required String body,
                Value<String> type = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                patientId: patientId,
                title: title,
                body: body,
                type: type,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationsTable, Notification>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationsTable,
                    Notification
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (
        Notification,
        BaseReferences<_$AppDatabase, $NotificationsTable, Notification>,
      ),
      Notification,
      PrefetchHooks Function()
    >;
typedef $$SosIncidentsTableCreateCompanionBuilder =
    SosIncidentsCompanion Function({
      required String id,
      required String patientId,
      required DateTime startedAt,
      required SosStatus status,
      Value<int> escalationStep,
      Value<String?> currentContactId,
      Value<String> currentMethod,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> acknowledgedAt,
      Value<DateTime?> resolvedAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$SosIncidentsTableUpdateCompanionBuilder =
    SosIncidentsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<DateTime> startedAt,
      Value<SosStatus> status,
      Value<int> escalationStep,
      Value<String?> currentContactId,
      Value<String> currentMethod,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime?> acknowledgedAt,
      Value<DateTime?> resolvedAt,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$SosIncidentsTableFilterComposer
    extends Composer<_$AppDatabase, $SosIncidentsTable> {
  $$SosIncidentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SosStatus, SosStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get escalationStep => $composableBuilder(
    column: $table.escalationStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentContactId => $composableBuilder(
    column: $table.currentContactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentMethod => $composableBuilder(
    column: $table.currentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SosIncidentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SosIncidentsTable> {
  $$SosIncidentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get escalationStep => $composableBuilder(
    column: $table.escalationStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentContactId => $composableBuilder(
    column: $table.currentContactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentMethod => $composableBuilder(
    column: $table.currentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SosIncidentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SosIncidentsTable> {
  $$SosIncidentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SosStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get escalationStep => $composableBuilder(
    column: $table.escalationStep,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentContactId => $composableBuilder(
    column: $table.currentContactId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentMethod => $composableBuilder(
    column: $table.currentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acknowledgedAt => $composableBuilder(
    column: $table.acknowledgedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$SosIncidentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SosIncidentsTable,
          SosIncident,
          $$SosIncidentsTableFilterComposer,
          $$SosIncidentsTableOrderingComposer,
          $$SosIncidentsTableAnnotationComposer,
          $$SosIncidentsTableCreateCompanionBuilder,
          $$SosIncidentsTableUpdateCompanionBuilder,
          (
            SosIncident,
            BaseReferences<_$AppDatabase, $SosIncidentsTable, SosIncident>,
          ),
          SosIncident,
          PrefetchHooks Function()
        > {
  $$SosIncidentsTableTableManager(_$AppDatabase db, $SosIncidentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SosIncidentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SosIncidentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SosIncidentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<SosStatus> status = const Value.absent(),
                Value<int> escalationStep = const Value.absent(),
                Value<String?> currentContactId = const Value.absent(),
                Value<String> currentMethod = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SosIncidentsCompanion(
                id: id,
                patientId: patientId,
                startedAt: startedAt,
                status: status,
                escalationStep: escalationStep,
                currentContactId: currentContactId,
                currentMethod: currentMethod,
                lastAttemptAt: lastAttemptAt,
                acknowledgedAt: acknowledgedAt,
                resolvedAt: resolvedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required DateTime startedAt,
                required SosStatus status,
                Value<int> escalationStep = const Value.absent(),
                Value<String?> currentContactId = const Value.absent(),
                Value<String> currentMethod = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> acknowledgedAt = const Value.absent(),
                Value<DateTime?> resolvedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SosIncidentsCompanion.insert(
                id: id,
                patientId: patientId,
                startedAt: startedAt,
                status: status,
                escalationStep: escalationStep,
                currentContactId: currentContactId,
                currentMethod: currentMethod,
                lastAttemptAt: lastAttemptAt,
                acknowledgedAt: acknowledgedAt,
                resolvedAt: resolvedAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SosIncidentsTable, SosIncident>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SosIncidentsTable,
                    SosIncident
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SosIncidentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SosIncidentsTable,
      SosIncident,
      $$SosIncidentsTableFilterComposer,
      $$SosIncidentsTableOrderingComposer,
      $$SosIncidentsTableAnnotationComposer,
      $$SosIncidentsTableCreateCompanionBuilder,
      $$SosIncidentsTableUpdateCompanionBuilder,
      (
        SosIncident,
        BaseReferences<_$AppDatabase, $SosIncidentsTable, SosIncident>,
      ),
      SosIncident,
      PrefetchHooks Function()
    >;
typedef $$SosContactAttemptsTableCreateCompanionBuilder =
    SosContactAttemptsCompanion Function({
      required String id,
      required String incidentId,
      required String contactId,
      required int attemptOrder,
      required String method,
      required ContactAttemptStatus status,
      required DateTime attemptedAt,
      Value<DateTime?> respondedAt,
      Value<int> rowid,
    });
typedef $$SosContactAttemptsTableUpdateCompanionBuilder =
    SosContactAttemptsCompanion Function({
      Value<String> id,
      Value<String> incidentId,
      Value<String> contactId,
      Value<int> attemptOrder,
      Value<String> method,
      Value<ContactAttemptStatus> status,
      Value<DateTime> attemptedAt,
      Value<DateTime?> respondedAt,
      Value<int> rowid,
    });

class $$SosContactAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $SosContactAttemptsTable> {
  $$SosContactAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get incidentId => $composableBuilder(
    column: $table.incidentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptOrder => $composableBuilder(
    column: $table.attemptOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    ContactAttemptStatus,
    ContactAttemptStatus,
    String
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SosContactAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $SosContactAttemptsTable> {
  $$SosContactAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get incidentId => $composableBuilder(
    column: $table.incidentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactId => $composableBuilder(
    column: $table.contactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptOrder => $composableBuilder(
    column: $table.attemptOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SosContactAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SosContactAttemptsTable> {
  $$SosContactAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get incidentId => $composableBuilder(
    column: $table.incidentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactId =>
      $composableBuilder(column: $table.contactId, builder: (column) => column);

  GeneratedColumn<int> get attemptOrder => $composableBuilder(
    column: $table.attemptOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContactAttemptStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get respondedAt => $composableBuilder(
    column: $table.respondedAt,
    builder: (column) => column,
  );
}

class $$SosContactAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SosContactAttemptsTable,
          SosContactAttempt,
          $$SosContactAttemptsTableFilterComposer,
          $$SosContactAttemptsTableOrderingComposer,
          $$SosContactAttemptsTableAnnotationComposer,
          $$SosContactAttemptsTableCreateCompanionBuilder,
          $$SosContactAttemptsTableUpdateCompanionBuilder,
          (
            SosContactAttempt,
            BaseReferences<
              _$AppDatabase,
              $SosContactAttemptsTable,
              SosContactAttempt
            >,
          ),
          SosContactAttempt,
          PrefetchHooks Function()
        > {
  $$SosContactAttemptsTableTableManager(
    _$AppDatabase db,
    $SosContactAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SosContactAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SosContactAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SosContactAttemptsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> incidentId = const Value.absent(),
                Value<String> contactId = const Value.absent(),
                Value<int> attemptOrder = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<ContactAttemptStatus> status = const Value.absent(),
                Value<DateTime> attemptedAt = const Value.absent(),
                Value<DateTime?> respondedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SosContactAttemptsCompanion(
                id: id,
                incidentId: incidentId,
                contactId: contactId,
                attemptOrder: attemptOrder,
                method: method,
                status: status,
                attemptedAt: attemptedAt,
                respondedAt: respondedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String incidentId,
                required String contactId,
                required int attemptOrder,
                required String method,
                required ContactAttemptStatus status,
                required DateTime attemptedAt,
                Value<DateTime?> respondedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SosContactAttemptsCompanion.insert(
                id: id,
                incidentId: incidentId,
                contactId: contactId,
                attemptOrder: attemptOrder,
                method: method,
                status: status,
                attemptedAt: attemptedAt,
                respondedAt: respondedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SosContactAttemptsTable, SosContactAttempt>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $SosContactAttemptsTable,
                    SosContactAttempt
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SosContactAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SosContactAttemptsTable,
      SosContactAttempt,
      $$SosContactAttemptsTableFilterComposer,
      $$SosContactAttemptsTableOrderingComposer,
      $$SosContactAttemptsTableAnnotationComposer,
      $$SosContactAttemptsTableCreateCompanionBuilder,
      $$SosContactAttemptsTableUpdateCompanionBuilder,
      (
        SosContactAttempt,
        BaseReferences<
          _$AppDatabase,
          $SosContactAttemptsTable,
          SosContactAttempt
        >,
      ),
      SosContactAttempt,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueItemsTableCreateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String operation,
      required String payloadJson,
      required SyncStatus status,
      Value<int> retryCount,
      required String idempotencyKey,
      required DateTime createdAt,
      Value<DateTime?> syncedAt,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SyncQueueItemsTableUpdateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<SyncStatus> status,
      Value<int> retryCount,
      Value<String> idempotencyKey,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$SyncQueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SyncStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueItemsTable,
          SyncQueueItem,
          $$SyncQueueItemsTableFilterComposer,
          $$SyncQueueItemsTableOrderingComposer,
          $$SyncQueueItemsTableAnnotationComposer,
          $$SyncQueueItemsTableCreateCompanionBuilder,
          $$SyncQueueItemsTableUpdateCompanionBuilder,
          (
            SyncQueueItem,
            BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
          ),
          SyncQueueItem,
          PrefetchHooks Function()
        > {
  $$SyncQueueItemsTableTableManager(
    _$AppDatabase db,
    $SyncQueueItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<SyncStatus> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                retryCount: retryCount,
                idempotencyKey: idempotencyKey,
                createdAt: createdAt,
                syncedAt: syncedAt,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String operation,
                required String payloadJson,
                required SyncStatus status,
                Value<int> retryCount = const Value.absent(),
                required String idempotencyKey,
                required DateTime createdAt,
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                retryCount: retryCount,
                idempotencyKey: idempotencyKey,
                createdAt: createdAt,
                syncedAt: syncedAt,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncQueueItemsTable, SyncQueueItem>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncQueueItemsTable,
                    SyncQueueItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueItemsTable,
      SyncQueueItem,
      $$SyncQueueItemsTableFilterComposer,
      $$SyncQueueItemsTableOrderingComposer,
      $$SyncQueueItemsTableAnnotationComposer,
      $$SyncQueueItemsTableCreateCompanionBuilder,
      $$SyncQueueItemsTableUpdateCompanionBuilder,
      (
        SyncQueueItem,
        BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
      ),
      SyncQueueItem,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String patientId,
      Value<String> language,
      Value<String> voiceLanguage,
      Value<bool> speechPrompts,
      Value<bool> reducedMotion,
      Value<bool> largeText,
      Value<bool> soundEffects,
      Value<bool> demoMode,
      Value<int> escalationMinutes,
      Value<DateTime?> onboardedAt,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> patientId,
      Value<String> language,
      Value<String> voiceLanguage,
      Value<bool> speechPrompts,
      Value<bool> reducedMotion,
      Value<bool> largeText,
      Value<bool> soundEffects,
      Value<bool> demoMode,
      Value<int> escalationMinutes,
      Value<DateTime?> onboardedAt,
      Value<int> rowid,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get speechPrompts => $composableBuilder(
    column: $table.speechPrompts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get largeText => $composableBuilder(
    column: $table.largeText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEffects => $composableBuilder(
    column: $table.soundEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get demoMode => $composableBuilder(
    column: $table.demoMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get escalationMinutes => $composableBuilder(
    column: $table.escalationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get onboardedAt => $composableBuilder(
    column: $table.onboardedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get speechPrompts => $composableBuilder(
    column: $table.speechPrompts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get largeText => $composableBuilder(
    column: $table.largeText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEffects => $composableBuilder(
    column: $table.soundEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get demoMode => $composableBuilder(
    column: $table.demoMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get escalationMinutes => $composableBuilder(
    column: $table.escalationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get onboardedAt => $composableBuilder(
    column: $table.onboardedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get voiceLanguage => $composableBuilder(
    column: $table.voiceLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get speechPrompts => $composableBuilder(
    column: $table.speechPrompts,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get largeText =>
      $composableBuilder(column: $table.largeText, builder: (column) => column);

  GeneratedColumn<bool> get soundEffects => $composableBuilder(
    column: $table.soundEffects,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get demoMode =>
      $composableBuilder(column: $table.demoMode, builder: (column) => column);

  GeneratedColumn<int> get escalationMinutes => $composableBuilder(
    column: $table.escalationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get onboardedAt => $composableBuilder(
    column: $table.onboardedAt,
    builder: (column) => column,
  );
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreference,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreference
            >,
          ),
          UserPreference,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> patientId = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> voiceLanguage = const Value.absent(),
                Value<bool> speechPrompts = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<bool> largeText = const Value.absent(),
                Value<bool> soundEffects = const Value.absent(),
                Value<bool> demoMode = const Value.absent(),
                Value<int> escalationMinutes = const Value.absent(),
                Value<DateTime?> onboardedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                patientId: patientId,
                language: language,
                voiceLanguage: voiceLanguage,
                speechPrompts: speechPrompts,
                reducedMotion: reducedMotion,
                largeText: largeText,
                soundEffects: soundEffects,
                demoMode: demoMode,
                escalationMinutes: escalationMinutes,
                onboardedAt: onboardedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String patientId,
                Value<String> language = const Value.absent(),
                Value<String> voiceLanguage = const Value.absent(),
                Value<bool> speechPrompts = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<bool> largeText = const Value.absent(),
                Value<bool> soundEffects = const Value.absent(),
                Value<bool> demoMode = const Value.absent(),
                Value<int> escalationMinutes = const Value.absent(),
                Value<DateTime?> onboardedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                patientId: patientId,
                language: language,
                voiceLanguage: voiceLanguage,
                speechPrompts: speechPrompts,
                reducedMotion: reducedMotion,
                largeText: largeText,
                soundEffects: soundEffects,
                demoMode: demoMode,
                escalationMinutes: escalationMinutes,
                onboardedAt: onboardedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTable, UserPreference>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserPreferencesTable,
                    UserPreference
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreference,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference>,
      ),
      UserPreference,
      PrefetchHooks Function()
    >;
typedef $$AdaptiveProfilesTableCreateCompanionBuilder =
    AdaptiveProfilesCompanion Function({
      required String patientId,
      required Difficulty overallDifficulty,
      Value<String> categoryStatsJson,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AdaptiveProfilesTableUpdateCompanionBuilder =
    AdaptiveProfilesCompanion Function({
      Value<String> patientId,
      Value<Difficulty> overallDifficulty,
      Value<String> categoryStatsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AdaptiveProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $AdaptiveProfilesTable> {
  $$AdaptiveProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Difficulty, Difficulty, String>
  get overallDifficulty => $composableBuilder(
    column: $table.overallDifficulty,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get categoryStatsJson => $composableBuilder(
    column: $table.categoryStatsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdaptiveProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $AdaptiveProfilesTable> {
  $$AdaptiveProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overallDifficulty => $composableBuilder(
    column: $table.overallDifficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryStatsJson => $composableBuilder(
    column: $table.categoryStatsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdaptiveProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdaptiveProfilesTable> {
  $$AdaptiveProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Difficulty, String> get overallDifficulty =>
      $composableBuilder(
        column: $table.overallDifficulty,
        builder: (column) => column,
      );

  GeneratedColumn<String> get categoryStatsJson => $composableBuilder(
    column: $table.categoryStatsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AdaptiveProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdaptiveProfilesTable,
          AdaptiveProfile,
          $$AdaptiveProfilesTableFilterComposer,
          $$AdaptiveProfilesTableOrderingComposer,
          $$AdaptiveProfilesTableAnnotationComposer,
          $$AdaptiveProfilesTableCreateCompanionBuilder,
          $$AdaptiveProfilesTableUpdateCompanionBuilder,
          (
            AdaptiveProfile,
            BaseReferences<
              _$AppDatabase,
              $AdaptiveProfilesTable,
              AdaptiveProfile
            >,
          ),
          AdaptiveProfile,
          PrefetchHooks Function()
        > {
  $$AdaptiveProfilesTableTableManager(
    _$AppDatabase db,
    $AdaptiveProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdaptiveProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdaptiveProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdaptiveProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> patientId = const Value.absent(),
                Value<Difficulty> overallDifficulty = const Value.absent(),
                Value<String> categoryStatsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdaptiveProfilesCompanion(
                patientId: patientId,
                overallDifficulty: overallDifficulty,
                categoryStatsJson: categoryStatsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String patientId,
                required Difficulty overallDifficulty,
                Value<String> categoryStatsJson = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AdaptiveProfilesCompanion.insert(
                patientId: patientId,
                overallDifficulty: overallDifficulty,
                categoryStatsJson: categoryStatsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AdaptiveProfilesTable, AdaptiveProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AdaptiveProfilesTable,
                    AdaptiveProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdaptiveProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdaptiveProfilesTable,
      AdaptiveProfile,
      $$AdaptiveProfilesTableFilterComposer,
      $$AdaptiveProfilesTableOrderingComposer,
      $$AdaptiveProfilesTableAnnotationComposer,
      $$AdaptiveProfilesTableCreateCompanionBuilder,
      $$AdaptiveProfilesTableUpdateCompanionBuilder,
      (
        AdaptiveProfile,
        BaseReferences<_$AppDatabase, $AdaptiveProfilesTable, AdaptiveProfile>,
      ),
      AdaptiveProfile,
      PrefetchHooks Function()
    >;
typedef $$LocationMemoriesTableCreateCompanionBuilder =
    LocationMemoriesCompanion Function({
      required String id,
      required String patientId,
      required String name,
      Value<String?> region,
      Value<String?> state,
      Value<String?> notes,
      Value<String?> memoryId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LocationMemoriesTableUpdateCompanionBuilder =
    LocationMemoriesCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<String> name,
      Value<String?> region,
      Value<String?> state,
      Value<String?> notes,
      Value<String?> memoryId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocationMemoriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocationMemoriesTable> {
  $$LocationMemoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationMemoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationMemoriesTable> {
  $$LocationMemoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationMemoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationMemoriesTable> {
  $$LocationMemoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get memoryId =>
      $composableBuilder(column: $table.memoryId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocationMemoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationMemoriesTable,
          LocationMemory,
          $$LocationMemoriesTableFilterComposer,
          $$LocationMemoriesTableOrderingComposer,
          $$LocationMemoriesTableAnnotationComposer,
          $$LocationMemoriesTableCreateCompanionBuilder,
          $$LocationMemoriesTableUpdateCompanionBuilder,
          (
            LocationMemory,
            BaseReferences<
              _$AppDatabase,
              $LocationMemoriesTable,
              LocationMemory
            >,
          ),
          LocationMemory,
          PrefetchHooks Function()
        > {
  $$LocationMemoriesTableTableManager(
    _$AppDatabase db,
    $LocationMemoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationMemoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationMemoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationMemoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> memoryId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationMemoriesCompanion(
                id: id,
                patientId: patientId,
                name: name,
                region: region,
                state: state,
                notes: notes,
                memoryId: memoryId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required String name,
                Value<String?> region = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> memoryId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LocationMemoriesCompanion.insert(
                id: id,
                patientId: patientId,
                name: name,
                region: region,
                state: state,
                notes: notes,
                memoryId: memoryId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocationMemoriesTable, LocationMemory>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LocationMemoriesTable,
                    LocationMemory
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationMemoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationMemoriesTable,
      LocationMemory,
      $$LocationMemoriesTableFilterComposer,
      $$LocationMemoriesTableOrderingComposer,
      $$LocationMemoriesTableAnnotationComposer,
      $$LocationMemoriesTableCreateCompanionBuilder,
      $$LocationMemoriesTableUpdateCompanionBuilder,
      (
        LocationMemory,
        BaseReferences<_$AppDatabase, $LocationMemoriesTable, LocationMemory>,
      ),
      LocationMemory,
      PrefetchHooks Function()
    >;
typedef $$DailyUnlocksTableCreateCompanionBuilder =
    DailyUnlocksCompanion Function({
      required String patientId,
      required String forDate,
      Value<int> completions,
      Value<String?> memoryId,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });
typedef $$DailyUnlocksTableUpdateCompanionBuilder =
    DailyUnlocksCompanion Function({
      Value<String> patientId,
      Value<String> forDate,
      Value<int> completions,
      Value<String?> memoryId,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });

class $$DailyUnlocksTableFilterComposer
    extends Composer<_$AppDatabase, $DailyUnlocksTable> {
  $$DailyUnlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get forDate => $composableBuilder(
    column: $table.forDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completions => $composableBuilder(
    column: $table.completions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyUnlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyUnlocksTable> {
  $$DailyUnlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get forDate => $composableBuilder(
    column: $table.forDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completions => $composableBuilder(
    column: $table.completions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memoryId => $composableBuilder(
    column: $table.memoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyUnlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyUnlocksTable> {
  $$DailyUnlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<String> get forDate =>
      $composableBuilder(column: $table.forDate, builder: (column) => column);

  GeneratedColumn<int> get completions => $composableBuilder(
    column: $table.completions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memoryId =>
      $composableBuilder(column: $table.memoryId, builder: (column) => column);

  GeneratedColumn<bool> get unlocked =>
      $composableBuilder(column: $table.unlocked, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$DailyUnlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyUnlocksTable,
          DailyUnlock,
          $$DailyUnlocksTableFilterComposer,
          $$DailyUnlocksTableOrderingComposer,
          $$DailyUnlocksTableAnnotationComposer,
          $$DailyUnlocksTableCreateCompanionBuilder,
          $$DailyUnlocksTableUpdateCompanionBuilder,
          (
            DailyUnlock,
            BaseReferences<_$AppDatabase, $DailyUnlocksTable, DailyUnlock>,
          ),
          DailyUnlock,
          PrefetchHooks Function()
        > {
  $$DailyUnlocksTableTableManager(_$AppDatabase db, $DailyUnlocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyUnlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyUnlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyUnlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> patientId = const Value.absent(),
                Value<String> forDate = const Value.absent(),
                Value<int> completions = const Value.absent(),
                Value<String?> memoryId = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyUnlocksCompanion(
                patientId: patientId,
                forDate: forDate,
                completions: completions,
                memoryId: memoryId,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String patientId,
                required String forDate,
                Value<int> completions = const Value.absent(),
                Value<String?> memoryId = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyUnlocksCompanion.insert(
                patientId: patientId,
                forDate: forDate,
                completions: completions,
                memoryId: memoryId,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyUnlocksTable, DailyUnlock>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyUnlocksTable,
                    DailyUnlock
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyUnlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyUnlocksTable,
      DailyUnlock,
      $$DailyUnlocksTableFilterComposer,
      $$DailyUnlocksTableOrderingComposer,
      $$DailyUnlocksTableAnnotationComposer,
      $$DailyUnlocksTableCreateCompanionBuilder,
      $$DailyUnlocksTableUpdateCompanionBuilder,
      (
        DailyUnlock,
        BaseReferences<_$AppDatabase, $DailyUnlocksTable, DailyUnlock>,
      ),
      DailyUnlock,
      PrefetchHooks Function()
    >;
typedef $$CognitiveAssessmentsTableCreateCompanionBuilder =
    CognitiveAssessmentsCompanion Function({
      required String id,
      required String patientId,
      required int score,
      required int maxScore,
      required String answersJson,
      required String statusKey,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CognitiveAssessmentsTableUpdateCompanionBuilder =
    CognitiveAssessmentsCompanion Function({
      Value<String> id,
      Value<String> patientId,
      Value<int> score,
      Value<int> maxScore,
      Value<String> answersJson,
      Value<String> statusKey,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CognitiveAssessmentsTableFilterComposer
    extends Composer<_$AppDatabase, $CognitiveAssessmentsTable> {
  $$CognitiveAssessmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusKey => $composableBuilder(
    column: $table.statusKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CognitiveAssessmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CognitiveAssessmentsTable> {
  $$CognitiveAssessmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxScore => $composableBuilder(
    column: $table.maxScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusKey => $composableBuilder(
    column: $table.statusKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CognitiveAssessmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CognitiveAssessmentsTable> {
  $$CognitiveAssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusKey =>
      $composableBuilder(column: $table.statusKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CognitiveAssessmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CognitiveAssessmentsTable,
          CognitiveAssessment,
          $$CognitiveAssessmentsTableFilterComposer,
          $$CognitiveAssessmentsTableOrderingComposer,
          $$CognitiveAssessmentsTableAnnotationComposer,
          $$CognitiveAssessmentsTableCreateCompanionBuilder,
          $$CognitiveAssessmentsTableUpdateCompanionBuilder,
          (
            CognitiveAssessment,
            BaseReferences<
              _$AppDatabase,
              $CognitiveAssessmentsTable,
              CognitiveAssessment
            >,
          ),
          CognitiveAssessment,
          PrefetchHooks Function()
        > {
  $$CognitiveAssessmentsTableTableManager(
    _$AppDatabase db,
    $CognitiveAssessmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CognitiveAssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CognitiveAssessmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CognitiveAssessmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> maxScore = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<String> statusKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CognitiveAssessmentsCompanion(
                id: id,
                patientId: patientId,
                score: score,
                maxScore: maxScore,
                answersJson: answersJson,
                statusKey: statusKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                required int score,
                required int maxScore,
                required String answersJson,
                required String statusKey,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CognitiveAssessmentsCompanion.insert(
                id: id,
                patientId: patientId,
                score: score,
                maxScore: maxScore,
                answersJson: answersJson,
                statusKey: statusKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CognitiveAssessmentsTable, CognitiveAssessment>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $CognitiveAssessmentsTable,
                    CognitiveAssessment
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CognitiveAssessmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CognitiveAssessmentsTable,
      CognitiveAssessment,
      $$CognitiveAssessmentsTableFilterComposer,
      $$CognitiveAssessmentsTableOrderingComposer,
      $$CognitiveAssessmentsTableAnnotationComposer,
      $$CognitiveAssessmentsTableCreateCompanionBuilder,
      $$CognitiveAssessmentsTableUpdateCompanionBuilder,
      (
        CognitiveAssessment,
        BaseReferences<
          _$AppDatabase,
          $CognitiveAssessmentsTable,
          CognitiveAssessment
        >,
      ),
      CognitiveAssessment,
      PrefetchHooks Function()
    >;
typedef $$DailyNotesTableCreateCompanionBuilder = DailyNotesCompanion Function({
  required String id,
  required String patientId,
  Value<NoteKind> kind,
  required String body,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$DailyNotesTableUpdateCompanionBuilder = DailyNotesCompanion Function({
  Value<String> id,
  Value<String> patientId,
  Value<NoteKind> kind,
  Value<String> body,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DailyNotesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyNotesTable> {
  $$DailyNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NoteKind, NoteKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyNotesTable> {
  $$DailyNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patientId => $composableBuilder(
    column: $table.patientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyNotesTable> {
  $$DailyNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get patientId =>
      $composableBuilder(column: $table.patientId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NoteKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailyNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyNotesTable,
          DailyNote,
          $$DailyNotesTableFilterComposer,
          $$DailyNotesTableOrderingComposer,
          $$DailyNotesTableAnnotationComposer,
          $$DailyNotesTableCreateCompanionBuilder,
          $$DailyNotesTableUpdateCompanionBuilder,
          (
            DailyNote,
            BaseReferences<_$AppDatabase, $DailyNotesTable, DailyNote>,
          ),
          DailyNote,
          PrefetchHooks Function()
        > {
  $$DailyNotesTableTableManager(_$AppDatabase db, $DailyNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> patientId = const Value.absent(),
                Value<NoteKind> kind = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyNotesCompanion(
                id: id,
                patientId: patientId,
                kind: kind,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String patientId,
                Value<NoteKind> kind = const Value.absent(),
                required String body,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyNotesCompanion.insert(
                id: id,
                patientId: patientId,
                kind: kind,
                body: body,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyNotesTable, DailyNote>(table),
                  BaseReferences<_$AppDatabase, $DailyNotesTable, DailyNote>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyNotesTable,
      DailyNote,
      $$DailyNotesTableFilterComposer,
      $$DailyNotesTableOrderingComposer,
      $$DailyNotesTableAnnotationComposer,
      $$DailyNotesTableCreateCompanionBuilder,
      $$DailyNotesTableUpdateCompanionBuilder,
      (DailyNote, BaseReferences<_$AppDatabase, $DailyNotesTable, DailyNote>),
      DailyNote,
      PrefetchHooks Function()
    >;
typedef $$CaregiverSettingsTableCreateCompanionBuilder =
    CaregiverSettingsCompanion Function({
      required String id,
      Value<int> fontStep,
      Value<bool> highContrast,
      Value<bool> reminders,
      Value<bool> weeklyReports,
      Value<bool> sosAlerts,
      Value<int> rowid,
    });
typedef $$CaregiverSettingsTableUpdateCompanionBuilder =
    CaregiverSettingsCompanion Function({
      Value<String> id,
      Value<int> fontStep,
      Value<bool> highContrast,
      Value<bool> reminders,
      Value<bool> weeklyReports,
      Value<bool> sosAlerts,
      Value<int> rowid,
    });

class $$CaregiverSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $CaregiverSettingsTable> {
  $$CaregiverSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fontStep => $composableBuilder(
    column: $table.fontStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get highContrast => $composableBuilder(
    column: $table.highContrast,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminders => $composableBuilder(
    column: $table.reminders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get weeklyReports => $composableBuilder(
    column: $table.weeklyReports,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sosAlerts => $composableBuilder(
    column: $table.sosAlerts,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CaregiverSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $CaregiverSettingsTable> {
  $$CaregiverSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fontStep => $composableBuilder(
    column: $table.fontStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get highContrast => $composableBuilder(
    column: $table.highContrast,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminders => $composableBuilder(
    column: $table.reminders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get weeklyReports => $composableBuilder(
    column: $table.weeklyReports,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sosAlerts => $composableBuilder(
    column: $table.sosAlerts,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CaregiverSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CaregiverSettingsTable> {
  $$CaregiverSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fontStep =>
      $composableBuilder(column: $table.fontStep, builder: (column) => column);

  GeneratedColumn<bool> get highContrast => $composableBuilder(
    column: $table.highContrast,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminders =>
      $composableBuilder(column: $table.reminders, builder: (column) => column);

  GeneratedColumn<bool> get weeklyReports => $composableBuilder(
    column: $table.weeklyReports,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get sosAlerts =>
      $composableBuilder(column: $table.sosAlerts, builder: (column) => column);
}

class $$CaregiverSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CaregiverSettingsTable,
          CaregiverSetting,
          $$CaregiverSettingsTableFilterComposer,
          $$CaregiverSettingsTableOrderingComposer,
          $$CaregiverSettingsTableAnnotationComposer,
          $$CaregiverSettingsTableCreateCompanionBuilder,
          $$CaregiverSettingsTableUpdateCompanionBuilder,
          (
            CaregiverSetting,
            BaseReferences<
              _$AppDatabase,
              $CaregiverSettingsTable,
              CaregiverSetting
            >,
          ),
          CaregiverSetting,
          PrefetchHooks Function()
        > {
  $$CaregiverSettingsTableTableManager(
    _$AppDatabase db,
    $CaregiverSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CaregiverSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CaregiverSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CaregiverSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> fontStep = const Value.absent(),
                Value<bool> highContrast = const Value.absent(),
                Value<bool> reminders = const Value.absent(),
                Value<bool> weeklyReports = const Value.absent(),
                Value<bool> sosAlerts = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaregiverSettingsCompanion(
                id: id,
                fontStep: fontStep,
                highContrast: highContrast,
                reminders: reminders,
                weeklyReports: weeklyReports,
                sosAlerts: sosAlerts,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> fontStep = const Value.absent(),
                Value<bool> highContrast = const Value.absent(),
                Value<bool> reminders = const Value.absent(),
                Value<bool> weeklyReports = const Value.absent(),
                Value<bool> sosAlerts = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CaregiverSettingsCompanion.insert(
                id: id,
                fontStep: fontStep,
                highContrast: highContrast,
                reminders: reminders,
                weeklyReports: weeklyReports,
                sosAlerts: sosAlerts,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CaregiverSettingsTable, CaregiverSetting>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CaregiverSettingsTable,
                    CaregiverSetting
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CaregiverSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CaregiverSettingsTable,
      CaregiverSetting,
      $$CaregiverSettingsTableFilterComposer,
      $$CaregiverSettingsTableOrderingComposer,
      $$CaregiverSettingsTableAnnotationComposer,
      $$CaregiverSettingsTableCreateCompanionBuilder,
      $$CaregiverSettingsTableUpdateCompanionBuilder,
      (
        CaregiverSetting,
        BaseReferences<
          _$AppDatabase,
          $CaregiverSettingsTable,
          CaregiverSetting
        >,
      ),
      CaregiverSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PatientProfilesTableTableManager get patientProfiles =>
      $$PatientProfilesTableTableManager(_db, _db.patientProfiles);
  $$CaregiverLinksTableTableManager get caregiverLinks =>
      $$CaregiverLinksTableTableManager(_db, _db.caregiverLinks);
  $$EmergencyContactsTableTableManager get emergencyContacts =>
      $$EmergencyContactsTableTableManager(_db, _db.emergencyContacts);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$DailyActivitiesTableTableManager get dailyActivities =>
      $$DailyActivitiesTableTableManager(_db, _db.dailyActivities);
  $$ActivityAttemptsTableTableManager get activityAttempts =>
      $$ActivityAttemptsTableTableManager(_db, _db.activityAttempts);
  $$MemoriesTableTableManager get memories =>
      $$MemoriesTableTableManager(_db, _db.memories);
  $$GardensTableTableManager get gardens =>
      $$GardensTableTableManager(_db, _db.gardens);
  $$GardenElementsTableTableManager get gardenElements =>
      $$GardenElementsTableTableManager(_db, _db.gardenElements);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
  $$SosIncidentsTableTableManager get sosIncidents =>
      $$SosIncidentsTableTableManager(_db, _db.sosIncidents);
  $$SosContactAttemptsTableTableManager get sosContactAttempts =>
      $$SosContactAttemptsTableTableManager(_db, _db.sosContactAttempts);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$AdaptiveProfilesTableTableManager get adaptiveProfiles =>
      $$AdaptiveProfilesTableTableManager(_db, _db.adaptiveProfiles);
  $$LocationMemoriesTableTableManager get locationMemories =>
      $$LocationMemoriesTableTableManager(_db, _db.locationMemories);
  $$DailyUnlocksTableTableManager get dailyUnlocks =>
      $$DailyUnlocksTableTableManager(_db, _db.dailyUnlocks);
  $$CognitiveAssessmentsTableTableManager get cognitiveAssessments =>
      $$CognitiveAssessmentsTableTableManager(_db, _db.cognitiveAssessments);
  $$DailyNotesTableTableManager get dailyNotes =>
      $$DailyNotesTableTableManager(_db, _db.dailyNotes);
  $$CaregiverSettingsTableTableManager get caregiverSettings =>
      $$CaregiverSettingsTableTableManager(_db, _db.caregiverSettings);
}
