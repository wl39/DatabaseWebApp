import axios from 'axios';

const getMatches = (callback, query) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/match/search' + query,
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}


const getFullName = (callback, email, user) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/player/get/name?email=' + email,
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data, user);
    })
}

const getSimplePlayers = (callback) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/player/simple/get',
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}

const getVenues = (callback) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/venue/get',
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}

const getCourtWithVenue = (callback, venueName) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/court/get?venue=' + venueName,
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}

const createPlayer = (callback, state) => {
    axios.post('http://localhost:23204/api/player/create',
        {
            ...state
        }, {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }
    ).then((res) => {
        callback(res.data);
    }).catch((error) => {
        alert(error.response.data)
    })
}

const createNewMatch = (callback, state) => {
    axios.post('http://localhost:23204/api/match/full/create',
        {
            ...state
        }, {
        headers: {
            'Access-Control-Allow-Origin': '*',
        }
    }).then((res) => {
        callback(res.data)
    }).catch((error) => {
        alert(error.response.data)
    })
}

const createNewCourt = (callback, state) => {
    axios.post('http://localhost:23204/api/court/create',
        {
            ...state
        },
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data)
    }).catch((error) => {
        alert(error.response.data)
    })
}

const createNewVenue = (callback, state) => {
    axios.post('http://localhost:23204/api/venue/create',
        {
            ...state
        },
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data)
    }).catch((error) => {
        alert(error.response.data)
    })
}

const getViewPlayers = (callback) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/player/view/get',
        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}

const getMatchWithNames = (callback, query) => {
    axios.defaults.headers = {
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache',
        'Expires': '0',
    };
    axios.get('http://localhost:23204/api/match/get/withName?' + query,

        {
            headers: {
                'Access-Control-Allow-Origin': '*',
            }
        }
    ).then((res) => {
        callback(res.data);
    })
}

export {
    getMatches,
    getFullName,
    getSimplePlayers,
    getVenues,
    getCourtWithVenue,

    createPlayer,
    createNewMatch,
    createNewCourt,
    createNewVenue,
    getViewPlayers,

    getMatchWithNames
}
