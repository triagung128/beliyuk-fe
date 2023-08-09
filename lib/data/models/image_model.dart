class ImageModel {
  final int id;
  final ImageAttributes attributes;

  ImageModel({
    required this.id,
    required this.attributes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['id'],
        attributes: ImageAttributes.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };
}

class ImageAttributes {
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final Formats? formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final String? providerMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageAttributes({
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageAttributes.fromJson(Map<String, dynamic> json) =>
      ImageAttributes(
        name: json['name'],
        alternativeText: json['alternativeText'],
        caption: json['caption'],
        width: json['width'],
        height: json['height'],
        formats:
            json['formats'] == null ? null : Formats.fromJson(json['formats']),
        hash: json['hash'],
        ext: json['ext'],
        mime: json['mime'],
        size: json['size']?.toDouble(),
        url: json['url'],
        previewUrl: json['previewUrl'],
        provider: json['provider'],
        providerMetadata: json['provider_metadata'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'alternativeText': alternativeText,
        'caption': caption,
        'width': width,
        'height': height,
        'formats': formats?.toJson(),
        'hash': hash,
        'ext': ext,
        'mime': mime,
        'size': size,
        'url': url,
        'previewUrl': previewUrl,
        'provider': provider,
        'provider_metadata': providerMetadata,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

class Formats {
  final Format thumbnail;
  final Format? small;

  Formats({
    required this.thumbnail,
    this.small,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Format.fromJson(json['thumbnail']),
        small: json['small'] == null ? null : Format.fromJson(json['small']),
      );

  Map<String, dynamic> toJson() => {
        'thumbnail': thumbnail.toJson(),
        'small': small?.toJson(),
      };
}

class Format {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final dynamic path;
  final int width;
  final int height;
  final double size;
  final String url;

  Format({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    this.path,
    required this.width,
    required this.height,
    required this.size,
    required this.url,
  });

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        name: json['name'],
        hash: json['hash'],
        ext: json['ext'],
        mime: json['mime'],
        path: json['path'],
        width: json['width'],
        height: json['height'],
        size: json['size']?.toDouble(),
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'hash': hash,
        'ext': ext,
        'mime': mime,
        'path': path,
        'width': width,
        'height': height,
        'size': size,
        'url': url,
      };
}
