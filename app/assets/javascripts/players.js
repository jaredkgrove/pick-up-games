let activePlayerProfile

window.onload = function(){
    if(document.querySelector(".players.show")){
        fetchActiveProfilePlayerData() 
    }
}

class Player {
    constructor(json) { 
        this.id = json["data"]["id"]
        this.name = json["data"]["attributes"]["name"]
        this.adminSquadsJson = json["data"]["relationships"]["admin-squads"]["data"]
    }

    isAdminOfSquad(squadId){
        let admin = false
        for(let adminSquad of this.adminSquadsJson){
            if(adminSquad["id"] === squadId){
                admin = true
            }
        }
        return admin
    }
}

class PlayerSquad {
    constructor(json) {
        this.id = json["id"]
        this.name = json["attributes"]["name"];
        this.player_count = json["attributes"]["player-count"];
        this.link = json["links"]["self"]
    }

    createElement(){
        let squadDiv = document.createElement('div')
        let squadATag = document.createElement('a')

        squadATag.href = this.link
        squadATag.innerText = `${this.name} (${this.player_count} members)`

        squadDiv.appendChild(squadATag)

        if(activePlayerProfile.isAdminOfSquad(this.id)){
            let strongAdminTag = document.createElement('STRONG')
            strongAdminTag.textContent = " Admin"
            squadDiv.appendChild(strongAdminTag)
        }

        return squadDiv
    }
}

class PlayerGame {
    constructor(json) {
        this.id = json["id"]
        this.court_name = json["attributes"]["court-name"];
        this.time_text = json["attributes"]["time-text"]
        this.link = json["links"]["self"]
        this.court_link = json["links"]["court"]
        
    }
        /* <div>
                <strong><a href="/courts/1">Jimmy's Backyard</a></strong> <br>
                <form class="button_to" method="post" action="/courts/1/games/61"><input type="hidden" name="_method" value="patch"><input type="submit" value="LEAVE"><input type="hidden" name="authenticity_token" value="TQpu0cY36kjM1bM+Nh5dqWiKxOjDPu2Cs672Batm/mk/BMjR7KZFivEcZNC1CxFG+3hZM0b0SV2YEORnxIherA=="><input type="hidden" name="player_id" value="21"></form> 
                <a href="/courts/1/games/61">Wednesday, September 25 at  8:09pm</a> 
                <strong> Admin</strong> 
            </div> */
    createElement(){
        let gameDiv = document.createElement('div')
        let courtATag = document.createElement('a')
        let gameATag = document.createElement('a')

        let formTag = document.createElement("form")
        formTag.setAttribute('class',"button_to");
        formTag.setAttribute('method',"post");
        formTag.setAttribute('action',this.link);

        let i = document.createElement("input"); //input element, text
        i.setAttribute('type',"hidden");
        i.setAttribute('name',"_method");
        i.setAttribute('value',"patch");
        
        courtATag.href = this.court_link
        courtATag.innerText = this.court_name

        gameATag.href = this.link
        gameATag.innerText = this.time_text
        //squadATag.innerText = `${this.name} (${this.player_count} members)`
        let strongTag = document.createElement('STRONG')
        strongTag.appendChild(courtATag)
        
        gameDiv.appendChild(strongTag)
        gameDiv.appendChild(gameATag)

        // if(activePlayerProfile.isAdminOfSquad(this.id)){
        //     squadDiv.innerHTML += "<strong> Admin </strong>"
        // }

        return gameDiv
    }
}

function fetchActiveProfilePlayerData(){
    let userId = document.querySelector('h1').getAttribute("user-id");
    fetch(`/players/${userId}.json`)
    .then(response => response.json())
    .then((json) => {
        activePlayerProfile = new Player(json)
        populatePlayerProfile(json)
    }
    );
}

function populatePlayerProfile(json){
    json["included"].forEach(function(resourceJson){
        if(resourceJson["type"] === "squads"){
            let squad = new PlayerSquad(resourceJson)
            let squadElement = squad.createElement()
            document.querySelector(".js-player-squads").appendChild(squadElement)
        }else if(resourceJson["type"] === "games"){
            let game = new PlayerGame(resourceJson)
            let gameElement = game.createElement()
            document.querySelector(".js-player-games").appendChild(gameElement)
        }
    })
}
