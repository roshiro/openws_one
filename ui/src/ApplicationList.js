import React, { Component } from 'react';

class ApplicationList extends Component {
  render() {
    return (
      <div className="ApplicationList">
        <table>
          <thead>
            <tr>
              <td>Name</td>
              <td>API Key</td>
            </tr>
          </thead>
          <tbody>
            { this.props.applications.map(app =>
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
