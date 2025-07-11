/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_12487(char*, char *);
IKI_DLLESPEC extern void execute_12488(char*, char *);
IKI_DLLESPEC extern void execute_12745(char*, char *);
IKI_DLLESPEC extern void execute_12491(char*, char *);
IKI_DLLESPEC extern void execute_12492(char*, char *);
IKI_DLLESPEC extern void execute_12489(char*, char *);
IKI_DLLESPEC extern void execute_196(char*, char *);
IKI_DLLESPEC extern void execute_12483(char*, char *);
IKI_DLLESPEC extern void execute_12484(char*, char *);
IKI_DLLESPEC extern void execute_12485(char*, char *);
IKI_DLLESPEC extern void execute_12486(char*, char *);
IKI_DLLESPEC extern void execute_29063(char*, char *);
IKI_DLLESPEC extern void execute_29064(char*, char *);
IKI_DLLESPEC extern void execute_29065(char*, char *);
IKI_DLLESPEC extern void execute_29066(char*, char *);
IKI_DLLESPEC extern void execute_29067(char*, char *);
IKI_DLLESPEC extern void execute_29068(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[18] = {(funcp)execute_12487, (funcp)execute_12488, (funcp)execute_12745, (funcp)execute_12491, (funcp)execute_12492, (funcp)execute_12489, (funcp)execute_196, (funcp)execute_12483, (funcp)execute_12484, (funcp)execute_12485, (funcp)execute_12486, (funcp)execute_29063, (funcp)execute_29064, (funcp)execute_29065, (funcp)execute_29066, (funcp)execute_29067, (funcp)execute_29068, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 18;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/arbiter_puf_behav/xsim.reloc",  (void **)funcTab, 18);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/arbiter_puf_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/arbiter_puf_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/arbiter_puf_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/arbiter_puf_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/arbiter_puf_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
