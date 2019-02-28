# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [x] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [ ] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthough GIF
<img src="https://i.imgur.com/bb09JFc.gif" width=250> &nbsp
<img src="https://i.imgur.com/pzR8QiC.gif" width=250> <br>

### Notes
Creating the 2nd part went a lot more smoothly than the first part.

---

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [ ] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device. *I don't have an iPhone :(

### App Walkthough GIF
<img src="https://i.imgur.com/crUT9Bu.gif" width=250><br>

### Notes
Adding the images proved to be a bit difficult because they wouldn't render at first. First I changed the background color of the image to make sure that the space was there (they were). Then I cleaned the build and it didn't work. Then I made the table cell a little taller and it still didn't work. So I re-copied and pasted back the image baseUrls and re-ran it and it still didn't work. So I went to the API documentation and copied what they had there changing the image width in the baseUrl to "w500" and re-ran it before stepping away and voila, when I looked back, the images had rendered.
