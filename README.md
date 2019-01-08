# Virtual Environment Setup

This is a simple tutorial to teach you setup your own develop environment.

## Create new virtual environment

You can use the file "create_env.sh" to create a virtual environment that contains TensorFlow 1.12.0 with cuda 10

The command to create a new virtual environment is:
`./create_env.sh <env name>`

## Activate virtual environment

Before you start any program, please activate your virtual environment first, otherwise you wouldn't execute it successfully.

The command to activate virtual environment is:
`conda activate <env name>`

> After you activate your virtual environment, you can see "(<env name>)" at the left most side of your prompt, such as: 

`(test_env) su@2080-server ~ $ ` 
// The `test_env` would be your virtual environment name

## List all your virtual environment

If you forget your virtual environment name, or you want to check all the environment you have, you can use following command to display virtual environments:

`conda env list`

## ***The following operation need to be done while your virtual environment has already activated***

## Install package 

> "vir env" stand for virtual environemnt

Because we need to install packages in your target vir env, there are two approaches to install packages:

1. pip 

`python -m pip install <package>`

***Don't use `pip install <package>`*** 

2. conda

`conda install <packages>


## List packages in your virtual environment

There are also two method to show your packages installed in your virtual environment:

1. pip

This method will display the packages you installed by the pip commands

`pip freeze`

2. conda

This method will display the packages you installed by the conda commands

`conda list`


## Start your jupyter notebook

If you wish to use jupyter notebook to develop your program, you can use following command to start up your jupyter-notebook.

`jupyter-notebook -h <host> -p <port>`

The <host> you specify is your ip address, otherwise the jupyter will automatically running on the localhost(127.0.0.1) that will not be able to access from other host.
The <port> you specify need to be in the range of 1024-49151, if you chose the sample port as others, it would report some error. Just change the port you choose, and try again.
