#!/bin/bash

# Variables
BUCKET_NAME= ##Bucket name  
LOCAL_UPLOAD_DIR="../upload"
LOCAL_DOWNLOAD_DIR="../download"
AWS_REGION= ##Region


#Se cargan archivos al bucket
if [ -d "$LOCAL_UPLOAD_DIR" ]; then
  echo "Uploading files from $LOCAL_UPLOAD_DIR to S3 bucket $BUCKET_NAME"
  

  for file in "$LOCAL_UPLOAD_DIR"/*; do
    if [ -f "$file" ]; then
      echo "Uploading $file to s3://$BUCKET_NAME/"
      aws s3 cp "$file" s3://$BUCKET_NAME/ #Se puede agregar --recursive para subir todos los archivos de la carpeta
    fi
  done
else
  echo "Directory $LOCAL_UPLOAD_DIR does not exist!"
  exit 1
fi


echo "Listing files in S3 bucket $BUCKET_NAME:"
aws s3 ls s3://$BUCKET_NAME/


if [ ! -d "$LOCAL_DOWNLOAD_DIR" ]; then
  mkdir -p "$LOCAL_DOWNLOAD_DIR"
fi


#Se descargan de forma recursiva los archivos del bucket a la máquina local
echo "Downloading files from S3 bucket $BUCKET_NAME to $LOCAL_DOWNLOAD_DIR"
aws s3 cp s3://$BUCKET_NAME/ "$LOCAL_DOWNLOAD_DIR" --recursive


echo "Files downloaded to $LOCAL_DOWNLOAD_DIR:"
ls "$LOCAL_DOWNLOAD_DIR"