
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

    const initializeCourtShowView = () => {
        setBodyClass("court show")
        let main = document.querySelector('main')
        main.innerHTML = `
            <h1>  </h1>
            <div class='court-info'>

            </div>
        `
    }

    const addCourtUpcomingGamesView = () => {
        
        `<div class="content-box court-upcoming-games">
            <h2>Upcoming Games</h2>
            <div class="games_list">
                <a href="/courts/1/games/53">Saturday, September 14 at  5:09am (1)</a> <br>
                <a href="/courts/1/games/54">Saturday, September 14 at  4:09pm (2)</a> <br>
                <a href="/courts/1/games/52">Monday, September 16 at 12:09pm (2)</a> <br>
            </div>
        </div>`
        
    }
    
    initializeCourtShowView()
    let courtHeader = document.querySelector('h1')
    let courtWrapper = document.querySelectorAll('.court-info')[0]

    return class {
        constructor(json) {
            this.id = json["data"]["id"]
            this.name = json["data"]["attributes"]["name"]
            courtHeader.textContent = this.name
            this.location = json["data"]["attributes"]["location"]
            this.favorite_count = json["data"]["attributes"]["favorite-count"] 
            
            json["included"].forEach(function(courtJson){
                court = new SimpleCourt(courtJson)
            })
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




