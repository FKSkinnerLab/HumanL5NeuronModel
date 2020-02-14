#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _Ih_Kole_reg(void);
extern void _Ih_me_reg(void);
extern void _Ih_original_reg(void);
extern void _Ih_shifted_reg(void);
extern void _izap_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," Ih_Kole.mod");
    fprintf(stderr," Ih_me.mod");
    fprintf(stderr," Ih_original.mod");
    fprintf(stderr," Ih_shifted.mod");
    fprintf(stderr," izap.mod");
    fprintf(stderr, "\n");
  }
  _Ih_Kole_reg();
  _Ih_me_reg();
  _Ih_original_reg();
  _Ih_shifted_reg();
  _izap_reg();
}
