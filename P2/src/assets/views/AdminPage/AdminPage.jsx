import { Card } from "@mui/material";
import { CardContent } from "@mui/material";
import { Modal } from "@mui/material";
import { InputLabel } from "@mui/material";
import { FormControl } from "@mui/material";
import Select from '@mui/material/Select';

import { Button } from "@mui/material";
import { TextField } from "@mui/material";
import React from "react";
import { getSimplePlayers, getVenues, getCourtWithVenue, createPlayer, createNewMatch, createNewCourt, createNewVenue } from "../../../axios/axios";
import styles from './AdminPage.module.css'
import { MenuItem } from "@mui/material";
import { Autocomplete } from "@mui/material";


class AdminPage extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            player: false,
            match: false,
            court: false,
            venue: false,

            phoneHandler: [
                <div key={1}>
                    <TextField
                        fullWidth
                        label={"phone" + 1}
                        margin="normal"
                        color="success"
                        onChange={(event) => this.phoneHandler(event, 0)}
                    />
                    <Autocomplete
                        onChange={(event, value) => this.phoneTypeHandler(value, 0)}
                        disablePortal
                        id="test"
                        options={
                            [
                                {
                                    label: "Home",
                                    value: "home"
                                },
                                {
                                    label: "Mobile",
                                    value: "mobile"
                                },
                                {
                                    label: "Work",
                                    value: "work"
                                },
                            ]
                        }
                        renderInput={(params) => <TextField {...params} label={"Phone" + (1) + " Type"} />}
                    />
                </div>
            ],

            email: "",
            forename: "",
            middleNames: "",
            surname: "",
            dateOfBirth: "",
            phones: [
                {
                    phoneNumber: "",
                    phoneType: "",
                }
            ],

            playersList: "",

            matchP1: "",
            matchP2: "",
            matchDate: "",
            venueValue: "",
            courtValue: "",
            courtSufcae: "",
            set1P1Value: "",
            set1P2Value: "",
            set2P1Value: "",
            set2P2Value: "",
            set3P1Value: "",
            set3P2Value: "",


            matchIndex: 0,

            addVenue: "",
            addVenueAddress: "",


            venuesList: "",
            courtList: "",


            addCourtSurface: "grass",
            newCourtNumber: 0,

            courtDisabled: true,
        }
    }

    inputHandler = (event, toChange) => {
        this.setState({
            [toChange]: event.target.value
        })
    }

    phoneHandler = (event, phoneIndex) => {
        let phones = [...this.state.phones];

        phones[phoneIndex].phoneNumber = event.target.value;

        this.setState({
            phones: [...phones]
        })
    }

    phoneTypeHandler = (value, phoneIndex) => {
        let phoneHandler = [...this.state.phoneHandler];

        let phones = [...this.state.phones];

        phones[phoneIndex].phoneType = value.value;

        this.setState({
            phones: [...phones],
            phoneHandler: phoneHandler
        })
    }

    addNewPhone = () => {
        let phoneHandler = [...this.state.phoneHandler];
        let newIndex = this.state.phoneHandler.length + 1;
        phoneHandler.push(
            <div key={newIndex}>
                <TextField
                    fullWidth
                    label={"phone" + newIndex}
                    margin="normal"
                    color="success"
                    onChange={(event) => this.phoneHandler(event, newIndex - 1)}
                />
                <Autocomplete
                    onChange={(event, value) => this.phoneTypeHandler(value, newIndex - 1)}
                    disablePortal
                    id="test"
                    options={
                        [
                            {
                                label: "Home",
                                value: "home"
                            },
                            {
                                label: "Mobile",
                                value: "mobile"
                            },
                            {
                                label: "Work",
                                value: "work"
                            },
                        ]
                    }
                    renderInput={(params) => <TextField {...params} label={"Phone" + (newIndex) + " Type"} />}
                />
            </div>
        )

        this.setState(
            {
                phoneHandler: phoneHandler,
                phones: [
                    ...this.state.phones,
                    {
                        phoneNumber: "",
                        phoneType: ""
                    }
                ],
            }
        )
    }

    user1Handler = (event) => {
        this.setState({
            matchP1: event.target.value
        })
    }

    user2Handler = (event) => {
        this.setState({
            matchP2: event.target.value
        })
    }

    surfaceHandler = (value) => {
        this.setState({
            courtSufcae: value
        })
    }

    getCourtWithVenueCallback = (data) => {
        let courtList = []

        data.forEach(element => {
            courtList.push(
                <MenuItem key={element.number} value={element.number.toString() + "," + element.surface}>{element.number.toString()} ({element.surface})</MenuItem>
            )
        })


        let courtValue;
        let courtDisabled;

        if (courtList.length === 0) {
            courtValue = ""
            courtDisabled = true;
        } else {
            courtValue = data[0].number.toString() + "," + data[0].surface;
            courtDisabled = false;
        }

        this.setState({
            courtList: courtList,
            courtValue: courtValue,
            courtDisabled: courtDisabled,
            newCourtNumber: data.length + 1
        })
    }

    venueHandler = (event) => {
        this.setState({
            venueValue: event.target.value
        })

        getCourtWithVenue(this.getCourtWithVenueCallback, event.target.value)
    }

    courtHandler = (event) => {
        this.setState({
            courtValue: event.target.value
        })
    }

    playerModalOpen = () => {
        this.setState({
            player: true
        })
    }

    playerModalClose = () => {
        this.setState({
            player: false,
            phones:
                [
                    {
                        "phoneNumber": "",
                        "phoneType": ""
                    }
                ],
            email: "",
            forename: "",
            middleNames: "",
            surname: "",
            dateOfBirth: "",
            elo: 1000,
            phoneHandler: [
                <div key={1}>
                    <TextField
                        fullWidth
                        label={"phone" + 1}
                        margin="normal"
                        color="success"
                        onChange={(event) => this.phoneHandler(event, 0)}
                    />
                    <Autocomplete
                        onChange={(event, value) => this.phoneTypeHandler(value, 0)}
                        disablePortal
                        id="test"
                        options={
                            [
                                {
                                    label: "Home",
                                    value: "home"
                                },
                                {
                                    label: "Mobile",
                                    value: "mobile"
                                },
                                {
                                    label: "Work",
                                    value: "work"
                                },
                            ]
                        }
                        renderInput={(params) => <TextField {...params} label={"Phone" + (1) + " Type"} />}
                    />
                </div>
            ],
        })
    }

    matchModalOpen = () => {
        this.setState({
            match: true
        })
    }

    matchModalClose = () => {
        this.setState({
            match: false,
            matchP1: "",
            matchP2: "",
            matchDate: "",
            venueValue: "",
            courtValue: "",
            courtSufcae: "",
            set1P1Value: "",
            set1P2Value: "",
            set2P1Value: "",
            set2P2Value: "",
            set3P1Value: "",
            set3P2Value: "",

        })
    }

    courtModalOpen = () => {
        this.setState({
            court: true
        })
    }

    courtModalClose = () => {
        this.setState({
            court: false,
            venueValue: "",
            courtValue: "",
            courtSufcae: "",
        })
    }

    venueModalOpen = () => {
        this.setState({
            venue: true
        })
    }

    venueModalClose = () => {
        this.setState({
            venue: false
        })
    }

    getVenuesCallback = (data) => {
        let venueList = []

        data.forEach(element => {
            venueList.push(
                <MenuItem key={element.name} value={element.name}>{element.name} ({element.address})</MenuItem>
            )
        })

        this.setState({
            venuesList: venueList
        })
    }

    getSimplePlayersCallback = (data) => {
        let playerList = []


        data.forEach(element => {
            playerList.push(
                <MenuItem key={element.email} value={element.email}>{element.email} - {element.surname}</MenuItem>
            )
        })

        this.setState({
            playersList: playerList
        })

        getVenues(this.getVenuesCallback)
    }

    createNewPlayerCallback = () => {
        alert("New Player created!")

        this.setState({
            phones:
                [
                    {
                        "phoneNumber": "",
                        "phoneType": ""
                    }
                ],
            email: "",
            forename: "",
            middleNames: "",
            surname: "",
            dateOfBirth: "",
            elo: 1000,
            player: false,
            phoneHandler: [
                <div key={1}>
                    <TextField
                        fullWidth
                        label={"phone" + 1}
                        margin="normal"
                        color="success"
                        onChange={(event) => this.phoneHandler(event, 0)}
                    />
                    <Autocomplete
                        onChange={(event, value) => this.phoneTypeHandler(value, 0)}
                        disablePortal
                        id="test"
                        options={
                            [
                                {
                                    label: "Home",
                                    value: "home"
                                },
                                {
                                    label: "Mobile",
                                    value: "mobile"
                                },
                                {
                                    label: "Work",
                                    value: "work"
                                },
                            ]
                        }
                        renderInput={(params) => <TextField {...params} label={"Phone" + (1) + " Type"} />}
                    />
                </div>
            ]
        })
    }

    createNewMatchCllback = () => {
        alert("New Match created!")

        this.setState({
            matchP1: "",
            matchP2: "",
            matchDate: "",
            venueValue: "",
            courtValue: "",
            courtSufcae: "",
            set1P1Value: "",
            set1P2Value: "",
            set2P1Value: "",
            set2P2Value: "",
            set3P1Value: "",
            set3P2Value: "",
            match: false,
        })
    }

    createNewMatch = () => {
        let court = this.state.courtValue.split(',');
        let setToSend = [];

        if (this.state.set1P1Value && this.state.set1P2Value) {
            setToSend.push(
                {
                    "setNumber": 1,
                    "p1Score": parseInt(this.state.set1P1Value),
                    "p2Score": parseInt(this.state.set1P2Value)
                }
            )
        } else {
            alert("You have to fill the scores")
        }

        if (this.state.set2P1Value && this.state.set2P2Value) {
            setToSend.push(
                {
                    "setNumber": 2,
                    "p1Score": parseInt(this.state.set2P1Value),
                    "p2Score": parseInt(this.state.set2P2Value)
                }
            )
        }

        if (this.state.set3P1Value && this.state.set3P2Value) {
            setToSend.push(
                {
                    "setNumber": 3,
                    "p1Score": parseInt(this.state.set3P1Value),
                    "p2Score": parseInt(this.state.set3P2Value)
                }
            )
        }


        let sendState =
        {
            "p1Email": this.state.matchP1,
            "p2Email": this.state.matchP2,
            "datePlayed": this.state.matchDate,
            "court": {
                "number": court[0],
                "surface": court[1],
                "venue": {
                    "name": this.state.venueValue
                }
            },
            "set": setToSend
        }

        createNewMatch(this.createNewMatchCllback, sendState)
    }

    createNewPlayer = () => {
        let middleNamesArray = []

        if (this.state.middleNames !== "") {
            middleNamesArray = this.state.middleNames.split(',')
        }

        let phoneToSend = this.state.phones;

        if (phoneToSend[phoneToSend.length - 1].phoneNumber === "")
            phoneToSend.pop();

        let sendState =
        {
            "email": this.state.email,
            "forename": this.state.forename,
            "middleNames": middleNamesArray,
            "surname": this.state.surname,
            "dateOfBirth": this.state.dateOfBirth,
            "elo": 1000,
            "phones": phoneToSend
        }

        if (phoneToSend.length === 0) {
            this.setState({
                phones:
                    [
                        {
                            "phoneNumber": "",
                            "phoneType": ""
                        }
                    ]
            })
        }

        createPlayer(this.createNewPlayerCallback, sendState);
    }

    createNewVenueCallback = () => {
        alert("New Venue created!")

        this.setState({
            addVenue: "",
            addVenueAddress: "",
            venue: false
        })

        getVenues(this.getVenuesCallback)
    }

    createNewVenue = () => {
        let stateToSend = {
            "name": this.state.addVenue,
            "address": this.state.addVenueAddress
        }

        createNewVenue(this.createNewVenueCallback, stateToSend);
    }

    createNewCourtCallback = () => {
        alert("New Court created!")

        this.setState({
            newCourtNumber: 0,
            addCourtSurface: "",
            venueValue: "",
            courtValue: "",
            courtSufcae: "",
            court: false
        })
    }

    createNewCourt = () => {
        let stateToSend = {
            "number": this.state.newCourtNumber,
            "surface": this.state.addCourtSurface,
            "venue": {
                "name": this.state.venueValue
            }
        }

        createNewCourt(this.createNewCourtCallback, stateToSend)
    }

    addCourtSurfaceHandler = (event) => {
        this.setState({
            addCourtSurface: event.target.value
        })
    }

    componentDidMount() {
        getSimplePlayers(this.getSimplePlayersCallback);

    }

    render() {
        return (
            <div className={styles.admin}>
                <div className={styles.cardContainer}>
                    <Card sx={{ width: "450px", padding: "15px 50px" }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Player</div>
                            <div className={styles.playerSub}>Add a new player</div>
                            <div className={styles.buttonContainer}>
                                <Button variant="contained" color="success" onClick={this.playerModalOpen}>
                                    open
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                    <Card sx={{ width: "450px", padding: "15px 50px" }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Match</div>
                            <div className={styles.playerSub}>Add a new match</div>
                            <div className={styles.buttonContainer}>
                                <Button variant="contained" color="success" onClick={this.matchModalOpen}>
                                    open
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </div>
                <div className={styles.cardContainer}>
                    <Card sx={{ width: "450px", padding: "15px 50px" }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Venue</div>
                            <div className={styles.playerSub}>Add a new venue</div>
                            <div className={styles.buttonContainer}>
                                <Button variant="contained" color="success" onClick={this.venueModalOpen}>
                                    open
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                    <Card sx={{ width: "450px", padding: "15px 50px" }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Court</div>
                            <div className={styles.playerSub}>Add a new court</div>
                            <div className={styles.buttonContainer}>
                                <Button variant="contained" color="success" onClick={this.courtModalOpen}>
                                    open
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </div>
                <Modal
                    open={this.state.player}
                    onClose={this.playerModalClose}
                >
                    <Card sx={{
                        position: 'absolute',
                        width: "600px",
                        height: "700px",
                        padding: "15px 50px",
                        top: '50%',
                        left: '50%',
                        transform: 'translate(-50%, -50%)',
                        overflowY: 'auto'
                    }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Player</div>
                            <div className={styles.playerSub}>Add a new player</div>
                            <div className={styles.inputContainer}>
                                <TextField
                                    required
                                    label="email"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "email")}
                                />

                                <TextField
                                    required
                                    label="Forename"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "forename")}
                                />
                                <TextField
                                    label="Middle names"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "middleNames")}
                                />

                                <TextField
                                    required
                                    id="outlined"
                                    label="Surname"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "surname")}
                                />

                                <TextField
                                    required
                                    id="outlined"
                                    label="Date of Birth (DD/MM/YYYY)"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "dateOfBirth")}
                                />
                                <TextField
                                    required
                                    label="ELO"
                                    margin="normal"
                                    color="success"
                                    defaultValue={1000}
                                    type="number"
                                    disabled
                                />
                                {this.state.phoneHandler}
                            </div>
                            <div className={styles.playerButtonContainer}>
                                <Button variant="contained" color="success" onClick={this.addNewPhone}>
                                    add new phone
                                </Button>
                                <Button variant="contained" color="success" onClick={this.createNewPlayer}>
                                    create
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </Modal>


                <Modal
                    open={this.state.match}
                    onClose={this.matchModalClose}
                >
                    <Card sx={{
                        position: 'absolute',
                        width: "600px",
                        padding: "15px 50px",
                        top: '50%',
                        left: '50%',
                        transform: 'translate(-50%, -50%)',
                    }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Match</div>
                            <div className={styles.playerSub}>Add a new match</div>
                            <div className={styles.inputContainer}>
                                <FormControl fullWidth>
                                    <InputLabel id="player1">Player 1</InputLabel>
                                    <Select labelId="player1" label="Player 1" value={this.state.matchP1} onChange={this.user1Handler}>
                                        {this.state.playersList}
                                    </Select>
                                </FormControl>
                                <div style={{ paddingBottom: "20px" }} />
                                <FormControl fullWidth>
                                    <InputLabel id="player2">Player 2</InputLabel>
                                    <Select key="hihihihihi" labelId="player2" label="Player 2" value={this.state.matchP2} onChange={this.user2Handler}>
                                        {this.state.playersList}
                                    </Select>
                                </FormControl>

                                <TextField
                                    required
                                    label="Date of Play (DD/MM/YYYY)"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "matchDate")}
                                />
                                <div style={{ paddingBottom: "20px" }} />

                                <FormControl fullWidth>
                                    <InputLabel id="venue">Venue (Address)</InputLabel>
                                    <Select labelId="venue" label="Venue (Address)" value={this.state.venueValue} onChange={this.venueHandler}>
                                        {this.state.venuesList}
                                    </Select>
                                </FormControl>
                                <div style={{ paddingBottom: "20px" }} />
                                <FormControl fullWidth disabled={this.state.courtDisabled}>
                                    <InputLabel id="court">{this.state.courtDisabled ? "No court in this venue" : "Court (Surface Type)"}</InputLabel>
                                    <Select labelId="court" label={this.state.courtDisabled ? "No court in this venue" : "Court (Surface Type)"} value={this.state.courtValue} onChange={this.courtHandler}>
                                        {this.state.courtList}
                                    </Select>
                                </FormControl>


                                <div className={styles.setScoreContainer}>
                                    <div className={styles.eachSetContainer}>
                                        <div className={styles.setHeader}>Set 1</div>
                                        <TextField
                                            required
                                            fullWidth
                                            label="Player 1 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set1P1Value")}
                                        />

                                        <TextField
                                            required
                                            fullWidth
                                            label="Player 2 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set1P2Value")}
                                        />
                                    </div>
                                    <div className={styles.eachSetContainer}>
                                        <div className={styles.setHeader}>Set 2</div>
                                        <TextField
                                            required
                                            fullWidth
                                            label="Player 1 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set2P1Value")}
                                        />

                                        <TextField
                                            fullWidth
                                            required
                                            label="Player 2 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set2P2Value")}
                                        />
                                    </div>
                                    <div className={styles.eachSetContainer}>
                                        <div className={styles.setHeader}>Set 3</div>
                                        <TextField
                                            required
                                            fullWidth
                                            label="Player 1 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set3P1Value")}
                                        />

                                        <TextField
                                            required
                                            fullWidth
                                            label="Player 2 Score"
                                            margin="normal"
                                            color="success"
                                            type="number"
                                            onChange={(event) => this.inputHandler(event, "set3P2Value")}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className={styles.createButtonContainer}>
                                <Button variant="contained" color="success" onClick={this.createNewMatch}>
                                    create
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </Modal>




                <Modal
                    open={this.state.venue}
                    onClose={this.venueModalClose}
                >
                    <Card sx={{
                        position: 'absolute',
                        width: "600px",
                        padding: "15px 50px",
                        top: '50%',
                        left: '50%',
                        transform: 'translate(-50%, -50%)',
                    }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Venue</div>
                            <div className={styles.playerSub}>Add a new venue</div>
                            <div className={styles.inputContainer}>
                                <TextField
                                    required
                                    label="name"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "addVenue")}
                                />

                                <TextField
                                    required
                                    label="address"
                                    margin="normal"
                                    color="success"
                                    onChange={(event) => this.inputHandler(event, "addVenueAddress")}
                                />
                            </div>
                            <div className={styles.createButtonContainer}>
                                <Button variant="contained" color="success" onClick={this.createNewVenue}>
                                    create
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </Modal>









                <Modal
                    open={this.state.court}
                    onClose={this.courtModalClose}
                >
                    <Card sx={{
                        position: 'absolute',
                        width: "600px",
                        padding: "15px 50px",
                        top: '50%',
                        left: '50%',
                        transform: 'translate(-50%, -50%)',
                    }}>
                        <CardContent>
                            <div className={styles.playerHeader}>Court</div>
                            <div className={styles.playerSub}>Add a new court</div>
                            <div className={styles.inputContainer}>
                                <div>New Court to add: {this.state.newCourtNumber}</div>
                                <div style={{ paddingBottom: "5px" }} />
                                <FormControl fullWidth>
                                    <InputLabel id="venue">Venue (Address)</InputLabel>
                                    <Select labelId="venue" label="Venue (Address)" value={this.state.venueValue} onChange={this.venueHandler}>
                                        {this.state.venuesList}
                                    </Select>
                                </FormControl>
                                <div style={{ paddingBottom: "20px" }} />
                                <FormControl fullWidth>
                                    <InputLabel id="court-surface">Court Surface</InputLabel>
                                    <Select labelId="corut-surface" label="Court Surface" value={this.state.addCourtSurface} onChange={this.addCourtSurfaceHandler}>
                                        <MenuItem value="grass">Grass</MenuItem>
                                        <MenuItem value="clay">Clay</MenuItem>
                                        <MenuItem value="hardcourt">Hardcourt</MenuItem>
                                    </Select>
                                </FormControl>
                            </div>
                            <div className={styles.createButtonContainer}>
                                <Button variant="contained" color="success" onClick={this.createNewCourt}>
                                    create
                                </Button>
                            </div>
                        </CardContent>
                    </Card>
                </Modal>
            </div>
        )
    }
}

export default AdminPage