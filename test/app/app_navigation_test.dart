import 'package:flutter_test/flutter_test.dart';

import 'package:fashion_app/app/app.dart';
import 'package:fashion_app/utils/fake_data.dart';

void main() {
  testWidgets('navigates from the catalog to a product and back', (
    tester,
  ) async {
    await tester.pumpWidget(const FashionApp());

    final firstProduct = fakeProducts.first;
    await tester.tap(find.text(firstProduct.name).first);
    await tester.pumpAndSettle();

    expect(find.text(firstProduct.description), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text(firstProduct.description), findsNothing);
    expect(find.text('Fashion App'), findsOneWidget);
  });
}
