// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepo _$$_GithubRepoFromJson(Map<String, dynamic> json) =>
    _$_GithubRepo(
      owner: User.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      starsCount: json['stargazers_count'] as int,
    );

Map<String, dynamic> _$$_GithubRepoToJson(_$_GithubRepo instance) =>
    <String, dynamic>{
      'owner': instance.owner.toJson(),
      'name': instance.name,
      'description': instance.description,
      'stargazers_count': instance.starsCount,
    };
