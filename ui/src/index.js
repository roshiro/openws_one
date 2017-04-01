import React from 'react';
import ReactDOM from 'react-dom';
import { IndexRoute, browserHistory, Router, Route } from 'react-router';
import App from './App';
import Dashboard from './pages/Dashboard';
import CreateApplication from './pages/CreateApplication'
// import './index.css';

const app = (
  <Router history={browserHistory}>
    <Route path="/dashboard" component={App}>
      <IndexRoute component={Dashboard} />
      <Route path="/new_application" component={CreateApplication} />
    </Route>
  </Router>
)

ReactDOM.render(
  app,
  document.getElementById('root')
);
