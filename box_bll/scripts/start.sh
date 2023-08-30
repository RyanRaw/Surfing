#!/system/bin/sh

module_dir="/data/adb/modules/Surfing"

[ -n "$(magisk -v | grep lite)" ] && module_dir=/data/adb/lite_modules/Surfing

scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})

source ${scripts_dir}/box.config

wait_until_login(){
  # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
  local test_file="/sdcard/Android/.SURFINGTEST"
  true > "$test_file"
  while [ ! -f "$test_file" ] ; do
    true > "$test_file"
    sleep 1
  done
  rm "$test_file"
}

wait_until_login

rm ${pid_file}
mkdir -p ${run_path}

if [ ! -f ${box_path}/manual ] && [ ! -f ${module_dir}/disable ] ; then

  ${scripts_dir}/box.service start >> ${run_path}/run.log 2>> ${run_path}/run_error.log && \
  ${scripts_dir}/box.tproxy enable >> ${run_path}/run.log 2>> ${run_path}/run_error.log
fi