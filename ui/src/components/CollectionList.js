import React, { Component } from 'react';
import { Link } from 'react-router';
import { List, Button, Table, Icon, Header } from 'semantic-ui-react';
import jQuery from 'jquery';
import './CollectionList.scss';

class CollectionList extends Component {
  viewCollectionHandler(coll, e) {
    e.preventDefault()
    window.open('', '_blank')
  }

  render() {
    let msg = null;
    if(this.props.collections.length == 0) {
      msg = <span className='muted'>You don't have any collections for this application yet.</span>
    }

    return (
      <div className="collection-list">
        <h3>Collections</h3>
        { msg }
        <Table basic='very' celled collapsing>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Name</Table.HeaderCell>
              <Table.HeaderCell>Actions</Table.HeaderCell>
            </Table.Row>
          </Table.Header>

          <Table.Body>
            { this.props.collections.map(coll =>
              <Table.Row key={ coll.id }>
                <Table.Cell>
                  <Header as='h4' image>
                    <Icon name='sticky note outline' />
                    <Header.Content>
                      { coll.name }
                      <Header.Subheader>{ coll.created_at }</Header.Subheader>
                    </Header.Content>
                  </Header>
                </Table.Cell>
                <Table.Cell>
                  <a href="#" onClick={ (e) => this.viewCollectionHandler(coll, e) }>
                    <Icon name='external square' />
                    view
                  </a>
                  <a href="#" onClick={ (e) => this.props.deleteHandler(coll, e) }>
                    <Icon name='delete' />
                    delete
                  </a>
                </Table.Cell>
              </Table.Row>
            ) }
          </Table.Body>
        </Table>
      </div>
    );
  }
}

export default CollectionList;
