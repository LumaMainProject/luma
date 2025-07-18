import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/seller_bloc/seller_account_bloc.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_seller_item_card_statistic.dart';

class PageSellerHomepageHome extends StatelessWidget {
  const PageSellerHomepageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAccountBloc, SellerAccountState>(
      builder: (context, state) {
        if (state is! SellerAccountLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<FlSpot> spotsA = [
          FlSpot(1, 0),
          FlSpot(2, 14),
          FlSpot(3, 21),
          FlSpot(4, 27),
          FlSpot(5, 12),
          FlSpot(6, 17),
          FlSpot(7, 14),
        ];

        final List<FlSpot> spotsB = [
          FlSpot(1, 0),
          FlSpot(2, 6),
          FlSpot(3, 11),
          FlSpot(4, 17),
          FlSpot(5, 14),
          FlSpot(6, 21),
          FlSpot(7, 26),
        ];

        final List<FlSpot> spotsC = [
          FlSpot(1, 0),
          FlSpot(2, 27),
          FlSpot(3, 17),
          FlSpot(4, 14),
          FlSpot(5, 14),
          FlSpot(6, 12),
          FlSpot(7, 24),
        ];

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Top Statistic", style: AppTextStyles.title),
              ),
            ),

            // SliverToBoxAdapter(
            //   child: LinesGraph(spotsA: spotsA, spotsB: spotsB, spotsC: spotsC),
            // ),

            // SliverToBoxAdapter(
            //   child: PieGraph(),
            // ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  LinesGraph(spotsA: spotsA, spotsB: spotsB, spotsC: spotsC),
                  PieGraph(),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: Size(0, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  child: Text("BOOST", style: AppTextStyles.title),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Top Seller Item", style: AppTextStyles.title),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: WidgetSellerItemCardStatistic(
                    item: state.items[index],
                  ),
                );
              },
              itemCount: state.items.length,
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Top Store", style: AppTextStyles.title),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: WidgetSellerItemCardStatistic(
                    item: state.items[index],
                  ),
                );
              },
              itemCount: state.items.length,
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("Statistic", style: AppTextStyles.title),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: WidgetSellerItemCardStatistic(
                    item: state.items[index],
                  ),
                );
              },
              itemCount: state.items.length,
            ),
          ],
        );
      },
    );
  }
}

class LinesGraph extends StatelessWidget {
  const LinesGraph({
    super.key,
    required this.spotsA,
    required this.spotsB,
    required this.spotsC,
  });

  final List<FlSpot> spotsA;
  final List<FlSpot> spotsB;
  final List<FlSpot> spotsC;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                color: Colors.blueAccent,
                isCurved: true,
                preventCurveOverShooting: true,
                spots: spotsA,
              ),
        
              LineChartBarData(
                color: Colors.purpleAccent,
                isCurved: true,
                preventCurveOverShooting: true,
                spots: spotsB,
              ),
        
              LineChartBarData(
                color: Colors.orangeAccent,
                isCurved: true,
                preventCurveOverShooting: true,
                spots: spotsC,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieGraph extends StatelessWidget {
  const PieGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 15,
                radius: 40,
                color: Colors.orangeAccent,
              ),
              PieChartSectionData(
                value: 25,
                radius: 50,
                color: Colors.purpleAccent,
              ),
              PieChartSectionData(
                value: 60,
                radius: 60,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
