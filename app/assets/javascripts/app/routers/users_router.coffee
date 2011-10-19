class T2Ku.Routers.UsersRouter extends Backbone.Router
  routes:
    '/users':'create_user'
  create_user:->
    alert this