#------------------------------------------------------------------------------
# JupyterHub(Application) configuration
#------------------------------------------------------------------------------

## Maximum number of concurrent servers that can be active at a time.
#  If set to 0, no limit is enforced.
c.JupyterHub.active_server_limit = 0

## Grant admin users permission to access single-user servers.
c.JupyterHub.admin_access = True

## Allow named single-user servers per user
c.JupyterHub.allow_named_servers = True

## Class for authenticating users.
c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'
c.PAMAuthenticator.admin_groups = {'jupyterhub-admins'}

## The public facing URL of the whole JupyterHub application.
# Force the proxy to only listen to connections to 127.0.0.1 (on port 8000)
c.JupyterHub.bind_url = 'http://127.0.0.1:8000'

## The config file to load
c.JupyterHub.config_file = '/srv/jupyterhub/jupyterhub_config.py'

## Generate default config file
c.JupyterHub.generate_config = False

## Shuts down all user servers on logout
c.JupyterHub.shutdown_on_logout = False

## The class to use for spawning single-user servers.
c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'

## The URL the single-user server should start in.
c.Spawner.default_url = '/lab'
