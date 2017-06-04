import React, { Component } from 'react';
import { Link } from 'react-router';
import jQuery from 'jquery';
import { Image, Button, Icon } from 'semantic-ui-react';
import './App.scss'

class App extends Component {
  constructor() {
    super()

    this.state = {
      active_route: 'dashboard'
    }
  }

  componentWillMount() {
    this.handleActiveMenuItems()
  }

  clickHandler(active_route, e) {
    this.setState({active_route: active_route})
  }

  handleActiveMenuItems() {
    let currentRoute = this.props.location.pathname

    if(currentRoute.indexOf('/account') >= 0) {
      this.setState({active_route: 'account'})
    } else if(currentRoute.indexOf('/dashboard') >= 0) {
      this.setState({active_route: 'dashboard'})
    } else if(currentRoute.indexOf('/documentation') >= 0) {
      this.setState({active_route: 'documentation'})
    }
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

  dashboardState() {
    return this.state.active_route == 'dashboard' ? 'active' : ''
  }

  documentationState() {
    return this.state.active_route == 'documentation' ? 'active' : ''
  }

  accountState() {
    return this.state.active_route == 'account' ? 'active' : ''
  }

  render() {
    return (
      <div className="App ui container">
        <div className="App-header">
          <div className="ui secondary  menu">
            <Image src='/static-images/logo.png' className='logo' size='mini' />
            <Link to='/dashboard' onClick={ this.clickHandler.bind(this, 'dashboard') } className={`item ${this.dashboardState()}`}>
              Dashboard
            </Link>
            <Link to='/documentation' onClick={ this.clickHandler.bind(this, 'documentation') } className={`item ${this.documentationState()}`}>
              Documentation
            </Link>
            <Link to='/account' onClick={ this.clickHandler.bind(this, 'account') } className={`item ${this.accountState()}`}>
              Account
            </Link>
            <div className="right menu">
              <a className="ui item" id='signout-link' onClick={ this.signOutHandler.bind(this) }>
                <Icon name='sign out'/>
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
