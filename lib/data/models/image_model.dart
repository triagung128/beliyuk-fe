import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final int id;
  final ImageAttributes attributes;

  const ImageModel({
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

  @override
  List<Object> get props => [id, attributes];
}

class ImageAttributes extends Equatable {
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

  const ImageAttributes({
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

  @override
  List<Object?> get props => [
        name,
        alternativeText,
        caption,
        width,
        height,
        formats,
        hash,
        ext,
        mime,
        size,
        url,
        previewUrl,
        provider,
        providerMetadata,
        createdAt,
        updatedAt,
      ];
}

class Formats extends Equatable {
  final Format thumbnail;
  final Format? small;
  final Format? medium;
  final Format? large;

  const Formats({
    required this.thumbnail,
    this.small,
    this.medium,
    this.large,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Format.fromJson(json['thumbnail']),
        small: json['small'] == null ? null : Format.fromJson(json['small']),
        medium: json['medium'] == null ? null : Format.fromJson(json['medium']),
        large: json['large'] == null ? null : Format.fromJson(json['large']),
      );

  Map<String, dynamic> toJson() => {
        'thumbnail': thumbnail.toJson(),
        'small': small?.toJson(),
        'medium': medium?.toJson(),
        'large': large?.toJson(),
      };

  @override
  List<Object?> get props => [
        thumbnail,
        small,
        medium,
        large,
      ];
}

class Format extends Equatable {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final String? path;
  final int width;
  final int height;
  final double size;
  final String url;

  const Format({
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

  @override
  List<Object?> get props => [
        name,
        hash,
        ext,
        mime,
        path,
        width,
        height,
        size,
        url,
      ];
}
