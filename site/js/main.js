window.addEventListener('DOMContentLoaded', async () => {
    const goButton = document.querySelector("button#go");
    goButton.addEventListener('click', () => {
        const boards = [
            "BXhEH1cR",
            "U7F0BuLa",
            "oTeABFlZ",
            "UynZ2kQZ",
            "6oyzc3DR",
            "MhCnbaTQ",
            "IyTnRNai",
            "6YxfFuBx",
            "JrFRFAFo",
            "6gJ8Odxo",
        ];

        const board = boards[Math.floor(Math.random() * boards.length)];
        window.location = `/game.html?id=${board}`;
    });
});
