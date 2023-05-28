import React from "react";

import { getMatchWithNames, getVenues } from "../../../axios/axios";
import styles from './MatchPage.module.css'

import Card from "../../../components/Card/Card";

import Button from '@mui/material/Button';

import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Checkbox from '@mui/material/Checkbox';
import { Link } from "react-router-dom";

class MatchPage extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            matchPage: null,
            venues: [],
            venuesChecked: [],
            surface: ["Grass", "Clay", "Hardcourt"],
            surfacesChecked: [],
            venueQuery: "",
            surfaceQuery: "",
        }
    }

    handleVenueToggle = (value) => {
        let currentIndex = this.state.venuesChecked.indexOf(value);
        let newChecked = [...this.state.venuesChecked];

        if (currentIndex === -1) {
            newChecked.push(value);
        } else {
            newChecked.splice(currentIndex, 1);
        }
        let newQuery;
        if (newChecked.length === 0) {
            newQuery = ""
        } else {
            newQuery = "venue=" + newChecked.join() + "&"
        }

        this.setState({
            venuesChecked: [...newChecked],
            venueQuery: newQuery
        })

        getMatchWithNames(this.getMatchWithNamesCallback, newQuery + this.state.surfaceQuery);
    }

    handleSurfaceToggle = (value) => {
        let currentIndex = this.state.surfacesChecked.indexOf(value);
        let newChecked = [...this.state.surfacesChecked];

        if (currentIndex === -1) {
            newChecked.push(value);
        } else {
            newChecked.splice(currentIndex, 1);
        }

        let newQuery;
        if (newChecked.length === 0) {
            newQuery = ""
        } else {
            newQuery = "surface=" + newChecked.join().toLocaleLowerCase() + "&"
        }

        this.setState({
            surfacesChecked: [...newChecked],
            surfaceQuery: newQuery
        })

        getMatchWithNames(this.getMatchWithNamesCallback, this.state.venueQuery + newQuery);
    }

    getVenuesCallback = (data) => {
        let venues = []

        data.forEach(element => {
            venues.push(
                element.name
            )
        })

        this.setState({
            venues: venues
        })
    }

    getMatchWithNamesCallback = (data) => {
        let matchPage = []
        for (let i = 0; i < data.length; i += 2) {
            console.log(data[i])
            console.log(data[i + 1])
            matchPage.push(
                <Card key={i} styleName="cardWhite round relative shadow" inlineStyles={{ marginLeft: "auto", marginRight: "auto", width: "60%", marginBottom: "50px", display: "flex", flexDirection: "column" }}>
                    <div>
                        <div className={styles.matchTitle}>
                            <div>Match in {data[i].venueName}</div>
                            <div>{data[i].dateOfPlayed}</div>
                        </div>
                        <div className={styles.courtDetail}>
                            <div>Court: {data[i].courtNumber}</div>
                            <div>Type: {data[i].surface}</div>
                        </div>
                        <div className={styles.userDetails}>
                            <div>
                                <div className={data[i].email === data[i].winner ? styles.winner : styles.plain}>{data[i].elo}<div className={data[i].email === data[i].winner ? styles.arrowUp : styles.arrowDown} /></div>
                                <div className={data[i].email === data[i].winner ? styles.winner : styles.plain}>{data[i].fullName}</div>

                            </div>
                            <div className={styles.versus}>VS</div>
                            <div>
                                <div className={data[i + 1].email === data[i].winner ? styles.winner : styles.plain}>{data[i + 1].elo}<div className={data[i + 1].email === data[i].winner ? styles.arrowUp : styles.arrowDown} /></div>
                                <div className={data[i + 1].email === data[i].winner ? styles.winner : styles.plain}>{data[i + 1].fullName}</div>
                            </div>
                        </div>
                    </div>
                    <div className={styles.buttonContainer}>
                        <Button className={styles.linkContainer}>
                            <Link className={styles.matchDetails} to={"/match/" + data[i].id}>
                                Match Details...
                            </Link>
                        </Button>
                    </div>
                </Card>
            )
        }

        this.setState({
            matchPage: matchPage
        })

        getVenues(this.getVenuesCallback);
    }

    componentDidMount() {
        getMatchWithNames(this.getMatchWithNamesCallback, "");
    }

    render() {
        return (
            <div className={styles.match}>
                <div className={styles.matchPageHeader}>Matches</div>
                <div className={styles.matchOption}>
                    <List sx={{ width: '360px', maxWidth: 480, bgcolor: 'background.paper' }}>
                        {this.state.venues.map((value) => {
                            const labelId = `checkbox-list-label-${value}`;

                            return (
                                <ListItem
                                    key={value}
                                    disablePadding
                                >
                                    <ListItemButton role={undefined} onClick={() => this.handleVenueToggle(value)} dense>
                                        <ListItemText id={labelId} primary={value} />
                                        <ListItemIcon>
                                            <Checkbox
                                                edge="start"
                                                checked={this.state.venuesChecked.indexOf(value) !== -1}
                                                tabIndex={-1}
                                                disableRipple
                                                inputProps={{ 'aria-labelledby': labelId }}
                                            />
                                        </ListItemIcon>
                                    </ListItemButton>
                                </ListItem>
                            );
                        })}
                    </List>
                    <List sx={{ width: '100%', maxWidth: 480, bgcolor: 'background.paper' }}>
                        {this.state.surface.map((value) => {
                            const labelId = `checkbox-list-label-${value}`;

                            return (
                                <ListItem
                                    key={value}
                                    disablePadding
                                >
                                    <ListItemButton role={undefined} onClick={() => this.handleSurfaceToggle(value)} dense>
                                        <ListItemText id={labelId} primary={value} />
                                        <ListItemIcon>
                                            <Checkbox
                                                edge="start"
                                                checked={this.state.surfacesChecked.indexOf(value) !== -1}
                                                tabIndex={-1}
                                                disableRipple
                                                inputProps={{ 'aria-labelledby': labelId }}
                                            />
                                        </ListItemIcon>
                                    </ListItemButton>
                                </ListItem>
                            );
                        })}
                    </List>
                </div>
                {this.state.matchPage}
            </div>
        )
    }

}

export default MatchPage;