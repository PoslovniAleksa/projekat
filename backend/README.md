ovo je link za swagger docs (ovde je localhost, ali na konzoli pise 0.0.0.0) http://127.0.0.1:8000/docs

# API:
* GET hello : vraca json {hello: world}
* GET news : vraca redove iz tabele News, koristi page-ove (news/?page=)
* POST login ILI token : za dobijanje jwt tokena (koristi request body {username:"", password=""})
* GET protected-route : zahteva jwt token, vraca {message: This is a protected route}
* POST register : Request Body ima username i password. Registruje korisnika (username mora biti jedinstven)
* GET search/{keyword} : Vraca sve novosti koje sadrze keyword unutar polja Name, Author i Website Link (nema ogranicenja)
* PUT add-news : Request Body ima name, author, website link. Zahteva jwt token i ubacuje novi red unutar tabele News. Date se generise automatski

* GET comments/{news_id} : Vraca sve komentare za neku vest
* PUT add-comment : Request Body {comment_text: "", news_id: ""} i zahteva jwt token

