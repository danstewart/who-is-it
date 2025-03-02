window.addEventListener('DOMContentLoaded', async () => {
    const goButton = document.querySelector("button#go");
    goButton.addEventListener('click', () => {
        const board = boards[Math.floor(Math.random() * boards.length)];
        window.location = `/game.html?id=${board}`;
    });
});
