extension IntExtension on int {
  String formatting() {
    return this.toString().replaceAllMapped(
          new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
