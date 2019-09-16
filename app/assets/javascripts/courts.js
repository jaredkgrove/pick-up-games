function createSimpleCourt(){
    
    const initializeCourtsIndexView = () => {
        setBodyClass("courts index")
        let main = document.querySelector('main')
        main.innerHTML = `
            <h1> Courts </h1>
            <div class='courts-list'></div>
        ` // Court index template
    }

    initializeCourtsIndexView()

    let courtsWrapper = document.querySelectorAll('.courts-list')[0]

    return class {
        constructor(json) {
            this.id = json["id"]
            this.name = json["attributes"]["name"]
            this.location = json["attributes"]["location"]
            this.upcoming_game_count = json["attributes"]["upcoming-game-count"] 
            this.path = json["links"]["self"]
            this.addCourtWrapper()
        }

        addCourtWrapper = () => {
            let wrapper = createElement('a', {class: "content-box js-court", href: "#", court_id: this.id})
            let courtNameTag = createElement('h3',{}, this.name)
            wrapper.appendChild(courtNameTag)
            wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
            this.addClickListener(wrapper)
            courtsWrapper.appendChild(wrapper)
        }

        addClickListener = (elem) => {
            elem.addEventListener('click', function(e){
                e.preventDefault()
                fetchCourt(elem.getAttribute('court_id'))
            })
        }
    }
}

function createCompleteCourt(){
    let token = document.getElementsByName('csrf-token')[0].getAttribute('content')

    return class {
        constructor(json) {
            this.id = json["data"]["id"]
            this.name = json["data"]["attributes"]["name"]
            this.location = json["data"]["attributes"]["location"]
            this.favorite_count = json["data"]["attributes"]["favorite-count"]
            this.initializeCourtShowView()
            if(json["included"]){
                this.addCourtUpcomingGames(json["included"])
            }
            this.addListenerToNewGameForm()
        }

        addListenerToNewGameForm = () => {
            let newGameForm = document.querySelector('.new-game')
            newGameForm.addEventListener('submit',function(e){
                e.preventDefault()
                fetchCreateGame(newGameForm.getAttribute('action'), newGameFormToJSON(newGameForm))
             })
        }

        addCourtUpcomingGames = (gamesArray) => {
            const UpcomingGame =  createCourtUpcomingGame()
            for(let gameObject of gamesArray){
                let game = new UpcomingGame(gameObject)
            }
        }

        initializeCourtShowView = () => {
            setBodyClass("courts show")
            let main = document.querySelector('main')
            main.innerHTML = 
            `
                <h1 id='js-court-name'>${this.name}</h1>
                <div class="court-info">
                    <h3 id='js-court-location'>${this.location}</h3>
                    <div class="favorite">
                        <form class="button_to" method="post" action="/courts/${this.id}">
                            <input type="hidden" name="_method" value="patch">
                            <input type="submit" value="${currentUser.isFavoriteCourt(this.id) ? "REMOVE FROM FAVORITES" : "ADD TO FAVORITES"}">
                            <input type="hidden" name="authenticity_token" value="${token}">
                        </form>
                        <h3 id='js-favorite-count'>Favorited by ${this.favorite_count} Players</h3>
                    </div>
            
                    <div class="content-box">
                        <h2>Upcoming Games</h2>
                        <div class="games_list"></div>
                    </div>
                    <h2>Create New Game</h2>
                    <form class="new-game" action="/courts/${this.id}/games" accept-charset="UTF-8" method="post">
                        <input name="utf8" type="hidden" value="✓">
                        <input type="hidden" name="authenticity_token" value="${token}">
                        <input type="hidden" name="court_id" id="game_court_id" value="${this.id}">
                        Skill Level <br>
                        <select name="skill_level" id="game_skill_level">
                            <option selected="selected" value="Everyone Welcome">Everyone Welcome</option>
                            <option value="Weekend Hustlers">Weekend Hustlers</option>
                            <option value="Offseason Reps">Offseason Reps</option>
                            <option value="Run the Court (Girls)">Run the Court (Girls)</option>
                            <option value="Still Got It">Still Got It</option></select> <br>
                        Time <br> 
                        <input type="datetime-local" name="time" id="game_time" value="2019-09-13T14:57"> <br>
                        <input type="submit" name="commit" value="Create Game" data-disable-with="Create Game">
                    </form>
                </div>`
        }
    }
}

function createCourtUpcomingGame(){
    const gameList = document.querySelector(".games_list")

    return class {
        constructor(json) {
            this.id = json["id"]
            this.name = json["attributes"]["name"]
            this.timeText = json["attributes"]["time-text"]
            this.playerCount = json["attributes"]["player-count"]
            this.path = json["links"]["self"]
            this.addGameElement()
        }
        
        addGameElement = () => {
            let gameTag = createElement('a', {href: `${this.path}`}, `${this.timeText} (${this.playerCount})\n`)
            gameList.appendChild(gameTag)
            gameList.appendChild(createElement('br'))
        }
    }
}


const newGameFormToJSON = elements => [].reduce.call(elements, (data, element) => {
    if(element.name === 'authenticity_token' || element.name === 'utf8' || element.name === 'commit'){
        data[element.name] = element.value;
    }else{   
        data["game"][element.name] = element.value
    }
    return data;
  
  }, {"game":{}});

function fetchCreateGame(path, game_data){
    fetch(`${path}.json`,
        {
            method: 'POST',
            body: JSON.stringify(game_data),
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then((res) => {
        if (!res.ok) {
            throw Error(res.statusText);
        }
        return res.json()
    }).then(function(json) {
        newGameJson = json["included"].slice(-1)[0]
        const UpcomingGame =  createCourtUpcomingGame()
        new UpcomingGame(newGameJson)
    }).catch(function(error) {
        console.log(error)
    })
}

function fetchCourt(id){
    fetch(`/courts/${id}.json`, {redirect: 'follow'})
    .then( (response) => {
        let isRedirected = response.redirected
        if(isRedirected){
            window.location.href = response.url;
        }else{
            return response.json()
        }
    })
    .then((json) => {
        const CompleteCourt = createCompleteCourt()
        court = new CompleteCourt(json)
    }
    );
}

function fetchCourts(){
    fetch(`/courts.json`)
    .then(response => response.json())
    .then((json) => {
        const SimpleCourt = createSimpleCourt()
        json["data"].forEach(function(courtJson){
            court = new SimpleCourt(courtJson)
        })
    }
    );
}




