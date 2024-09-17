Use patholo1_my_life;

-- Postagens e seus recursos

Create Table Registries (
  id Integer Auto_Increment Primary Key,
  createdAt Timestamp,
  year Year Not Null,
  content Text Not Null,
  mainImageUrl Varchar(255)
);

Create Table SecondaryImages (
  id Integer Auto_Increment Primary Key,
  imageUrl Varchar(255) Not Null,
  registryId Integer Not Null,
  Foreign Key (registryId) References Registries(id)
);

-- Registros de conteudos vistos e seus recursos

Create Table ContentTypes (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null
);

Create Table Authors (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  imageUrl Varchar(255),
  contentTypeId Integer Not Null,
  Foreign Key (contentTypeId) References ContentTypes(id)
);

Create Table Categories (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  iconBase64 Text,
  contentTypeId Integer Not Null,
  Foreign Key (contentTypeId) References ContentTypes(id)
);

Create Table Movies (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1) Not Null,
  dubbed Tinyint(1) Default 0, 
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Movie_x_Category (
  id Integer Auto_Increment Primary Key,
  movieId Integer Not Null,
  Foreign Key (movieId) References Movies(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Musics (
  id Integer Auto_Increment Primary Key,
  name Varchar(70) Not Null,
  rating Decimal(3,1) Not Null,
  soulFragment Tinyint(1) Default 0,
  link Varchar(255),
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Music_x_Category (
  id Integer Auto_Increment Primary Key,
  musicId Integer Not Null,
  Foreign Key (musicId) References Musics(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Phrases (
  id Integer Auto_Increment Primary Key,
  phrase Tinytext Not Null,
  rating Decimal(3,1) Not Null, 
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Phrase_x_Category (
  id Integer Auto_Increment Primary Key,
  phraseId Integer Not Null,
  Foreign Key (phraseId) References Phrases(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Series (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1), 
  completed Tinyint(1) Default 1,
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Serie_x_Category (
  id Integer Auto_Increment Primary Key,
  serieId Integer Not Null,
  Foreign Key (serieId) References Series(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Mangas (
  id Integer Auto_Increment Primary Key,
  name Varchar(70) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1), 
  completed Tinyint(1) Default 1,
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Manga_x_Category (
  id Integer Auto_Increment Primary Key,
  mangaId Integer Not Null,
  Foreign Key (mangaId) References Mangas(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Animes (
  id Integer Auto_Increment Primary Key,
  name Varchar(70) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1), 
  completed Tinyint(1) Default 1,
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Anime_x_Category (
  id Integer Auto_Increment Primary Key,
  animeId Integer Not Null,
  Foreign Key (animeId) References Animes(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Games (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1), 
  completed Tinyint(1) Default 1,
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Game_x_Category (
  id Integer Auto_Increment Primary Key,
  gameId Integer Not Null,
  Foreign Key (gameId) References Games(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);

Create Table Books (
  id Integer Auto_Increment Primary Key,
  name Varchar(50) Not Null,
  imageUrl Varchar(255),
  rating Decimal(3,1), 
  completed Tinyint(1) Default 1,
  soulFragment Tinyint(1) Default 0,
  authorId Integer Not Null,
  Foreign Key (authorId) References Authors(id)
);

Create Table Book_x_Category (
  id Integer Auto_Increment Primary Key,
  bookId Integer Not Null,
  Foreign Key (bookId) References Books(id),
  categoryId Integer Not Null,
  Foreign Key (categoryId) References Categories(id)
);




