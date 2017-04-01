import React, { Component } from 'react';
import jQuery from 'jquery';

class Application extends Component {
  constructor() {
    super()
    this.state = {
      application: {}
    }
  }

  componentWillMount() {
    jQuery.ajax({
      method: 'GET',
      url: `/apps/${this.props.params.app_id}`,
      success: (data) => {
        this.setState({application: data.application})
      }
    })
  }

  render() {
    return (
      <div id='application-page'>
        <h2>
          Application
        </h2>
        Name: { this.state.application.name }
        API Key: { this.state.application.api_key }
      </div>
    );
  }
}

export default Application;
