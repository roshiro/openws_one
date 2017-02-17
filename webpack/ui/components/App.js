import React from 'react'
import NavBar from './NavBar'

const App = ({ children, routes }) => (
  <div>
    <NavBar />
    {children}
  </div>
)

export default App
