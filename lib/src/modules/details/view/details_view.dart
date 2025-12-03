import 'package:flutter/material.dart';
import 'package:smart_mobile/src/data/repository/models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  final Function() onFavorite;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onFavorite,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<String> get allImages {
    return [widget.product.thumbnail];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.product.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
            ),
            onPressed: onFav,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: allImages.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  final image = allImages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: Colors.grey.shade200,
                              alignment: Alignment.center,
                              child: const Icon(Icons.broken_image_outlined),
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Text(
              widget.product.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'R\$ ${widget.product.price.toStringAsFixed(2)}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Descrição',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.product.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFav() async {
    widget.onFavorite();

    widget.product.isFavorite = !widget.product.isFavorite;
    setState(() {});
  }
}
