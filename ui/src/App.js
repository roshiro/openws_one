import React, { Component } from 'react';
import ApplicationList from './ApplicationList';
import './App.css';

class App extends Component {
  constructor() {
    super()

    this.state = {
      applications: [
        { id: 1, name: 'CakeApp', apiKey: 'dasdsd-bgfhfd45-345fvvf' },
        { id: 2, name: 'MobileApp', apiKey: '22dgth-bgfhfd45-345fvvf' },
      ]
    }
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Welcome to OpenWS!</h2>
        </div>
        <button id='btn-create-app'>Create new application</button>
        <ApplicationList applications={this.state.applications} />
      </div>
    );
  }
}

export default App;
