# Tcl script to run LVS on the ICRG ultra-low-power comparator

if {[catch {set PDK_ROOT $::env(PDK_ROOT)}]} {set PDK_ROOT /usr/local/share/pdk}
if {[catch {set PDK $::env(PDK)}]} {set PDK sky130A}

set pdklib ${PDK_ROOT}/${PDK}
set techlibs ${pdklib}/libs.tech
set reflibs ${pdklib}/libs.ref

set setupfile ${techlibs}/netgen/sky130A_setup.tcl
set hvlib ${reflibs}/sky130_fd_sc_hvl/spice/sky130_fd_sc_hvl.spice
set hdlib ${reflibs}/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice

set circuit1 [readnet spice ../netlist/layout/sky130_iic_ip__audiodac_drv.spice]
set circuit2 [readnet spice $hvlib]

readnet spice $hdlib $circuit2
readnet spice ../netlist/schematic/sky130_iic_ip__audiodac_drv.spice $circuit2

# debug on

lvs "$circuit1 sky130_iic_ip__audiodac_drv" "$circuit2 sky130_iic_ip__audiodac_drv" \
        $setupfile sky130_iic_ip__audiodac_drv_comp.out
