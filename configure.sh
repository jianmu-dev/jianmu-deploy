#!/bin/bash

# 数据库密码
export mysql_root_password=123456
# 存放平台任务日志目录
export task_log_file_path=/mnt/jianmu/ci/log
# 存放平台任务定义目录
export task_def_file_path=/mnt/jianmu/ci/task_def
# 后台服务tag
export server_tag=0.2
# 前端tag
export web_tag=0.2
# 平台admin用户密码
export jianmu_password=123456
#------------------------------------------------------------------------------

function ergodic(){
    for file in ` ls $1 `
    do
        if [ -d $1"/"$file ]
        then
             ergodic $1"/"$file
        else
             envsubst '${mysql_root_password},${task_log_file_path},${task_def_file_path},${server_tag},${web_tag},${jianmu_password}' < $1"/"$file > $1"/"${file%.*}
             rm -f $1"/"$file
        fi
    done
}

dir=$(cd "$(dirname "$0")"; pwd)

cd $dir

TEMP_PATH="sample"
OUTPUT_PATH="temp"
cp -r $TEMP_PATH $OUTPUT_PATH
ergodic $OUTPUT_PATH

mv $OUTPUT_PATH/* .

rm -rf $OUTPUT_PATH

