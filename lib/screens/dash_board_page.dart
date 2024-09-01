import 'package:flutter/material.dart';
import 'package:flutter_task/widgets/app_test.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> images_data = [
    'images/banners2.jpg',
    'images/banners2.jpg',
    'images/banners2.jpg',
    'images/banners2.jpg',
    // Add more image paths as needed
  ];
  final List<String> images_data3 = [
    'images/banners.jpg',
    'images/banners.jpg',
    'images/banners.jpg',
    'images/banners.jpg',
    // Add more image paths as needed
  ];
   final List<String> images_data2 = [
    'images/mobile.jpg',
    'images/laptop.png',
    'images/camera.jpg',
    'images/led.png',
    // Add more image paths as needed
  ];
  
       List<Color> backgroundColors = [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.orange,
        Colors.purple,
      ];

      List<String> labels = [
        'Mobile',
        'Laptop',
        'Camera',
        'LED',
        'Accessory',
      ];
      int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // Screen height and width
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            // Menu Icon
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Handle menu action
              },
            ),
            // Search Bar
            Expanded(
              child: Container(
               height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
            // Notification Icon
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification action
              },
            ),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0), // Optional padding
          child: Column(
            children: [
              Container(
                height: screenHeight/7,
                width: screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images_data.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth,
                      height: screenHeight*5.9,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(images_data[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height:10),
             Container(
               height: screenHeight / 6,
               width: screenWidth,
                decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
        ),
                 child: const Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                    ListTile(
                    title: Center(child: Text(AppStrings.kyc)),
                    subtitle: Center(child: Column(
                      children: [
                        Text(AppStrings.kyc_data),
                        Text(AppStrings.kyc_data2)
      
      
                      ],
                    )),
        ),
      
          Text('Click Here',style: TextStyle(decoration: TextDecoration.underline,fontSize: 20)),
          ],
        
        ),
        
      ),
      SizedBox(height: 10),
      Container(
        height: screenHeight /10, // Adjusted height to fit better
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Horizontal scrolling
          itemCount: images_data2.length,
          itemBuilder: (context, index) {
        // Example background colors and labels
           
      
        // Ensure index is within bounds of the backgroundColors and labels lists
        Color backgroundColor = backgroundColors[index % backgroundColors.length];
        String label = labels[index % labels.length];
      
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 15), // Spacing between items
          child: Column(
            // mainAxisSize: MainAxisSize.min, // Ensure Column only takes as much height as needed
            children: [
              CircleAvatar(
                radius: (screenHeight / 10) /2.5, // Adjusted radius
                backgroundColor: backgroundColor, // Set background color here
                backgroundImage: AssetImage(images_data2[index]), // Set the image
              ),
              SizedBox(height: 5), // Spacing between CircleAvatar and label
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10, // Adjusted font size
                    fontWeight: FontWeight.bold, // Optional: make label bold
                    color: Colors.black, // Adjust text color as needed
                  ),
                  textAlign: TextAlign.center, // Center text alignment
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ),
            ],
          ),
        );
          },
        ),
      ),
      SizedBox(height: 10),
      Container(
        color: Colors.blueAccent,
        height: screenHeight / 3, // Height of the container for the ListView
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images_data3.length,
          itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between Row and Container
          children: [
            // Adjust text style as needed
            Row(
             
              children: [
                Text('Exclusive for you'),
                SizedBox(width:150),
                Icon(Icons.arrow_circle_right_sharp, size: 24),
              ],
            ),
            
            
            
            // Spacing between Row and Container
            Container(
              width: screenWidth * 0.7, // Adjust width of the image container
              height: (screenHeight / 3) * 0.8, // Adjust height relative to the ListView container
              decoration: BoxDecoration(
                color: Colors.amber, // Background color as fallback
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(images_data3[i]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
          ),
        ),
      ),
      
      
      
      
      
      
      
      
      
            ],
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle the chat action
        },
        label: Text('Chat'),
        icon: Icon(Icons.chat),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(Icons.home, 'Home', 0),
            _buildBottomNavItem(Icons.category, 'Categories', 1),
            _buildBottomNavItem(Icons.local_offer, 'Deals', 2),
            _buildBottomNavItem(Icons.shopping_cart, 'Cart', 3),
            _buildBottomNavItem(Icons.account_circle, 'Profile', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: _selectedIndex == index ? Colors.pink : Colors.grey),
          Text(label, style: TextStyle(color: _selectedIndex == index ? Colors.pink : Colors.grey)),
        ],
      ),
    );
  }
}
      
    
    
    
  
  
  

