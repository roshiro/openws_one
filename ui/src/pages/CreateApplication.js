import React, { Component } from 'react';
import { browserHistory } from 'react-router'
import jQuery from 'jquery';

class CreateApplication extends Component {
  constructor(props) {
    super(props);
    this.state = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();

    jQuery.ajax({
      method: 'POST',
      url: this.props.url,
      data: {
        app: {
          name: this.state.value
        },
        authenticity_token: jQuery('meta[name=csrf-token]').attr('content')
      },
      success: (data) => {
        browserHistory.push(`/apps/${data.id}`);
      }
    });
  }

  handleChange(event) {
    this.setState({value: event.target.value})
  }

  render() {
    return (
      <div id='create-application-form'>
        <h2>
          New Application
        </h2>
        <form onSubmit={this.handleSubmit}>
          <label>
            Name:
            <input type="text" value={this.state.value} onChange={this.handleChange} />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
}

export default CreateApplication;
