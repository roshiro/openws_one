import React, { Component } from 'react';
import jQuery from 'jquery';
import CollectionList from './../components/CollectionList'
import './Application.scss';

class Application extends Component {
  constructor() {
    super()
    this.state = {
      application: {},
      collections: []
    }
  }

  componentWillMount() {
    jQuery.ajax({
      method: 'GET',
      url: `/apps/${this.props.params.app_id}`,
      success: (data) => {
        this.setState({
          application: data.application,
          collections: data.collections
        })
      }
    })
  }

  render() {
    return (
      <div id='application-page'>
        <h2>
          Application: { this.state.application.name }
        </h2>

        API Key: <code>{ this.state.application.api_key }</code>

        <CollectionList collections={ this.state.collections } />
      </div>
    );
  }
}

export default Application;
