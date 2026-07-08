// final authLocalRemoteDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
//   final firestore = ref.read(firestoreProvider);
//   return AuthLocalDataSource(firestore);
// });
//
// final authLocalRepositoryProvider = Provider<UserRepository>((ref) {
//   final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
//   final userRemoteDataSource = ref.read(userRemoteDataSourceProvider);
//   return UserRepositoryImpl(authRemoteDataSource, userRemoteDataSource);
// });
