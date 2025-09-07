import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:inetagan/common/routes.dart';
import 'package:inetagan/core/config/app_colors.dart';
import 'package:inetagan/core/config/app_format.dart';
import 'package:inetagan/core/config/app_session.dart';
import 'package:inetagan/core/components/button_widget.dart';
import 'package:inetagan/core/components/loading_widget.dart';
import 'package:inetagan/features/signin/data/models/sign_in_model.dart';
import 'package:inetagan/features/subscribe/domain/entities/subscribe_entity.dart';
import 'package:inetagan/features/subscribe/presentation/bloc/get_subscription/get_subscription_bloc.dart';
import 'package:inetagan/features/subscribe/presentation/widgets/detail_item_widget.dart';
import 'package:inetagan/gen/assets.gen.dart';

class GetSubscribePage extends StatefulWidget {
  const GetSubscribePage({super.key});

  @override
  State<GetSubscribePage> createState() => _GetSubscribePageState();
}

class _GetSubscribePageState extends State<GetSubscribePage> {
  SubscribeEntity? subscribe;
  SignInModel? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserAndSubscription();
  }

  Future<void> _loadUserAndSubscription() async {
    final user = await AppSession.getUser();
    if (!mounted) return;
    setState(() {
      currentUser = user;
    });
    if (user != null) {
      context.read<GetSubscriptionBloc>().add(OnGetSubscriptionEvent(user.id));
    }
  }

  Future<void> refresh() async {
    if (currentUser != null) {
      context.read<GetSubscriptionBloc>().add(
        OnGetSubscriptionEvent(currentUser!.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async => refresh(),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Gap(20 + MediaQuery.of(context).padding.top),
            buildHeader(),
            Gap(20),
            buildCard(),
          ],
        ),
      ),
    );
  }

  buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.goNamed(RouteNames.dashboard);
            },
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Assets.icons.arrowLeft.svg(height: 24, width: 24),
            ),
          ),
          Text(
            'Pemasangan Saya',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Assets.icons.ellipsisVertical.svg(height: 24, width: 24),
          ),
        ],
      ),
    );
  }

  buildCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: BlocBuilder<GetSubscriptionBloc, GetSubscriptionState>(
              builder: (context, state) {
                if (state is GetSubscriptionLoading) {
                  return LoadingWidget();
                }
                if (state is GetSubscriptionFailed) {
                  return Center(child: Text(state.message));
                }
                if (state is GetSubscriptionSuccess) {
                  final subscribe = state.data;
                  final package = state.data.internetPackage;
                  final price = package!.monthlyBill + package.installation;
                  return Column(
                    children: [
                      DetailItemWidget(
                        label: 'Nama',
                        itemDetail: subscribe.name,
                      ),
                      DetailItemWidget(label: 'NIK', itemDetail: subscribe.nik),
                      DetailItemWidget(
                        label: 'WhatsApp',
                        itemDetail: subscribe.phone,
                      ),
                      DetailItemWidget(
                        label: 'Alamat',
                        itemDetail: subscribe.address,
                      ),
                      DetailItemWidget(
                        label: 'Status pemaasangan',
                        itemDetail: subscribe.status,
                      ),
                      DetailItemWidget(
                        label: 'Tanggal Pengajuan',
                        itemDetail: AppFormat.justDate(subscribe.createdAt),
                      ),
                      DetailItemWidget(
                        label: 'Paket Internet',
                        itemDetail: package.name,
                      ),
                      DetailItemWidget(
                        label: 'Category',
                        itemDetail: package.category,
                      ),
                      DetailItemWidget(
                        label: 'Biaya Bulanan',
                        itemDetail: package.monthlyBill,
                      ),
                      DetailItemWidget(
                        label: 'Biaya Pemasangan',
                        itemDetail: package.installation,
                      ),
                      DetailItemWidget(label: 'Total Biaya', itemDetail: price),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          Gap(100),
          ButtonWidget(
            ontap: () {
              context.goNamed(RouteNames.dashboard);
            },
            text: 'Kembali',
          ),
        ],
      ),
    );
  }
}
