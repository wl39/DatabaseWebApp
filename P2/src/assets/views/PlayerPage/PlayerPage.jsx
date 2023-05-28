import React from "react";

import { getViewPlayers } from "../../../axios/axios";
import styles from './PlayerPage.module.css'

import Card from "../../../components/Card/Card";

class PlayerPage extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            playerPage: null
        }
    }

    getAge = (dob) => {
        let milli = new Date() - new Date(dob)
        return Math.floor(milli / 1000 / 60 / 60 / 24 / 365);
    }

    getPlayersCallback = (data) => {
        let playerPage = []

        data.forEach(element => {
            let phoneNumbers = []
            element.phoneNumbers.split(',').forEach((number, index) => {
                phoneNumbers.push(
                    <div>
                        Phone{index + 1} : {number}
                    </div>
                )
            })

            playerPage.push(
                <Card key={element.email} styleName="cardWhite round relative shadow" inlineStyles={{ marginLeft: "auto", marginRight: "auto", width: "65%", marginBottom: "50px", display: "flex", flexDirection: "column" }}>
                    <div>
                        <div className={styles.rowContainer}>
                            <div className={styles.nameContainer}>
                                {element.fullName}
                            </div>
                        </div>
                        <div className={styles.rowContainer}>
                            <div>
                                age:
                            </div>
                            <div>
                                {this.getAge(element.dateOfBirth)}
                            </div>
                        </div>
                        <div className={styles.rowContainer}>
                            <div>
                                ELO:
                            </div>
                            <div>
                                {element.elo}
                            </div>
                        </div>
                        <div className={styles.phoneContainer}>
                            {phoneNumbers}
                        </div>
                    </div>
                </Card>
            )
        });

        this.setState({
            playerPage: playerPage
        })
    }

    componentDidMount() {
        getViewPlayers(this.getPlayersCallback)
    }

    render() {
        return (
            <div className={styles.player}>
                <div className={styles.playerPageHeader}>Players</div>
                {this.state.playerPage}
            </div>
        )
    }

}

export default PlayerPage;