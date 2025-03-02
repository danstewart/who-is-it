window.addEventListener('DOMContentLoaded', async () => {
    const boardId = new URLSearchParams(window.location.search).get('id');
    let board = await fetch(`/boards/${boardId}.json`);
    board = await board.json();

    const boardContainer = document.querySelector("div#peopleGrid");

    // Shuffle results
    const shuffledResults = board.results.sort(() => Math.random() - 0.5);
    shuffledResults.forEach(person => {
        const personElement = document.createElement("div");
        personElement.classList.add("person");
        personElement.innerHTML = `
            <img src="/images/${boardId}/${person.picture.large}.jpg" />
            <h4 class="playerName">${person.name.first}</h4>
        `;
        boardContainer.appendChild(personElement);
    });

    // Pick a random person as the current players answer
    const playerAnswer = board.results[Math.floor(Math.random() * board.results.length)];
    const playerContainer = document.querySelector("div#playerAnswer");
    playerContainer.innerHTML = `
        <h4>Your Answer</h4>
        <img src="/images/${boardId}/${playerAnswer.picture.large}.jpg" />
        <h4 class="playerName">${playerAnswer.name.first}</h4>
    `;

    // Add click listener for each person
    const people = document.querySelectorAll("div#peopleGrid .person");
    people.forEach(person => {
        person.addEventListener("click", () => {
            person.classList.toggle("removed");
        });
    });
});

