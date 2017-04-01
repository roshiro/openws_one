import React, { Component } from 'react';
// import './App.css';

class App extends Component {
  constructor() {
    super()

    this.state = {}
  }
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>Welcome to OpenWS!</h2>
        </div>

        { this.props.children }
      </div>
    );
  }
}

export default App;
