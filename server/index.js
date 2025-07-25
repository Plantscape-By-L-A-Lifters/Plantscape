const {
    client,
    seed
} = require('./db');

try {
    require('../env')
} catch (error) {
    console.log('make env file locally')
}

const express = require('express');
const app = express();
app.use(express.json())
app.use((req, res, next) => {
 res.setHeader(
 'Content-Security-Policy',
"default-src 'self'; img-src 'self' https:; script-src 'self'; style-src 'self' 'unsafe-inline'; font-src 'self' https:;"
 );
 next();
});
app.use('/api', require('./api'))

const init = async () => {
    const PORT = process.env.PORT || 3000;
    await client.connect();
    seed();
    console.log('connected to database')
    app.listen(PORT,() => {
        console.log(`listening on port ${PORT}`)
    })
}
init();