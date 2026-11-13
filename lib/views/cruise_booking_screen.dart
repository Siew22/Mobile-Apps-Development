import 'package:flutter/material.dart';
import '../viewmodels/cruise_booking_viewmodel.dart';
import 'widgets/header_image_widget.dart';
import 'widgets/title_section_widget.dart';
import 'widgets/action_bar_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/booking_controls_widget.dart';

class CruiseBookingScreen extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const CruiseBookingScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sibu River Cruise & Heritage'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitLayout()
              : _buildLandscapeLayout();
        },
      ),
    );
  }

  // Figure 1: Portrait Layout
  Widget _buildPortraitLayout() {
    return ListView(
      children: [
        HeaderImageWidget(
          imageUrl: viewModel.destination.imageUrl,
          landmarkLabel: viewModel.destination.landmarkLabel,
        ),
        TitleSectionWidget(viewModel: viewModel),
        const ActionBarWidget(),
        DescriptionWidget(text: viewModel.destination.description),
        BookingControlsWidget(viewModel: viewModel),
      ],
    );
  }

  // Figure 2: Landscape Layout (Left Pane: Image | Right Pane: Details)
  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: HeaderImageWidget(
            imageUrl: viewModel.destination.imageUrl,
            landmarkLabel: viewModel.destination.landmarkLabel,
            height: double.infinity,
          ),
        ),
        Expanded(
          flex: 1,
          child: ListView(
            children: [
              TitleSectionWidget(viewModel: viewModel),
              const ActionBarWidget(),
              DescriptionWidget(text: viewModel.destination.description),
              BookingControlsWidget(viewModel: viewModel),
            ],
          ),
        ),
      ],
    );
  }
}