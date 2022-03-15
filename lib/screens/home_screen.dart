part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messeges');

  final pages = const [
    MessegesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  final pageTitles = const ['Messeges', 'Notification', 'Calls', 'Contacts'];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
            child: IconBackground(icon: Icons.search, onTap: () {
              print('TODO search');
            }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Avatar.small(url: Helper.randomPictureUrl()),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
              index: 0,
              lable: 'Messeges',
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              isSelected: (selectedIndex == 0),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 1,
              lable: 'Notifications',
              icon: CupertinoIcons.bell_solid,
              isSelected: (selectedIndex == 1),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 2,
              lable: 'Calls',
              icon: CupertinoIcons.phone_fill,
              isSelected: (selectedIndex == 2),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 3,
              lable: 'Contacts',
              icon: CupertinoIcons.person_2_fill,
              isSelected: (selectedIndex == 3),
              onTap: handleItemSelected,
            ),
          ],
        ));
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.lable,
      required this.icon,
      required this.index,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
