const user = (state = {}, action) => {
  switch (action.type) {
    case 'LOGOUT':
      return {
        ...state,
        logged_in: false
      }
    default:
      return state
  }
}

export default user
