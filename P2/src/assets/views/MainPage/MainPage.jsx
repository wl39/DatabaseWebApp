import React from "react";
import Card from '../../../components/Card/Card.jsx'
import main from '../../images/main.jpg'
import styles from './MainPage.module.css'

class MainPage extends React.Component {

    render() {
        return (
            <div>
                <img className={styles.image} src={main} alt="main" />
                <div className={styles.greeting}>
                    Get updates on the latest Tennis action in one place!
                </div>
                <div className={styles.main}>
                    <div className={styles.latestHeader} />

                    <Card styleName="cardWhite round relative shadow" inlineStyles={{ width: "100%", marginBottom: "40px", display: "flex", flexDirection: "column" }} >
                        <div className={styles.latestHeader}>
                            In this website you can check all registered players.
                        </div>
                        <div className={styles.latestHeader}>
                            You can check all matches between registered players as well.
                        </div>
                        <div className={styles.latestHeader}>
                            Also you can make a new Player, Match, Veneue and Court.
                        </div>
                    </Card>

                </div>
            </div>
        )
    }

}

export default MainPage;