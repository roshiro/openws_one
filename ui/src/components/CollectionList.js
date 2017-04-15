import React, { Component } from 'react';
import { Link } from 'react-router';
import { List, Button, Table, Icon } from 'semantic-ui-react';
import jQuery from 'jquery';
import './CollectionList.scss';

class CollectionList extends Component {
  viewCollectionHandler(e, coll) {
    e.preventDefault()

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
        <List>
          { this.props.collections.map(coll =>
            <List.Item key={ coll.id }>
              <List.Icon name='sticky note outline' />
              <List.Content>
                <List.Header>
                  <a href="#" onClick={ this.viewCollectionHandler.bind(this, coll) } name='View'>
                    { coll.name }
                  </a>
                  <a href="#" onClick={ this.viewCollectionHandler.bind(this, coll) } name='Delete'>
                    Delete
                  </a>
                </List.Header>
                <List.Description>
                  Created At: { coll.created_at }
                </List.Description>
              </List.Content>
            </List.Item>
          ) }
        </List>
      </div>
    );
  }
}

export default CollectionList;
