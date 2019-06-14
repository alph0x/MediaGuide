# MediaGuide
Simple App that Consumes TheMovieDB API


The App is intented to have VIPER as main design pattern. There are some ViewModel classes to handle the data models and threaten Movies and TV Shows as a "Media" Object, the purpose of this, is create universal view controllers that handle media instead of TVShows and Movies separated.

For the API, I used Siesta and HyperOslo's Cache, the Object Models were created with Quicktype.

The construction of the views is reusable cells based, used a lot of Collection and Table views, all reusable cells are created separately with they own .xib, most of them are just nested collections.

--

The single responsability principles states that every class should have responsability over a single part of the functionality, parting from this, we can figure that the purpose is that every class does what it have to do, creating a highly modular code.

For me, "good" code should be reusable, modular, easy to drop in and out, and classes shouldnt be thousands of lines, classes should be concise and focusing on excecuting a role.
