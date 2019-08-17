# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project - I did it
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes) - Court has many games, and others
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User) - a game belongs to a court, and others
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients) - a game has many players through game_players, a player has many squads through squad_players, and others
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients) - Squad has many players and Player has many squads, and others
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity) - squad_players and game_players have an admin column. (game/squad creators are automatically admins, but they can add more admins)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) - Player must have email, name, and password, email must be unique. Squad name must be present and unique, Game can't be in the past, and others
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) - #upcoming_games in Court and Player models uses .where and .order, and others
- [x] Include signup (how e.g. Devise) - Player can sign up
- [x] Include login (how e.g. Devise) - Player can login with email and password
- [x] Include logout (how e.g. Devise) - Player can follow logout link 
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) - Player can sign up with Facebook
- [x] Include nested resource show or index (URL e.g. users/2/recipes) - Games are nested in courts courts/:court_id/games/:id
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new) - new game form is on the court show page. 
- [x] Include form display of validation errors (form URL e.g. /recipes/new) - error and success messages are shown for squads, players, and games

Confirm:
- [x] The application is pretty DRY - I think so, there is always room for improvement, but I'm pretty happy with it
- [x] Limited logic in controllers - Most logic is in controllers. My Update in the games_controller and squads_controller got a little fat. If I have time I will try to revisit that before the project review
- [x] Views use helper methods if appropriate - I think so
- [x] Views use partials if appropriate - _player_admin_buttons.html.erb
