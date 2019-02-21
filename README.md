# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

📝 `NOTE - PASTE PART 2 SNIPPET HERE:` Paste the README template for part 2 of this assignment here at the top. This will show a history of your development process, which users stories you completed and how your app looked and functioned at each step.

---

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [ ] (2pt) User can view the app on various device sizes and orientations.
- [ ] (1pt) Run your app on a real device. *I don't have an iPhone :`(

### App Walkthough GIF
<img src="https://i.imgur.com/crUT9Bu.gif" width=250><br>

### Notes
Adding the images proved to be a bit difficult because they wouldn't render at first. First I changed the background color of the image to make sure that the space was there (they were). Then I cleaned the build and it didn't work. Then I made the table cell a little taller and it still didn't work. So I re-copied and pasted back the image baseUrls and re-ran it and it still didn't work. So I went to the API documentation and copied what they had there changing the image width in the baseUrl to "w500" and re-ran it before stepping away and voila, when I looked back, the images had rendered.
