import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BuyerHomepageScreenPlayer extends StatefulWidget {
  const BuyerHomepageScreenPlayer({super.key});

  @override
  State<BuyerHomepageScreenPlayer> createState() =>
      _BuyerHomepageScreenPlayerState();
}

class _BuyerHomepageScreenPlayerState extends State<BuyerHomepageScreenPlayer> {
  final List<String> videoAssets = [
    "assets/videos/1.mp4",
    "assets/videos/2.mp4",
    "assets/videos/3.mp4",
    "assets/videos/4.mp4",
    "assets/videos/5.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: videoAssets.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(
            assetPath: videoAssets[index],
            overlayUI: _buildOverlayUI(),
          );
        },
      ),
    );
  }

  Widget _buildOverlayUI() {
    return SafeArea(
      child: Stack(
        children: [
          // Верхний бар с названием
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 92,
              height: 42,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(125),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Center(
                child: Text(
                  "LUMA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      
          // Правая колонка кнопок
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButtonWithLabel(
                  icon: Icons.favorite_outline,
                  label: "Избранное",
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildButtonWithLabel(
                  icon: Icons.share_outlined,
                  label: "Поделиться",
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                _buildButtonWithLabel(
                  icon: Icons.shopping_cart_outlined,
                  label: "В корзину",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithLabel({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.black, size: 20),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String assetPath;
  final Widget? overlayUI; // сюда можно добавлять кастомный UI

  const VideoPlayerItem({super.key, required this.assetPath, this.overlayUI});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_controller.value.isInitialized) return;
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.assetPath),
      onVisibilityChanged: (info) {
        if (!_controller.value.isInitialized || !mounted) return;
        if (info.visibleFraction == 0) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Видео
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // Полноэкранный GestureDetector поверх видео для Play/Pause
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _togglePlayPause,
              child: const SizedBox.shrink(),
            ),
          ),

          // Play/Pause иконка по центру
          if (!_controller.value.isPlaying)
            const Icon(Icons.play_arrow, size: 80, color: Colors.white70),

          // Кастомный UI поверх видео
          if (widget.overlayUI != null) widget.overlayUI!,
        ],
      ),
    );
  }
}
