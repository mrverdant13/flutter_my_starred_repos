import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    Key? key,
    required this.url,
    this.assetPlaceholder,
  }) : super(key: key);

  final String url;
  final String? assetPlaceholder;

  @override
  Widget build(BuildContext context) {
    final maybeUri = Uri.tryParse(url);
    final isValidUrl = maybeUri?.isAbsolute ?? false;
    if (isValidUrl) {
      return assetPlaceholder != null
          ? FadeInImage(
              placeholder: AssetImage(assetPlaceholder!),
              image: CachedNetworkImageProvider(url),
              imageErrorBuilder: _errorBuilder,
              fit: BoxFit.cover,
            )
          : Image(
              image: CachedNetworkImageProvider(url),
              errorBuilder: _errorBuilder,
              fit: BoxFit.cover,
            );
    } else {
      return _Placeholder(assetPlaceholder: assetPlaceholder);
    }
  }

  Widget _errorBuilder(BuildContext context, Object? e, StackTrace? s) =>
      _Placeholder(assetPlaceholder: assetPlaceholder);
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    Key? key,
    required this.assetPlaceholder,
  }) : super(key: key);

  final String? assetPlaceholder;

  @override
  Widget build(BuildContext context) => assetPlaceholder != null
      ? Image.asset(assetPlaceholder!)
      : const SizedBox.shrink();
}
