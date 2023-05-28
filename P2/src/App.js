import { Component } from 'react';
import { Route, Switch, withRouter, Redirect } from 'react-router-dom'
import Header from './components/Header/Header.jsx'
import './App.css';
import MainPage from './assets/views/MainPage/MainPage.jsx';
import PlayerPage from './assets/views/PlayerPage/PlayerPage.jsx';
import AdminPage from './assets/views/AdminPage/AdminPage.jsx';
import MatchPage from './assets/views/MatchPage/MatchPage.jsx';
import MatchDetailPage from './assets/views/MatchPage/MatchDetail.jsx';

class App extends Component {

  render() {
    return (
      <div className="Tennis">
        <Header location={this.props.location} />
        <Switch>
          <Route path='/admin' component={AdminPage} />
          <Route path='/match/:id' component={MatchDetailPage} />
          <Route path='/match' component={MatchPage} />
          <Route path='/player' component={PlayerPage} />
          <Route path='/' exact component={MainPage} />
          <Redirect to='/' />
        </Switch>
      </div>
    );
  }
}

export default withRouter(App);
