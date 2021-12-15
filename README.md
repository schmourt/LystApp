# LystApp

Browse the Dog API!

<img width="319" alt="Screen Shot 2021-12-14 at 9 21 22 PM" src="https://user-images.githubusercontent.com/32526188/146111367-ef4ae88b-f789-407b-a7af-084f5b0ef016.png">

You can scroll through all the dogs, and tap to learn more information

<img width="321" alt="Screen Shot 2021-12-14 at 9 21 47 PM" src="https://user-images.githubusercontent.com/32526188/146111381-0de2311e-b45c-4649-8b57-a0e2a56dc4bc.png">


And you can even search for breeds 

<img width="324" alt="Screen Shot 2021-12-14 at 9 22 15 PM" src="https://user-images.githubusercontent.com/32526188/146111387-377333d6-5c5b-4a7a-a667-06368dc4f557.png">

I used Swift's Codable to convert the JSON from the Dog API into types used in my app. 
The home page is multiple columns in a collectionview that shows the name of the dog breed and an image.
When you tap the image, it uses dependency injection to populate the further information of the selected dog in a view controller and its tableview. 

There are some improvements that could be made with the app. For instance, some of the dog images are chopped off a bit.
The dog image cells could be the actual aspect ratio with the width and height fron the web response, 
but I think the squares were nice for consistency.

There is a bit of glitching if you scroll to fast, so the cell reuse could probably be optimized a bit more. 

The app could be scaled to implenent a cat API by using a sort of animal enum with the different URLs. 
There was no wikipedia page for the dogs, but it's easy to scale up the DogModel if needed. 
