import 'package:cloud_firestore/cloud_firestore.dart';

void addDestination() async {
  var ref = Firestore.instance.collection("destinations").document();

  await ref.setData({
    "destinationId": ref.documentID,
    "destinationPincode": "14441",
    "countryId": "IN",
    "countryName": "India",
    "stateName": "Punjab",
    "districtName": "Kapurthala",
    "name": "Lovely Professional University",
    "featuredPics": [
      // Array<Map>
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      },
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      }
    ],
    "shortDescription":
        "Lovely Professional University is a private university situated in Phagwara, Punjab, India. The university was established in 2005 by Lovely International Trust, under The Lovely Professional University Act, 2005 and started operation in 2006",
    "longDescription":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "countOfReviews": 0
  }).catchError((e) {
    print(e);
  });
}

void addAttraction() async {
  var ref = Firestore.instance.collection("attractions").document();

  ref.setData({
    "attractionId": ref.documentID,
    "attractionTagLine": "Square Park",
    "attractionShortTagLine": "Lovers Spot || Beware of Guards",
    "attractionDestination": "u2aIEX5s4Gb0RXsSxEbC",
    "attractionCity": "Phagwara",
    "whatWeWillBeDoing": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "initialPrice": 10,
    "offerPrice": 8,
    // "itinerary": [
    //   // Subdocument
    //   {
    //     "day": 1,
    //     "title": "Day 1",
    //     "imgLink": "https://www.lpu.in/about_lpu/images/infra/schools/large/lpu-side-view.jpg",
    //     "whatWeWillDo": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    //   },
    //   {
    //     "day": 2,
    //     "title": "Day 1",
    //     "imgLink": "https://www.lpu.in/about_lpu/images/infra/schools/large/lpu-side-view.jpg",
    //     "whatWeWillDo": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    //   }
    // ],
    "featuredPics": [
      // Array<Map>
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      },
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      },
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      }
    ],
    "categories": [
      // Array<Map>
      "lpu",
      "phagwara",
      "india",
      "university"
    ],
    "durationOfAttraction": 3,
    "hostedInLanguages": [
      // Array<LanguageCode>
      45,
      32,
      67
    ],
    "yourGuideId": "String",
    "guideWordsOnThisTrip": "Enjoy the trip!",
    "policiesIncluded": [
      34,
      56,
      43
    ]
  }).catchError((e){
    print(e);
  });
}


void addTour() async {
  var ref = Firestore.instance.collection("tours").document();

  ref.setData({
    "tourId": ref.documentID,
    "tourTagLine": "Trip around LPU",
    "tourShortTagLine": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "tourToDestination": "u2aIEX5s4Gb0RXsSxEbC",
    "whatWeWillBeDoing": "A trip around LPU",
    "pricePerPerson": 10,
    "offerPricePerPerson": 8,

    "featuredPics": [
      // Array<Map>
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      },
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      },
      {
        "featuredImageUrl":
            "https://www.oyorooms.com/travel-guide/wp-content/uploads/2019/11/shutterstock_1350638618.jpg",
        "featuredTitle": "LPU Vibes"
      }
    ],

    "categories": [
      "lpu",
      "trip",
      "phagwara",
      "jalandhar",
      "university"
    ],

    "durationOfTour": 3,
    "hostedInLanguages": [
      45,
      32,
      67
    ],

    "yourGuideId": "",
    "guideWordsOnThisTrip": "Enjoy the tour!",
    "policiesIncluded": [
      34,
      45,
      12
    ]


  }).catchError((e){
    print(e);
  });
}