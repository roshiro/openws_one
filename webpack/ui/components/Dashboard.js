import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux'

class Dashboard extends Component {
  componentWillMount = () => {
    const { store } = this.context
    store.dispatch({ type: 'LOGOUT', id: 1, name: 'Rafael' })
    console.log(store.getState())
  }

  render() {
    const { store } = this.context

    console.log(store.getState())
    return (
      <div className="dashboard">
        This is the dashboard
      </div>
    )
  }
}
Dashboard.contextTypes = {
  store: React.PropTypes.object
}

Dashboard = connect()(Dashboard)

export default Dashboard
