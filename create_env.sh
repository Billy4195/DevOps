#!/bin/bash

GREEN="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0;0m"

activate_script=~/anaconda3/envs/$1/etc/conda/activate.d/activate.sh
deactivate_script=~/anaconda3/envs/$1/etc/conda/deactivate.d/deactivate.sh

source ~/anaconda3/etc/profile.d/conda.sh
echo -e "${GREEN}1. Create conda virenv${NC}"
conda create -n $1 python=3.6 pip -y 2>/dev/null >/dev/null

echo -e "${GREEN}2. Create activation setup script${NC}"
mkdir -p ~/anaconda3/envs/$1/etc/conda/activate.d
touch $activate_script
echo -e "#!/bin/sh" > $activate_script
echo -e 'ORIGINAL_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:' >> $activate_script
echo -e 'export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:/usr/local/cuda-10.0/extras/CUPTI/lib64:/lib/nccl/cuda-10:$LD_LIBRARY_PATH' >> $activate_script
chmod u+x $activate_script
# For 1.4.1 path add /usr/local/lib

echo -e "${GREEN}3. Creat deactivation cleanup script${NC}"
mkdir -p ~/anaconda3/envs/$1/etc/conda/deactivate.d
touch $deactivate_script 
echo -e "#!/bin/sh" > $deactivate_script
echo -e 'export LD_LIBRARY_PATH=$ORIGINAL_LD_LIBRARY_PATH' >> $deactivate_script
echo -e 'unset ORIGINAL_LD_LIBRARY_PATH' >> $deactivate_script
chmod u+x $deactivate_script

echo -e "${GREEN}4. Install tensorflow 1.12.0 with cuda 10.0 support by using community built wheel${NC}"
conda activate $1
python -m pip install --no-cache-dir https://github.com/evdcush/TensorFlow-wheels/releases/download/tf-1.12.0-gpu-10.0/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl 2>/dev/null >/dev/null 
python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))" 2>/dev/null >/dev/null
conda install nb_conda -y
if [ $? -eq 0 ]
then
        echo -e "${GREEN}Success${NC}"
else
        echo -e "${RED}Failed: couldn't load tensorflow${NC}"
fi
