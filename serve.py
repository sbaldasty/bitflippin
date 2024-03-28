import subprocess

PORT = '8000'

def serve():
    subprocess.run(['python', '-m', 'http.server', '-d', 'out', PORT])

if __name__ == '__main__':
    serve()