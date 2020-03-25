const admin = require('firebase-admin');
const serviceAccount = require('./ServiceAccountKey.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://aiovu-dev.firebaseio.com"
});

const db = admin.firestore();

class DestinationModel{
    
    constructor(desId){
        this.destinationId = desId;
        this.destinationPincode = "144411";
        this.countryId = "IN";
        this.countryName = "India";
        this.stateName = "Punjab";
        this.districtName = "Kapurtala";
        this.name = "Lovely Professional University";
        this.featuredPics = [
            {
                "featuredImageUrl": "String"
                "featuredTitle": "String"
            }
        ];
    }
}


// Add a Destination


// Add a Hotel


// Add a Attraction


// Add a TourPlan


// Popular Attractions


// Popular Tours


// Best Attraction Offers


// Best Tour Offers