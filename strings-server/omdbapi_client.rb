require 'json'
require 'rest-client'

url = "http://www.omdbapi.com/"
movies = [
  "2 Fast 2 Furious",
  "2012",
  "22 Jump Street",
  "A Christmas Carol",
  "A Christmas Story",
  "A Disney Christmas Gift",
  "Ace Ventura Pet Detective",
  "Ace Ventura When Nature Calls",
  "Air Force One",
  "Aladdin",
  "Amazing Spider Man 2",
  "Ant-Man",
  "Awakenings",
  "Bambi",
  "Batman Forever",
  "Batman vs Superman",
  "Beauty and the Beast",
  "Bicentennial Man",
  "Big Hero 6",
  "Blade II",
  "Blade III",
  "Brave",
  "Bruce Almighty",
  "Cadillac Man",
  "Captain America",
  "Captain America - Civil War",
  "Captain America - The First Avenger",
  "Captain America - The Winter Soldier",
  "Cars 2",
  "Cars",
  "Central Intelligence",
  "Cinderella",
  "Dead Poets Society",
  "Deadpool",
  "Death Proof",
  "Deepwater Horizon",
  "Django Unchained",
  "Doctor Strange",
  "Dumb And Dumber",
  "Dumb and Dumber To",
  "Dumbo",
  "Earth Girls Are Easy",
  "Edward Scissorhands",
  "Elektra",
  "Elf",
  "Eternal Sunshine of the Spotless Mind",
  "Ex Machina",
  "Fantastic 4 Rise of the Silver Surfer",
  "Fantastic Four",
  "Fast & Furious",
  "Fast & Furious 6",
  "Fast Five",
  "Finding Dory",
  "Finding Nemo",
  "Flubber",
  "Four Rooms",
  "From Dusk Till Dawn",
  "Frozen",
  "Fun with Dick and Jane",
  "George of the Jungle",
  "Ghost Rider",
  "Ghost Rider Spirit of Vengeance",
  "Gone In Sixty Seconds",
  "Good Morning Vietnam",
  "Good Will Hunting",
  "Gremlins",
  "Guardians of the Galaxy",
  "Hannibal",
  "Harry Potter And The Chamber Of Secrets",
  "Harry Potter And The Deathly Hallows Part 1",
  "Harry Potter And The Deathly Hallows Part 2",
  "Harry Potter And The Goblet Of Fire",
  "Harry Potter And The Order Of The Phoenix",
  "Harry Potter And The Prisoner Of Azkaban",
  "Harry Potter and The Half Blood Prince",
  "Home Alone",
  "Home Alone 2 Lost In New York",
  "Hook",
  "Horton Hears A Who",
  "How the Grinch Stole Christmas",
  "Hulk",
  "I Love You Phillip Morris",
  "Idiocracy",
  "Incredible Hulk",
  "Independence Day Resurgence",
  "Inglourious Basterds",
  "Inside Out",
  "Insomnia",
  "Interstellar",
  "Iron Man 2",
  "Iron Man",
  "Jack",
  "Jack Reacher Never Go Back",
  "Jackie Brown",
  "Jason Bourne",
  "Jingle All the Way",
  "Joe Dirt 2",
  "Jumanji",
  "Jurassic World",
  "Kick-Ass 2",
  "Kill Bill Vol 1",
  "Kill Bill Vol 2",
  "Kingsman The Secret Service",
  "Lady and the Tramp",
  "Liar Liar",
  "Life Animated",
  "Little Nicky",
  "London Has Fallen",
  "Lost in Translation",
  "Lucy",
  "Man Of Steel",
  "Man On The Moon",
  "Man-Thing",
  "Max Steel",
  "Moscow on the Hudson",
  "Mrs. Doubtfire",
  "National Lampoon's Christmas Vacation",
  "Natural Born Killers",
  "O Brother Where Art Thou",
  "Once Bitten",
  "One Hour Photo",
  "Patch Adams",
  "Peter Pan",
  "Piper",
  "Pixels",
  "Plex",
  "Polar Express",
  "Popeye",
  "Project Almanac",
  "Pulp Fiction",
  "Punisher War Zone",
  "RV",
  "Ratatouille",
  "Reservoir Dogs",
  "Rudolph The Red Nosed Reindeer - The Movie",
  "Rudolph, the Red-Nosed Reindeer",
  "Sausage Party",
  "Sherlock Holmes A Game Of Shadows",
  "Sherlock Holmes",
  "Sin City",
  "Sleepy Hollow",
  "Snowden",
  "Spider-Man 2",
  "Spider-Man 3",
  "Star Trek - Beyond",
  "Star Trek - Into Darkness",
  "Storks",
  "Suicide Squad",
  "Sully",
  "Tangled",
  "Teenage Mutant Ninja Turtles",
  "The Accountant",
  "The Adjustment Bureau",
  "The Amazing Spider-Man",
  "The Avengers",
  "The Birdcage",
  "The Cable Guy",
  "The Campaign",
  "The Dark Knight Rises",
  "The Devil's Advocate",
  "The Fast and the Furious",
  "The Fast and the Furious - Tokyo Drift",
  "The Fisher King",
  "The Good Dinosaur",
  "The Goonies",
  "The Green Mile",
  "The Hateful Eight",
  "The Internship","The Interview",
  "The Iron Giant",
  "The Lion King",
  "The Little Mermaid",
  "The Majestic",
  "The Martian",
  "The Mask",
  "The Matrix",
  "The Matrix Reloaded",
  "The Matrix Revolutions",
  "The NeverEnding Story",
  "The Neverending Story II",
  "The Nightmare Before Christmas",
  "The Number 23",
  "The Prestige",
  "The Punisher",
  "The Purge Election",
  "The Secret Life of Pets",
  "The Silence Of The Lambs",
  "The Sixth Sense",
  "The Sword In The Stone",
  "The Theory of Everything",
  "The Truman Show",
  "Thor - The Dark World",
  "Thor",
  "Toys",
  "Trading Places",
  "Trolls",
  "True Romance",
  "Up",
  "VeggieTales Saint Nicholas - A Story of Joyful Giving!",
  "WALL-E",
  "War Dogs",
  "Warcraft",
  "What Dreams May Come",
  "Wreck It Ralph",
  "Yes Man"
]

movies.each do |movie|
  request = RestClient.get(url, { params: {t: movie, r: :json, plot: :short}})
  movie_json = JSON.parse(request.body, object_class: OpenStruct)
  Movie.create(
    title: movie_json.Title,
    year: movie_json.Year.to_i,
    released: Date.parse(movie_json.Released),
    runtime: movie_json.Runtime.to_i,
    plot: movie_json.Plot
  )
end
