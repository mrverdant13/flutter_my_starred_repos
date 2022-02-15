import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart' hide Response;
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';

class MockGQLClient extends Mock implements GraphQLClient {}

class MockDio extends Mock implements Dio {}

class FakeQueryOptions extends Fake implements QueryOptions {}

void main() {
  group(
    '''

GIVEN a profile API
├─ THAT uses a GraphQL client
├─ AND uses a Dio client''',
    () {
      // ARRANGE
      late MockGQLClient gqlClient;
      late MockDio dio;
      late ProfileApi profileApi;

      setUpAll(
        () {
          registerFallbackValue(FakeQueryOptions());
        },
      );

      setUp(
        () {
          gqlClient = MockGQLClient();
          dio = MockDio();
          profileApi = ProfileApi(
            gqlClient: gqlClient,
            dio: dio,
          );
        },
      );

      tearDown(() {
        verifyNoMoreInteractions(gqlClient);
        verifyNoMoreInteractions(dio);
      });

      test(
        '''

WHEN the profile is requested
THEN the profile should be returned
├─ BY fetching the profile info with the GraphQL client
│  ├─ THAT does not include a user status
├─ AND returning the serialized profile
''',
        () async {
          // ARRANGE
          const profile = Profile(
            username: 'username',
            avatarUrl: 'avatarUrl',
          );
          final profileJson = profile.toJson();

          when(
            () => gqlClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              data: {'viewer': profileJson},
              parserFn: (json) => json,
            ),
          );

          // ACT
          final result = await profileApi.getProfile();

          // ASSERT
          expect(result, profile);
          final capuredQueryOptions = verify(
            () => gqlClient.query(
              captureAny(
                that: isA<QueryOptions>(),
              ),
            ),
          ).captured.single as QueryOptions;
          expect(capuredQueryOptions.document, getProfileDoc);
        },
      );

      test(
        '''

WHEN the profile is requested
THEN the profile should be returned
├─ BY fetching the profile info with the GraphQL client
│  ├─ THAT includes a user status
│  │  ├─ THAT does not include an emoji
│  │  ├─ AND includes a message
├─ AND returning the serialized profile
''',
        () async {
          // ARRANGE
          const profile = Profile(
            username: 'username',
            avatarUrl: 'avatarUrl',
            status: UserStatus(
              message: 'message',
            ),
          );
          final profileJson = profile.toJson();

          when(
            () => gqlClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              data: {'viewer': profileJson},
              parserFn: (json) => json,
            ),
          );

          // ACT
          final result = await profileApi.getProfile();

          // ASSERT
          expect(result, profile);
          final capuredQueryOptions = verify(
            () => gqlClient.query(
              captureAny(
                that: isA<QueryOptions>(),
              ),
            ),
          ).captured.single as QueryOptions;
          expect(capuredQueryOptions.document, getProfileDoc);
        },
      );

      test(
        '''

WHEN the profile is requested
THEN the profile should be returned
├─ BY fetching the profile info with the GraphQL client
│  ├─ THAT includes a user status
│  │  ├─ THAT includes an emoji code
│  │  ├─ AND includes a message
├─ AND fetching the actual emojy with the Dio client
├─ AND returning the serialized profile
''',
        () async {
          // ARRANGE
          const emojiCode = 'emoji-code';
          const actualEmoji = 'actual-emoji';
          const profile = Profile(
            username: 'username',
            avatarUrl: 'avatarUrl',
            status: UserStatus(
              emoji: emojiCode,
              message: 'message',
            ),
          );
          final profileJson = profile.toJson();
          final resultingProfile = profile.copyWith(
            status: profile.status?.copyWith(
              emoji: actualEmoji,
            ),
          );

          when(
            () => gqlClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              data: {'viewer': profileJson},
              parserFn: (json) => json,
            ),
          );
          when(
            () => dio.get(
              any(),
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: jsonEncode({emojiCode: actualEmoji}),
            ),
          );

          // ACT
          final result = await profileApi.getProfile();

          // ASSERT
          expect(result, resultingProfile);
          final capuredQueryOptions = verify(
            () => gqlClient.query(
              captureAny(
                that: isA<QueryOptions>(),
              ),
            ),
          ).captured.single as QueryOptions;
          expect(capuredQueryOptions.document, getProfileDoc);
          verify(() => dio.get(emojiEndpoint)).called(1);
        },
      );

      test(
        '''

AND network issues
WHEN the profile is requested
THEN an exception should be thrown
├─ BY trying to fetch the profile info with the GraphQL client
├─ AND throwing an exception identifying the issue
''',
        () async {
          // ARRANGE
          when(
            () => gqlClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              exception: OperationException(
                linkException: NetworkException(
                  uri: null,
                ),
              ),
              parserFn: (json) => json,
            ),
          );

          // ACT
          Future<void> action() async => profileApi.getProfile();

          // ASSERT
          expect(action, throwsA(const GetProfileException.offline()));
          final capuredQueryOptions = verify(
            () => gqlClient.query(
              captureAny(
                that: isA<QueryOptions>(),
              ),
            ),
          ).captured.single as QueryOptions;
          expect(capuredQueryOptions.document, getProfileDoc);
        },
      );

      test(
        '''

AND connection issues
WHEN the profile is requested
THEN an exception should be thrown
├─ BY trying to fetch the profile info with the GraphQL client
├─ AND throwing an exception identifying the issue
''',
        () async {
          // ARRANGE
          when(
            () => gqlClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              exception: OperationException(
                linkException: const ServerException(
                  originalException: SocketException(''),
                ),
              ),
              parserFn: (json) => json,
            ),
          );

          // ACT
          Future<void> action() async => profileApi.getProfile();

          // ASSERT
          expect(action, throwsA(const GetProfileException.offline()));
          final capuredQueryOptions = verify(
            () => gqlClient.query(
              captureAny(
                that: isA<QueryOptions>(),
              ),
            ),
          ).captured.single as QueryOptions;
          expect(capuredQueryOptions.document, getProfileDoc);
        },
      );
    },
  );
}
