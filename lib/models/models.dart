class User {
  final String name;
  final String gender;
  final String email;
  final String password;
  final int? id;

  User({
    required this.name,
    required this.gender,
    required this.email,
    required this.password,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'password': password,
    };
  }
}

class Song {
  final int? id;
  final String title;
  final String artist;
  final String album;
  final String image;
  final String songUrl;

  Song({
    required this.title,
    required this.artist,
    required this.album,
    required this.image,
    required this.songUrl,
    this.id,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as int,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
      image: json['image'] as String,
      songUrl: json['songPath'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'title': title,
        'artist': artist,
        'album': album,
        'image': image,
        'songUrl': songUrl,
      };
}

class Playlist {
  final int? id;
  final String name;
  final int user;
  final List<int> songs;

  Playlist({
    this.id,
    required this.name,
    required this.user,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    var list = json['songs'] as List;
    List<int> songsList = list.map((i) => i as int).toList();

    return Playlist(
      id: json['id'],
      name: json['name'],
      user: json['user'],
      songs: songsList,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': name,
        'user': user,
        'songs': songs,
      };
}
