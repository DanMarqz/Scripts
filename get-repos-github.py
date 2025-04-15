import requests

# Reemplaza con tu token de acceso personal
TOKEN = 'API_KEY'

# URL base para la API de GitHub
BASE_URL = 'https://api.github.com'

# Función para obtener todos los repositorios del usuario
def obtener_repositorios():
    url = f'{BASE_URL}/user/repos'
    headers = {
        'Authorization': f'token {TOKEN}',
        'Accept': 'application/vnd.github.v3+json'
    }
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        print(f'Error al obtener repositorios: {response.content}')
        return []

# Función para cambiar la visibilidad de un repositorio a privado
def hacer_privado(repo_full_name):
    url = f'{BASE_URL}/repos/{repo_full_name}'
    headers = {
        'Authorization': f'token {TOKEN}',
        'Accept': 'application/vnd.github.v3+json'
    }
    data = {
        'private': True
    }
    response = requests.patch(url, headers=headers, json=data)
    if response.status_code == 200:
        print(f'El repositorio {repo_full_name} ahora es privado.')
    else:
        print(f'Error al cambiar la visibilidad de {repo_full_name}: {response.content}')

# Obtener todos los repositorios y cambiar su visibilidad a privado
repositorios = obtener_repositorios()
print(repositorios)
# for repo in repositorios:
#     if not repo['private']:  # Cambia solo los repositorios que no son privados
#         hacer_privado(repo['full_name'])