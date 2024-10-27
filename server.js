const express = require('express');
const { exec } = require('child_process');
const app = express();
const port = 3000;

app.get('/api/music', (req, res) => {
    exec('./music-script.sh', (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return res.status(500).send('Error executing script');
        }
        const outputLines = stdout.trim().split('\n');
        const musicInfo = {};
        outputLines.forEach(line => {
            const [key, value] = line.split(': ');
            musicInfo[key.trim().toLowerCase()] = value.trim();
        });
        res.json(musicInfo);
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});

