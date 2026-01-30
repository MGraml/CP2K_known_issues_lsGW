# Known issues in the lsGW module of CP2K

## Deviations in GW gaps

Might be linked to number of atoms per interval, as defined here: https://github.com/cp2k/cp2k/blob/5a17cb81585225b1879f458477d369e6221b0789/src/gw_utils.F#L1168

Seems to occur for very small number of atoms per interval, which is linked to small number of ranks and/or small user-specified MEMORY_PER_PROC 

Examples in directory 01_Gap_deviations_in_GW_related_to_MPI_and_mem/

Deviations of at most 30 meV for artificially small MEMORY_PER_PROC or single-rank calculation of 1000 atom systems; within typical HPC specifications, errors are typically smaller than 10 meV

Since HF gaps are identical (within printed accuracy of 1 meV), issue is probably occuring in computation of chi and/or W

### MPI

Exemplary calculations for these deviations related to MPI ranks, comparing 2 vs. 32 vs. 64 ranks

```
00002_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_2_PARTITION_largemem_TIME_72:00:00/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.852744.out: G0W0 direct band gap (eV):                                                3.338
00006_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_32_PARTITION_largemem_TIME_72:00:00/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.852748.out: G0W0 direct band gap (eV):                                                3.350
00007_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_64_PARTITION_largemem_TIME_72:00:00/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.852749.out: G0W0 direct band gap (eV):                                                3.350
```

### user-specified RAM

Exemplary calculations for these deviations related to MEMORY_PER_PROC, comparing 50 MB vs. 5 GB vs. 10 GB user-specified RAM (per MPI rank) to store 3c integrals
```
00001_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_64_TIME_24:00:00_MEMORY_PER_PROC_0.05/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.854878.out: G0W0 direct band gap (eV):                                                3.320
00005_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_64_TIME_24:00:00_MEMORY_PER_PROC_5/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.854882.out: G0W0 direct band gap (eV):                                                3.350
00006_GW_nanographene_64_stripes__NODES_1_TASKS_PER_NODE_64_TIME_24:00:00_MEMORY_PER_PROC_10/OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_.854883.out: G0W0 direct band gap (eV):                                                3.350
```

## Error in mp_world_finalize after successful timetable

Seems to be linked to Number of nodes, see. Directory 02_Error_in_mp_world_finalize

When going from 1 Nodes to 2 Nodes with identical MPI and OMP configuration, the error pops up

Does not seem to influence any results