import React, { Component } from 'react';
import { Link } from 'react-router';

class ApplicationList extends Component {
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
                <td>{ app.apiKey }</td>
                <td>{ app.name }</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    );
  }
}

export default ApplicationList;
