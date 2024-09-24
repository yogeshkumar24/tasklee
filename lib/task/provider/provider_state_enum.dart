enum ProviderState {
  ideal,
  loading,
  error;

  bool isLoading() {
    return this == ProviderState.loading;
  }

  bool isIdeal() {
    return this == ProviderState.ideal;
  }

  bool isError() {
    return this == ProviderState.error;
  }
}
