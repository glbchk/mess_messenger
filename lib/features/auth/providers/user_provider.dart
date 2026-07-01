// final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
//   final firestore = ref.read(firestoreProvider);
//   return UserRemoteDataSource(firestore);
// });
//
// final userRepositoryProvider = Provider<UserRepository>((ref) {
//   final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
//   final userRemoteDataSource = ref.read(userRemoteDataSourceProvider);
//   return UserRepositoryImpl(authRemoteDataSource, userRemoteDataSource);
// });

// final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
//   final userRepo = ref.read(userRepositoryProvider);
//   return CreateUserUseCase(userRepo);
// });
