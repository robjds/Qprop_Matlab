# Qprop_Matlab
Some Matlab functions that run Mark Drela's QProp code (found here: http://web.mit.edu/drela/Public/web/qprop/)

The script **PropellerPerformance.m** does an example sweep across a range of throttle settings
The script **PropellerPlotting.m** plots the output of **PropellerPerformance.m**

The function **run_qprop.m** runs the qprop.exe and parses the output file into matlab, see **PropellerPerformance.m** for an example of its use

QProp takes textfile inputs, and since often the key parameter is the motor Kv value, the function **editKv.m** is just a shortcut to edit the motor input file, can be helpful for finding an optimal motor pairing.

All the remaining files are duplicates of the files available for download at http://web.mit.edu/drela/Public/web/qprop/, with a few extra propfiles added based on some 3D scans I took.
