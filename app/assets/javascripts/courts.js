
function createSimpleCourt(){
    
    const initializeCourtsIndexView = () => {
        setBodyClass("courts index")
        let main = document.querySelector('main')
        main.innerHTML = `
            <h1> Courts </h1>
            <div class='courts-list'></div>
        `
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

        addCourtWrapper(){
            let wrapper = createLink({class: "content-box js-court", href: "#", court_id: this.id})
            let courtNameTag = createElement('h3',{}, this.name)
            wrapper.appendChild(courtNameTag)
            wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
            this.addClickListener(wrapper)
            courtsWrapper.appendChild(wrapper)
        }

        addClickListener(elem){
            elem.addEventListener('click', function(e){
                e.preventDefault()
                fetchCourt(elem.getAttribute('court_id'))
            })
        }
    }
}

function createCompleteCourt(){



    // const addCourtUpcomingGamesView = () => {
        
    //     `<div class="content-box court-upcoming-games">
    //         <h2>Upcoming Games</h2>
    //         <div class="games_list">
    //             <a href="/courts/1/games/53">Saturday, September 14 at  5:09am (1)</a> <br>
    //             <a href="/courts/1/games/54">Saturday, September 14 at  4:09pm (2)</a> <br>
    //             <a href="/courts/1/games/52">Monday, September 16 at 12:09pm (2)</a> <br>
    //         </div>
    //     </div>`
        
    // }
    
    
    //let courtHeader = document.querySelector('h1')
    //let courtWrapper = document.querySelectorAll('.court-info')[0]

    return class {
        constructor(json) {
            this.id = json["data"]["id"]
            this.name = json["data"]["attributes"]["name"]
            //courtHeader.textContent = this.name
            this.location = json["data"]["attributes"]["location"]
            this.favorite_count = json["data"]["attributes"]["favorite-count"] 
            
            // json["included"].forEach(function(courtJson){
            //     court = new SimpleCourt(courtJson)
            // })
            //console.log(json["included"])
            //this.path = json["links"]["self"]
            //this.addCourtWrapper()
        }

        addCourtWrapper(){
            let wrapper = createLink({class: "content-box js-court", href: "#", court_id: this.id})
            let courtNameTag = createElement('h3',{}, this.name)
            wrapper.appendChild(courtNameTag)
            wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
            this.addClickListener(wrapper)
            courtsWrapper.appendChild(wrapper)
        }

        addClickListener(elem){
            elem.addEventListener('click', function(e){
                e.preventDefault()
                fetchCourt(e.target.getAttribute('court_id'))
            })
        }

        initializeCourtShowView = () => {
            setBodyClass("courts show")
            let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
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
                        <h3 id='js-favorite-count'></h3>
                    </div>
            
                    <div class="content-box">
                        <h2>Upcoming Games</h2>
                        <div class="games_list"></div>
                    </div>
                    <h2>Create New Game</h2>
                    <form class="new-game" action="/courts/${this.id}/games" accept-charset="UTF-8" method="post">
                        <input name="utf8" type="hidden" value="✓">
                        <input type="hidden" name="authenticity_token" value="${token}">
                        <input type="hidden" name="game[court_id]" id="game_court_id" value="${this.id}">
                        Skill Level <br>
                        <select name="game[skill_level]" id="game_skill_level">
                            <option selected="selected" value="Everyone Welcome">Everyone Welcome</option>
                            <option value="Weekend Hustlers">Weekend Hustlers</option>
                            <option value="Offseason Reps">Offseason Reps</option>
                            <option value="Run the Court (Girls)">Run the Court (Girls)</option>
                            <option value="Still Got It">Still Got It</option></select> <br>
                        Time <br> 
                        <input type="datetime-local" name="game[time]" id="game_time" value="2019-09-13T14:57"> <br>
                        <input type="submit" name="commit" value="Create Game" data-disable-with="Create Game">
                    </form>
                </div>
            `
        }
    }
}

function createCourtUpcomingGame(){
{/* <div class="content-box">
        <h2>Upcoming Games</h2>
        <div class="games_list">
                <a href="/courts/1/games/53">Saturday, September 14 at  5:09am (1)</a> <br>
                <a href="/courts/1/games/54">Saturday, September 14 at  4:09pm (2)</a> <br>
                <a href="/courts/1/games/52">Monday, September 16 at 12:09pm (2)</a> <br>
        </div>
    </div> */}


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

        addCourtWrapper(){
            let wrapper = createLink({class: "content-box js-court", href: "#", court_id: this.id})
            let courtNameTag = createElement('h3',{}, this.name)
            wrapper.appendChild(courtNameTag)
            wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
            this.addClickListener(wrapper)
            courtsWrapper.appendChild(wrapper)
        }

        addClickListener(elem){
            elem.addEventListener('click', function(e){
                e.preventDefault()
                fetchCourt(elem.getAttribute('court_id'))
            })
        }
    }
}

function fetchCourt(id){
    fetch(`/courts/${id}.json`)
    .then(response => response.json())
    .then((json) => {
        const CompleteCourt = createCompleteCourt()
        court = new CompleteCourt(json)
        court.initializeCourtShowView()
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




