class FacebookResponse {
  String? name;
  String? email;
  Picture? picture;
  String? id;

  FacebookResponse({this.name, this.email, this.picture, this.id});

  factory FacebookResponse.fromJson(Map<String, dynamic> json) {
    return FacebookResponse(
      name: json['name'],
      email: json['email'],
      picture: Picture.fromJson(json['picture']),
    );
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int? height;
  String? url;
  int? width;

  Data({this.height, this.url, this.width});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}
