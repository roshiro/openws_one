import React, { Component } from 'react';
import { Link } from 'react-router';
import { List } from 'semantic-ui-react';
import jQuery from 'jquery';
import './CollectionList.scss';

class CollectionList extends Component {
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
          { this.props.collections.map(col =>
            <List.Item>{ col.name }</List.Item>
          ) }
        </List>
      </div>
    );
  }
}

export default CollectionList;
