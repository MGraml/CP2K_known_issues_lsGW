# Known issues in the lsGW module of CP2K

## Error in mp_world_finalize after successful timetable

Seems to be linked to Number of nodes, see. Directory 01_Error_in_mp_world_finalize

When going from 1 Nodes to 2 Nodes with identical MPI and OMP configuration, the error pops up

Does not seem to influence any results