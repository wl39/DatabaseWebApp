import React from 'react'
import { Link } from 'react-router-dom'
import Button from '../Button/Button'
import styles from './Header.module.css'

const mainButton = {
    width: "140px",
    height: "50px",
    lineHeight: "50px"
}
const playerButton = {
    width: "100px",
    height: "50px",
    lineHeight: "50px"
}

const headerScrolled = {
    backgroundColor: "white",
    boxShadow: "0px 3px 10px rgb(0 0 0 / 20%)"
}

class Header extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            scrolled: false,
            login: false,
            register: false,
            searchQuery: "",
        }
    }


    listenScroll = () => {
        if (window.pageYOffset >= 200) {
            this.setState({
                scrolled: true
            })
        } else {
            this.setState({
                scrolled: false
            })
        }
    }

    componentDidMount() {
        window.addEventListener('scroll', this.listenScroll)
    }

    componentWillUnmount() {
        window.removeEventListener('scroll', this.listenScroll);
    }

    render() {
        return (
            <div style={this.state.scrolled ? headerScrolled : {}} className={this.props.location.pathname === "/" ? styles.header : styles.headerNotMain}>

                <Link to="/" className={styles.link}>
                    <Button text="Tendrews"
                        inlineStyle={mainButton}
                        styleName="transparent"
                    />
                </Link>
                {(this.props.location.pathname !== "/admin")

                    ?
                    <Link to="/admin" className={styles.link}>
                        <Button text="Add"
                            inlineStyle={playerButton}
                            styleName="transparent"
                        />
                    </Link>
                    : null}
                {(this.props.location.pathname === "/" || this.props.location.pathname !== "/player")
                    ?
                    <Link to="/player" className={styles.link}>
                        <Button text="Player"
                            inlineStyle={playerButton}
                            styleName="transparent"
                        />
                    </Link>
                    : null}
                {(this.props.location.pathname !== "/match")

                    ?
                    <Link to="/match" className={styles.link}>
                        <Button text="Match"
                            inlineStyle={playerButton}
                            styleName="transparent"
                        />
                    </Link>
                    : null}
            </div>
        )
    }
}

export default Header