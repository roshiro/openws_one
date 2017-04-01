import React, { Component } from 'react';
import { Link } from 'react-router';
import jQuery from 'jquery';

class ApplicationList extends Component {
  constructor() {
    super()

    this.state = {
      applications: []
    }
  }

  componentDidMount() {
    jQuery.ajax({
      method: 'GET',
      url: '/apps',
      success: (data) => {
        this.setState({ applications: data.applications })
      }
    });
  }

  render() {
    return (
      <div className="ApplicationList">
        <Link to='/new_application'>Create new application</Link>
        <table>
          <thead>
            <tr>
              <td>Name</td>
              <td>API Key</td>
            </tr>
          </thead>
          <tbody>
            { this.state.applications.map(app =>
              <tr key={ app.id }>
                <td>{ app.name }</td>
                <td><Link to={`/apps/${app.id}`}>{ app.api_key }</Link></td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    );
  }
}

export default ApplicationList;
