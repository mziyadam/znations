import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:znations/data/model/nation.dart';
import 'package:znations/ui/custom_widget/nation_card.dart';
import 'package:znations/ui/home/home_view_model.dart';
import 'package:znations/utils/ad_helper.dart';

// TODO: Import google_mobile_ads.dart
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  bool isInit=true;

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: Add _bannerAd
  BannerAd? _bannerAd;

  @override
  void initState() {
    // TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Nation> nations = Provider.of<HomeViewModel>(context).nations;
    if (nations.isEmpty && widget.isInit) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        Provider.of<HomeViewModel>(context,listen: false).getData();
      });
      setState(() {
        widget.isInit=false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('znations'
            ,style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: RefreshIndicator(
            color: Colors.grey,
            onRefresh: _pullRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (nations.isEmpty&&widget.isInit)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                      // Text('loading')
                    ),
                  nations.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 64.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.emoji_symbols,
                                size: 64,
                              ),
                              Text(
                                "Empty",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: nations.length,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return NationCard(nation:nations[index]);
                          }),
                  const SizedBox(
                    height: 64.0,
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
              String mQuery =
                  Provider.of<HomeViewModel>(context, listen: false).mQuery;
              if (mQuery != '') controller.text = mQuery;
              return SearchBar(
                trailing: [
                  mQuery != ''
                      ? Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 30,
                          child: IconButton(
                              onPressed: () => {
                                    super.setState(() {
                                      Provider.of<HomeViewModel>(context,
                                              listen: false)
                                          .setMQuery('');
                                      Provider.of<HomeViewModel>(context,
                                          listen: false)
                                          .getData();
                                      controller.text = '';
                                    })
                                  },
                              icon: const Icon(Icons.cancel_outlined)),
                        )
                      : const SizedBox()
                ],
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
                onChanged: (t) {
                  // print(t);
                },
                onSubmitted: (t) async {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  Provider.of<HomeViewModel>(context, listen: false).search(t);
                  // setState(() {
                  //   nations = nationsSource
                  //       .where((i) => i.contains(t))
                  //       .toList();
                  // });
                  print(t);
                },
                leading: const Icon(Icons.search),
              );
            }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(0, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                );
              });
            }),
          ),
        ),
        // TODO: Display a banner when ready
        if (_bannerAd != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          ),
      ],
    ));
  }

  Future<void> _pullRefresh() async {
    print('pull referesh');
    Provider.of<HomeViewModel>(context, listen: false).refresh();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd?.dispose();
    super.dispose();
  }
}
