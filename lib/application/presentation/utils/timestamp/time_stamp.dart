
String timeAgo(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inDays > 365) {
    return '${(difference.inDays / 365).floor()} y ago';
  } else if (difference.inDays > 30) {
    return '${(difference.inDays / 30).floor()} m ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} m ago';
  } else if (difference.inSeconds > 0) {
    return '${difference.inMinutes} s ago';
  } else {
    return 'just now';
  }
}


// String timeAgo(DateTime timestamp) {
//   final now = DateTime.now();
//   final difference = now.difference(timestamp);

//   if (difference.inDays > 365) {
//     return '${(difference.inDays / 365).floor()} years ago';
//   } else if (difference.inDays > 30) {
//     return '${(difference.inDays / 30).floor()} months ago';
//   } else if (difference.inDays > 0) {
//     return '${difference.inDays} days ago';
//   } else if (difference.inHours > 0) {
//     return '${difference.inHours} hours ago';
//   } else if (difference.inMinutes > 0) {
//     return '${difference.inMinutes} minutes ago';
//   } else if (difference.inSeconds > 0) {
//     return '${difference.inMinutes} seconds ago';
//   } else {
//     return 'just now';
//   }
// }