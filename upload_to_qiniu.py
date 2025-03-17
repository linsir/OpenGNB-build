import os
import argparse
from qiniu import Auth, put_file, etag
import qiniu.config

def upload_file_to_qiniu(access_key, secret_key, bucket_name, key, local_file):

    q = Auth(access_key, secret_key)
    token = q.upload_token(bucket_name, key, 3600)
    ret, info = put_file(token, key, local_file, version='v2')
    print(info)
    assert ret['key'] == key
    assert ret['hash'] == etag(local_file)

    return ret

def upload_dir_to_qiniu(access_key, secret_key, bucket_name, local_dir, remote_dir):

    for root, dirs, files in os.walk(local_dir):
        for file in files:
            local_file = os.path.join(root, file)
            key = os.path.join(remote_dir, file)
            upload_file_to_qiniu(access_key, secret_key, bucket_name, key, local_file)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Upload a file to qiniu.')
    parser.add_argument('--access_key', required=True, help='Access Key')
    parser.add_argument('--secret_key', required=True, help='Secret Key')
    parser.add_argument('--bucket_name', required=True, help='Name of the bucket')
    parser.add_argument('--local_dir', required=True, help='local dir')
    parser.add_argument('--remote_dir', required=True, help='remote_dir')
    args = parser.parse_args()
    upload_dir_to_qiniu(args.access_key, args.secret_key, args.bucket_name, args.local_dir, args.remote_dir)