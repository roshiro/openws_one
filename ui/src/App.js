import React, { Component } from 'react';
import { Link } from 'react-router';
import jQuery from 'jquery';
import { Image } from 'semantic-ui-react';
import './App.scss'

class App extends Component {
  constructor() {
    super()

    this.state = {}
  }

  signOutHandler(e) {
    e.preventDefault()
    jQuery.ajax({
      method: 'DELETE',
      url: '/users/sign_out',
      data: {
        authenticity_token: jQuery('meta[name=csrf-token]').attr('content')
      },
      success: (data) => {
        window.location.href = '/'
      }
    })
  }

  render() {
    return (
      <div className="App ui container">
        <div className="App-header">
          <div className="ui secondary  menu">
            <Image src='/static-images/logo.png' className='logo' size='mini' />
            <Link to='/dashboard' className="active item">
              Dashboard
            </Link>
            <Link to='/documentation' className="item">
              Documentation
            </Link>
            <Link to='/documentation' className="item">
              Account
            </Link>
            <div className="right menu">
              <div className="item">
                <div className="ui icon input">
                  <input type="text" placeholder="Search..." />
                  <i className="search link icon"></i>
                </div>
              </div>
              <a className="ui item" id='signout-link' onClick={ this.signOutHandler.bind(this) }>
                Logout
              </a>
            </div>
          </div>
        </div>

        { this.props.children }
      </div>
    );
  }
}

export default App;
