import React from 'react';
import ReactDOM from 'react-dom';
import { IndexRoute, browserHistory, Router, Route } from 'react-router';
import App from './App';
import Dashboard from './pages/Dashboard';
import CreateApplication from './pages/CreateApplication'
import Application from './pages/Application'
import Documentation from './pages/Documentation'

const app = (
  <Router history={browserHistory}>
    <Route path="/dashboard" component={App}>
      <IndexRoute component={Dashboard} />
      <Route path="/new_application" component={() => <CreateApplication url={"/apps"}/>} />
      <Route path="/account" component={ Documentation } />
      <Route path="/apps/:app_id" component={Application} />
      <Route path="/documentation" component={ Documentation } />
    </Route>
  </Router>
)

ReactDOM.render(
  app,
  document.getElementById('root')
);
