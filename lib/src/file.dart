// ignore_for_file: public_member_api_docs, avoid_equals_and_hash_code_on_mutable_classes, avoid_slow_async_io

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Utility class for file helpers
class FileUtils {
  static String getExtensionFromMime(String mimeType) {
    switch (mimeType.toLowerCase()) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'image/gif':
        return 'gif';
      case 'application/pdf':
        return 'pdf';
      case 'text/plain':
        return 'txt';
      case 'application/json':
        return 'json';
      case 'application/zip':
        return 'zip';
      case 'video/mp4':
        return 'mp4';
      case 'audio/mpeg':
        return 'mp3';
      default:
        return 'bin';
    }
  }
}

/// Base class
class SynrgFile {
  SynrgFile({required this.url, required this.type});

  factory SynrgFile.fromMap(Map<String, dynamic> map) => SynrgFile(
        url: map['url'] as String? ?? '',
        type: map['type'] as String? ?? '',
      );

  final String url;
  final String type;

  File? _cached;

  Map<String, dynamic> toMap() => {'url': url, 'type': type};

  static Future<Map<String, String>> uploadFile(File file, String path) async {
    final type = lookupMimeType(file.path) ?? 'application/octet-stream';
    final ext = FileUtils.getExtensionFromMime(type);
    final name = '${const Uuid().v4()}.$ext';
    final ref = FirebaseStorage.instance.ref().child('$path/$name');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    return {'url': url, 'type': type};
  }

  static Future<SynrgFile> fromFile(File file, String path) async {
    final data = await uploadFile(file, path);
    return SynrgFile(url: data['url']!, type: data['type']!);
  }

  Future<File> get() async {
    if (_cached != null && await _cached!.exists()) return _cached!;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dir = await getTemporaryDirectory();
      final ext = FileUtils.getExtensionFromMime(type);
      final name = '${const Uuid().v4()}.$ext';
      final file = File('${dir.path}/$name');
      _cached = await file.writeAsBytes(response.bodyBytes);
      return _cached!;
    } else {
      throw Exception('Failed to download file');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SynrgFile &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          type == other.type;

  @override
  int get hashCode => url.hashCode ^ type.hashCode;
}

/// Image extension
class SynrgImage extends SynrgFile {
  SynrgImage({
    required super.url,
    required super.type,
    required this.width,
    required this.height,
  }) : aspectRatio = width != 0 ? width / height : 1;

  factory SynrgImage.fromMap(Map<String, dynamic> map) => SynrgImage(
        url: map['url'] as String? ?? '',
        type: map['type'] as String? ?? '',
        width: int.tryParse(map['width'].toString()) ?? 0,
        height: int.tryParse(map['height'].toString()) ?? 0,
      );

  final int width;
  final int height;
  final double aspectRatio;

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'width': width,
        'height': height,
        'aspectRatio': aspectRatio,
      };

  static Future<SynrgImage> fromFile(File file, String path) async {
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw Exception('Cannot decode image');
    final uploaded = await SynrgFile.uploadFile(file, path);
    return SynrgImage(
      url: uploaded['url']!,
      type: uploaded['type']!,
      width: decoded.width,
      height: decoded.height,
    );
  }

  Future<Image> getImage() async => Image.file(await get());
}

/// Document extension
class SynrgDocument extends SynrgFile {
  SynrgDocument({
    required super.url,
    required super.type,
    this.pageCount,
    this.title,
  });

  factory SynrgDocument.fromMap(Map<String, dynamic> map) => SynrgDocument(
        url: map['url'] as String? ?? '',
        type: map['type'] as String? ?? '',
        pageCount: map['pageCount'] != null
            ? int.tryParse(map['pageCount'].toString())
            : null,
        title: map['title']?.toString(),
      );

  final int? pageCount;
  final String? title;

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'pageCount': pageCount,
        'title': title,
      };

  static Future<SynrgDocument> fromFile(
    File file,
    String path, {
    int? pageCount,
    String? title,
  }) async {
    final uploaded = await SynrgFile.uploadFile(file, path);
    return SynrgDocument(
      url: uploaded['url']!,
      type: uploaded['type']!,
      pageCount: pageCount,
      title: title,
    );
  }
}

/// Audio extension
class SynrgAudio extends SynrgFile {
  SynrgAudio({
    required super.url,
    required super.type,
    required this.durationSeconds,
    this.artist,
    this.title,
  });

  factory SynrgAudio.fromMap(Map<String, dynamic> map) => SynrgAudio(
        url: map['url'] as String? ?? '',
        type: map['type'] as String? ?? '',
        durationSeconds: int.tryParse(map['durationSeconds'].toString()) ?? 0,
        artist: map['artist']?.toString(),
        title: map['title']?.toString(),
      );

  final int durationSeconds;
  final String? artist;
  final String? title;

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'durationSeconds': durationSeconds,
        'artist': artist,
        'title': title,
      };

  static Future<SynrgAudio> fromFile(
    File file,
    String path, {
    required int durationSeconds,
    String? artist,
    String? title,
  }) async {
    final uploaded = await SynrgFile.uploadFile(file, path);
    return SynrgAudio(
      url: uploaded['url']!,
      type: uploaded['type']!,
      durationSeconds: durationSeconds,
      artist: artist,
      title: title,
    );
  }
}

/// Video extension
class SynrgVideo extends SynrgFile {
  SynrgVideo({
    required super.url,
    required super.type,
    required this.durationSeconds,
    this.width,
    this.height,
    this.thumbnailUrl,
  });

  factory SynrgVideo.fromMap(Map<String, dynamic> map) => SynrgVideo(
        url: map['url'] as String? ?? '',
        type: map['type'] as String? ?? '',
        durationSeconds: int.tryParse(map['durationSeconds'].toString()) ?? 0,
        width:
            map['width'] != null ? int.tryParse(map['width'].toString()) : null,
        height: map['height'] != null
            ? int.tryParse(map['height'].toString())
            : null,
        thumbnailUrl: map['thumbnailUrl'] as String?,
      );

  final int durationSeconds;
  final int? width;
  final int? height;
  final String? thumbnailUrl;
  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        'durationSeconds': durationSeconds,
        'width': width,
        'height': height,
        'thumbnailUrl': thumbnailUrl,
      };

  static Future<SynrgVideo> fromFile(
    File file,
    String path, {
    required int durationSeconds,
    int? width,
    int? height,
    File? thumbnail,
  }) async {
    final uploaded = await SynrgFile.uploadFile(file, path);
    String? thumbnailUrl;

    if (thumbnail != null) {
      final type = lookupMimeType(thumbnail.path) ?? 'image/jpeg';
      final ext = FileUtils.getExtensionFromMime(type);
      final name = '${const Uuid().v4()}.$ext';
      final ref = FirebaseStorage.instance.ref().child('$path/$name');
      await ref.putFile(thumbnail);
      thumbnailUrl = await ref.getDownloadURL();
    }

    return SynrgVideo(
      url: uploaded['url']!,
      type: uploaded['type']!,
      durationSeconds: durationSeconds,
      width: width,
      height: height,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
