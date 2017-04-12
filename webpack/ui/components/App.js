import React from 'react'
import NavBar from './NavBar'

const App = ({ children, routes }) => (
  <div>
    <NavBar />
    {children}
  </div>
)
App.contextTypes = {
  store: React.PropTypes.object
}
export default App
