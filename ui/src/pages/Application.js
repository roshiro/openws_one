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
    this.deleteCollectionHandler = this.deleteCollectionHandler.bind(this)
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

  deleteCollectionHandler(coll, e) {
    let self = this
    e.preventDefault()
    jQuery.ajax({
      method: 'DELETE',
      url: `/apps/${coll.app_id}/collections/${coll.id}`,
      data: {
        authenticity_token: jQuery('meta[name=csrf-token]').attr('content')
      },
      success: (data, textStatus, xhr) => {
        self.state.collections.splice(self.state.collections.indexOf(coll), 1)
        self.setState({ collections: self.state.collections })
        debugger
        if(data.status >= 400) {
          Notifier.error(data.msg, 'Error');
        } else {
          Notifier.success(data.msg, 'Success');
        }
      }
    });
  }

  render() {
    return (
      <div id='application-page'>
        <h2>
          Application: { this.state.application.name }
        </h2>

        API Key: <code>{ this.state.application.api_key }</code>

        <CollectionList collections={ this.state.collections } deleteHandler={ this.deleteCollectionHandler } />
      </div>
    );
  }
}

export default Application;
