import boto3
import os

s3 = boto3.client('s3')
directory = '/Users/mariana/Desktop/Taller AWS-FastAPI/upload'
bucket_name = 'user-01-smm-ueia-so'

s3.upload_file('/path/vim commands.txt', bucket_name, 'vim commands.txt')

response = s3.list_objects_v2(Bucket=bucket_name)
for obj in response.get('Contents', []):
    print(obj['Key'])

s3.download_file(bucket_name, 'vim commands.txt', '/path/download/downloaded_vim.txt')

# Para subir un directorio completo (con todos los archivos y subdirectorios)
for filename in os.listdir(directory):
    s3.upload_file(os.path.join(directory, filename), bucket_name, filename)

## Para descargar un directorio completo
for obj in response.get('Contents', []):
    s3.download_file(bucket_name, obj['Key'], os.path.join('/path/download', obj['Key']))