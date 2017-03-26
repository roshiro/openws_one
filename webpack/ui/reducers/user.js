const user = (state, action) => {
  console.log(state)
  switch (action.type) {
    case 'LOGOUT':
      return {
        ...state,
        logged_in: false
      }
    default:
      return {
        ...state,
        logged_in: true
      }
  }
}

export default user
