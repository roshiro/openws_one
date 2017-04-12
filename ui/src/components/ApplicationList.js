import React, { Component } from 'react';
import { Link } from 'react-router';
import jQuery from 'jquery';
import { Button, Table, Icon } from 'semantic-ui-react';
import './ApplicationList.scss';

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

  deleteHandler(app, e) {
    e.preventDefault();
    jQuery.ajax({
      method: 'DELETE',
      url: `/apps/${app.id}`,
      data: {
        authenticity_token: jQuery('meta[name=csrf-token]').attr('content')
      },
      success: (data) => {
        this.state.applications.splice(this.state.applications.indexOf(app), 1)
        this.setState({ applications: this.state.applications })
      }
    });
  }

  render() {
    return (
      <div className="application-list">
        <div className='page-actions'>
          <Button as={Link} primary to='/new_application'>
            <Icon name='add' />
            New Application
          </Button>
        </div>
        <Table celled striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Name</Table.HeaderCell>
              <Table.HeaderCell>API Key</Table.HeaderCell>
              <Table.HeaderCell></Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            { this.state.applications.map(app =>
              <Table.Row key={ app.id }>
                <Table.Cell>{ app.name }</Table.Cell>
                <Table.Cell><Link to={`/apps/${app.id}`}>{ app.api_key }</Link></Table.Cell>
                <Table.Cell>
                  <a href="#" onClick={ this.deleteHandler.bind(this, app) }>
                    <Icon name='delete' />
                    delete
                  </a>
                </Table.Cell>
              </Table.Row>
            )}
          </Table.Body>
        </Table>
      </div>
    );
  }
}

export default ApplicationList;
