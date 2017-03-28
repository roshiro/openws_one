import React, { Component } from 'react';
import ApplicationList from './../components/ApplicationList';

class Dashboard extends Component {
  constructor() {
    super()

    this.state = {}
  }

  render() {
    return (
      <ApplicationList />
    );
  }
}

export default Dashboard;
