#!/bin/bash
set -eu
PROJECT_NAME="cicd-demo"
UPLOAD_DIR="/root/jenkins2k8s/${PROJECT_NAME}"
SSH_USER=root
SSH_IP=10.0.0.11
FILE_NAME="${UPLOAD_DIR}/deployment-web.yaml"
IMG_FULL_NAME="harbor.xsc.org/pub-images/nginx-front-web:${VERSION}"
sed -i "s#{{IMAGE_NAME}}#${IMG_FULL_NAME}#g" deployment-web.yaml
#首先删除待上传目录的同名文件
ssh ${SSH_USER}@${SSH_IP} "if [[ -f ${FILE_NAME} ]] ;then rm -f ${FILE_NAME} ;else echo "file not exist"; fi"
#确保部署文件目录存在
ssh ${SSH_USER}@${SSH_IP} "if [[ ! -d  ${UPLOAD_DIR} ]] ;then mkdir -p ${UPLOAD_DIR} ;else echo "Dir have exist"; fi"
#远程复制部署文件
scp -r deployment-web.yaml ${SSH_USER}@${SSH_IP}:${FILE_NAME}
#远程执行部署命令
ssh ${SSH_USER}@${SSH_IP} "kubectl apply -f ${FILE_NAME}"
