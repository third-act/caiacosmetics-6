import '../models/models.dart';

class ProductCatalog {
  ProductCatalog._();

  static final products = <Product>[
    const Product(
      id: 'c6-cica-care-serum',
      name: 'Cica Care Serum',
      category: 'Serum',
      priceNok: 295,
      imageAsset: 'assets/products/c6-cica-care-serum.png',
      description:
          'Gelserum beriket med cica, ginseng og aktive ingredienser som tilfører fuktighet, beroliger og beskytter huden.',
      concerns: [SkinConcern.redness, SkinConcern.barrier, SkinConcern.hydration],
      howToUse:
          'Påfør Cica Care serum hver morgen og kveld på ansikt og hals. Påføres på renset hud før ansiktskrem.',
      ingredients:
          'AQUA, GLYCERIN, PROPANEDIOL, NIACINAMIDE, CENTELLA ASIATICA EXTRACT, PANAX GINSENG ROOT EXTRACT',
    ),
    const Product(
      id: 'c6-soothing-serum',
      name: 'Soothing Serum',
      category: 'Serum',
      priceNok: 295,
      imageAsset: 'assets/products/c6-soothing-serum.png',
      description:
          'Et beroligende serum utviklet for tørr og sensitiv hud med hyaluronsyre og fuktighetsgivende ingredienser.',
      concerns: [SkinConcern.hydration, SkinConcern.redness, SkinConcern.barrier],
      howToUse:
          'Påfør etter toner. Klapp forsiktig inn i ansikt og hals før ansiktskrem.',
      ingredients:
          'AQUA, PROPANEDIOL, GLYCERIN, HYALURONIC ACID, SACCHARIDE ISOMERATE, BISABOLOL',
    ),
    const Product(
      id: 'c6-glow-up-serum',
      name: 'Glow Up Serum',
      category: 'Serum',
      priceNok: 295,
      imageAsset: 'assets/products/c6-glow-up-serum.png',
      description:
          'Et serum som lysner opp og gir glød, beriket med perler og fuktighetsgivende ingredienser.',
      concerns: [SkinConcern.glow, SkinConcern.hydration],
      howToUse:
          'Påfør etter toner. Klapp forsiktig inn i ansikt og hals før ansiktskrem.',
      ingredients:
          'AQUA, GLYCERIN, ASCORBYL GLUCOSIDE, PANTHENOL, SACCHARIDE ISOMERATE',
    ),
    const Product(
      id: 'c6-bha-exfoliate',
      name: 'BHA Exfoliate Face Serum',
      category: 'Serum',
      priceNok: 295,
      imageAsset: 'assets/products/c6-bha-exfoliate.png',
      description:
          'Serum som eksfolierer huden i dybden og reduserer ufullkommenheter og hudormer uten å tørke ut huden.',
      concerns: [SkinConcern.blemishes, SkinConcern.glow],
      howToUse:
          'Påfør om kvelden på renset hud. Start med maksimalt tre ganger i uken.',
      ingredients:
          'AQUA, LACTIC ACID, SALICYLIC ACID, CAMELLIA SINENSIS LEAF EXTRACT',
    ),
    const Product(
      id: 'c6-cicasence-essence',
      name: 'Cicasence Essence',
      category: 'Essens',
      priceNok: 345,
      imageAsset: 'assets/products/c6-cicasence-essence.png',
      description:
          'En 2-fase-essens med cica og ceramider som beroliger sensitiv hud og styrker hudbarrieren.',
      concerns: [SkinConcern.barrier, SkinConcern.hydration, SkinConcern.redness],
      howToUse: 'Rist flasken og påfør daglig før serum.',
      ingredients:
          'AQUA, GLYCERIN, CERAMIDE NP, ASIATIC ACID, MADECASSOSIDE, PANTHENOL',
    ),
    const Product(
      id: 'c6-hydrating-cream',
      name: 'Hydrating Face Cream',
      category: 'Ansiktskrem',
      priceNok: 325,
      imageAsset: 'assets/products/c6-hydrating-cream.png',
      description:
          'Fuktighetsgivende ansiktskrem som låser inn fukt og styrker hudbarrieren etter serum.',
      concerns: [SkinConcern.hydration, SkinConcern.barrier],
      howToUse: 'Påfør morgen og kveld som siste steg i hudpleierutinen.',
      ingredients: 'AQUA, GLYCERIN, SHEA BUTTER, SQUALANE, CERAMIDE NP',
    ),
    const Product(
      id: 'c6-gentle-cleanser',
      name: 'Gentle Cleanser',
      category: 'Rens',
      priceNok: 245,
      imageAsset: 'assets/products/c6-gentle-cleanser.png',
      description:
          'Mild rens som fjerner smuss og sminke uten å tørke ut huden — perfekt start på rutinen.',
      concerns: [SkinConcern.hydration, SkinConcern.redness],
      howToUse: 'Masser inn i fuktig hud morgen og kveld, skyll grundig.',
      ingredients: 'AQUA, GLYCERIN, COCO-GLUCOSIDE, PANTHENOL',
    ),
  ];

  static Product? byId(String id) {
    for (final product in products) {
      if (product.id == id) return product;
    }
    return null;
  }

  static List<Product> byIds(Iterable<String> ids) {
    return ids.map(byId).whereType<Product>().toList();
  }

  static List<Product> forConcerns(List<SkinConcern> concerns) {
    final scored = products.map((product) {
      final score = concerns
          .where((concern) => product.concerns.contains(concern))
          .length;
      return (product, score);
    }).toList()
      ..sort((a, b) => b.$2.compareTo(a.$2));
    return scored.map((entry) => entry.$1).toList();
  }
}
