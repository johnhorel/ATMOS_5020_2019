# Brian Blaylock
# Download camera images from the web

import time
import urllib

camera = 'wbbw'
URL = 'http://meso1.chpc.utah.edu/station_cameras/%s_cam/%s_cam_current.jpg' % (camera, camera)

for num in range(3):
    urllib.request.urlretrieve(URL, 'Camera_%02d.jpg' % num)
    time.sleep(10)