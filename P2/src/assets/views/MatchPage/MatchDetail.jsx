import React from "react";
import { getMatches, getFullName } from "../../../axios/axios";
import { Card } from "@mui/material";
import { CardContent } from "@mui/material";
import styles from './MatchPage.module.css'


class MatchDetailPage extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            matchPage: {},
            p1user: "",
            p1userELO: "",
            p2user: "",
            p2userELO: "",
            court: {
                number: 0,
                surface: "",
                venue: {
                    name: "",
                }
            },
            datePlayed: "",
            set:
                [
                    {
                        "setNumber": 1,
                        "p1Score": 0,
                        "p2Score": 0
                    },
                    {
                        "setNumber": 2,
                        "p1Score": 0,
                        "p2Score": 0
                    },
                    {
                        "setNumber": 3,
                        "p1Score": 0,
                        "p2Score": 0
                    }
                ],
            winner: 0,
            setTag: [],
        }
    }

    getFullNameCallback = (data, user) => {
        if (user === 1) {
            this.setState({
                p1user: data.fullName,
                p1userELO: data.elo
            })
        } else if (user === 2) {
            this.setState({
                p2user: data.fullName,
                p2userELO: data.elo
            })
        }
    }

    getMatchesCallback = (data) => {
        console.log(data)
        getFullName(this.getFullNameCallback, data[0].p1Email, 1)
        getFullName(this.getFullNameCallback, data[0].p2Email, 2)


        let p1 = 0;
        let p2 = 0;

        let setTag = []

        data[0].set.forEach(element => {
            if (element.p1Score > element.p2Score) {
                p1++;
            } else {
                p2++;
            }
            setTag.push(
                <div className={styles.setContainer}>
                    <div className={styles.setHeader}>
                        Set {element.setNumber}
                    </div>
                    <div className={styles.scoresContainer}>
                        <div>{element.p1Score}</div>
                        <div>{element.p2Score}</div>
                    </div>
                </div>
            )
        })

        this.setState({
            court: data[0].court,
            datePlayed: data[0].datePlayed,
            set: data[0].set,
            winner: p1 > p2 ? 1 : 2,
            setTag: setTag
        })
    }

    componentDidMount() {
        getMatches(this.getMatchesCallback, "?id=" + this.props.match.params.id)
    }

    render() {
        return (
            <div className={styles.match}>
                <Card sx={{ width: "75%", padding: "10px 5px", borderRadius: "10px", margin: "0px auto" }}>
                    <CardContent>
                        <div>
                            <div className={styles.matchTitle}>
                                <div>Match in {this.state.court.venue.name}</div>
                                <div>{this.state.datePlayed}</div>
                            </div>
                            <div className={styles.courtDetail}>
                                <div>Court: {this.state.court.number}</div>
                                <div>Type: {this.state.court.surface}</div>
                            </div>
                            <div className={styles.userDetails}>
                                <div>
                                    <div className={this.state.winner === 1 ? styles.winner : styles.plain}>{this.state.p1userELO}<div className={this.state.winner === 1 ? styles.arrowUp : styles.arrowDown} /></div>
                                    <div className={this.state.winner === 1 ? styles.winner : styles.plain}>{this.state.p1user}</div>

                                </div>
                                <div className={styles.versus}>VS</div>
                                <div>
                                    <div className={this.state.winner === 2 ? styles.winner : styles.plain}>{this.state.p2userELO}<div className={this.state.winner === 2 ? styles.arrowUp : styles.arrowDown} /></div>
                                    <div className={this.state.winner === 2 ? styles.winner : styles.plain}>{this.state.p2user}</div>
                                </div>
                            </div>
                        </div>
                        <div className={styles.setsContainer}>
                            {this.state.setTag}
                        </div>
                    </CardContent>
                </Card>
            </div>
        )
    }

}

export default MatchDetailPage;