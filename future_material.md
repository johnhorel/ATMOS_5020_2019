
---
<img src='./images/Anaconda_Logo.png' align=right height=100 style='padding:30px'> 

## Anaconda Launcher
Find and open the Anaconda Launcher and pin it to the dock if you haven't already. This GUI will help you manage software packages we will add another day. To see what is already installed, click then `Environments` label on the side and scroll through the installed packages. If you were to install Python from the Python website, it wouldn't have installed all these other useful tools. Anaconda helps manage these packages.

## Install extra packages
There are a lot of ways to set up custom environments, but we will keep things simple for this class. 

First, let's install some additional packages we will use later.
- Go the the Environments tab and edit the channels.
    - Add `conda-forge` to the channel.
- Now search for `metpy`. This is a package that includes some meteorological tools. Select that.
- Also search for `netcdf4` and select that.
- Click "Apply" at the bottom right corner. Anaconda will check the packages and for any dependancies it requires. Notice that Anaconda is installing a package called `xarray` and `cartopy`. 
    - NOTE: We might need to install `netcdf4` via the command line because it doesn't work in the navigator.












>## NOTE: Python is object-oriented
>Everything is an object. This makes coding very flexible but can also be confusing.  
>
>You can look at the attributes and methods of any variable or object by executing the `dir()` function.
> Example: 
>
>> `a = 4`  
>> `dir(a)`  
>
>We'll tend to use Python in a procedural-programming context that should minimize the confusion.



