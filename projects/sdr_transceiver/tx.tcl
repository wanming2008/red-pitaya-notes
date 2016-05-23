# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_0 {
  DIN_WIDTH 8 DIN_FROM 0 DIN_TO 0 DOUT_WIDTH 1
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_1 {
  DIN_WIDTH 64 DIN_FROM 31 DIN_TO 0 DOUT_WIDTH 32
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_2 {
  DIN_WIDTH 64 DIN_FROM 47 DIN_TO 32 DOUT_WIDTH 16
}

# Create axi_axis_writer
cell pavel-demin:user:axi_axis_writer:1.0 writer_0 {
  AXI_DATA_WIDTH 32
} {
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create fifo_generator
cell xilinx.com:ip:fifo_generator:13.1 fifo_generator_0 {
  PERFORMANCE_OPTIONS First_Word_Fall_Through
  INPUT_DATA_WIDTH 32
  INPUT_DEPTH 8192
  OUTPUT_DATA_WIDTH 64
  OUTPUT_DEPTH 4096
  WRITE_DATA_COUNT true
  WRITE_DATA_COUNT_WIDTH 14
} {
  clk /ps_0/FCLK_CLK0
  srst slice_0/Dout
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo:1.0 fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 64
} {
  S_AXIS writer_0/M_AXIS
  FIFO_READ fifo_generator_0/FIFO_READ
  FIFO_WRITE fifo_generator_0/FIFO_WRITE
  aclk /ps_0/FCLK_CLK0
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 8
  M_TDATA_NUM_BYTES 4
} {
  S_AXIS fifo_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create floating_point
cell xilinx.com:ip:floating_point:7.1 fp_0 {
  OPERATION_TYPE Float_to_fixed
  RESULT_PRECISION_TYPE Custom
  C_RESULT_EXPONENT_WIDTH 2
  C_RESULT_FRACTION_WIDTH 22
  HAS_ARESETN true
} {
  S_AXIS_A conv_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_0 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 24
  COEFFICIENTVECTOR {-1.6476779326e-08, -4.7313040193e-08, -7.8901502051e-10, 3.0928184366e-08, 1.8617143797e-08, 3.2741749031e-08, -6.2888230595e-09, -1.5224902191e-07, -8.3043034177e-08, 3.1447154481e-07, 3.0558591388e-07, -4.7407472231e-07, -7.1338208245e-07, 5.4720642312e-07, 1.3343968996e-06, -4.1404014458e-07, -2.1501364740e-06, -6.7761913755e-08, 3.0749214979e-06, 1.0368754281e-06, -3.9436599952e-06, -2.5914915827e-06, 4.5145643319e-06, 4.7470208528e-06, -4.4920326965e-06, -7.3969688278e-06, 3.5715182183e-06, 1.0287740639e-05, -1.5035492427e-06, -1.3018595893e-05, -1.8317448283e-06, 1.5075535438e-05, 6.3534983590e-06, -1.5902951311e-05, -1.1730365588e-05, 1.5008475684e-05, 1.7368862515e-05, -1.2092392663e-05, -2.2462877524e-05, 7.1687334328e-06, 2.6098665592e-05, -6.6380331062e-07, -2.7424527452e-05, -6.5490388076e-06, 2.5860011051e-05, 1.3201495544e-05, -2.1313675561e-05, -1.7786368802e-05, 1.4364484480e-05, 1.8815867956e-05, -6.3574323624e-06, -1.5159459894e-05, -6.3334026444e-07, 6.4144996905e-06, 4.0057868811e-06, 6.7562198978e-06, -1.0037775645e-06, -2.2398505461e-05, -1.0762183655e-05, 3.7225838528e-05, 3.2696402984e-05, -4.6850868894e-05, -6.4642382048e-05, 4.6250098363e-05, 1.0438423234e-04, -3.0533038160e-05, -1.4743156199e-04, -4.1214739065e-06, 1.8715282729e-04, 5.9463790336e-05, -2.1533648610e-04, -1.3428016307e-04, 2.2318409551e-04, 2.2379728301e-04, -2.0266416739e-04, -3.1956848177e-04, 1.4806955570e-04, 4.0997896669e-04, -5.7549525678e-05, -4.8143100734e-04, -6.5664250183e-05, 5.2016055478e-04, 2.1262555239e-04, -5.1453009075e-04, -3.6893917133e-04, 4.5739014968e-04, 5.1588094769e-04, -3.4842166218e-04, -6.3276844262e-04, 1.9562249045e-04, 7.0006534819e-04, -1.5805731771e-05, -7.0308372866e-04, -1.6633637879e-04, 6.3573740627e-04, 3.2076368720e-04, -5.0373201756e-04, -4.1617002201e-04, 3.2652697014e-04, 4.2530654888e-04, -1.3746226576e-04, -3.3097994186e-04, -1.8404817667e-05, 1.3192764737e-04, 8.8947883829e-05, 1.5237487323e-04, -2.1972285856e-05, -4.7901230802e-04, -2.2614865531e-04, 7.8143745719e-04, 6.8024323892e-04, -9.7364112180e-04, -1.3372168029e-03, 9.5730129734e-04, 2.1578719151e-03, -6.3290725792e-04, -3.0618618278e-03, -8.6303182400e-05, 3.9267972154e-03, 1.2587181052e-03, -4.5923816659e-03, -2.8985880243e-03, 4.8699361895e-03, 4.9618696940e-03, -4.5570643211e-03, -7.3354008652e-03, 3.4565471664e-03, 9.8308217838e-03, -1.3979524282e-03, -1.2184038999e-02, -1.7400129884e-03, 1.4059843985e-02, 6.0074340907e-03, -1.5062994324e-02, -1.1368077347e-02, 1.4745891561e-02, 1.7684046304e-02, -1.2616525140e-02, -2.4708771785e-02, 8.1298213428e-03, 3.2080859216e-02, -6.4555942041e-04, -3.9310346796e-02, -1.0689785909e-02, 4.5729185207e-02, 2.7244386647e-02, -5.0313964510e-02, -5.1705559625e-02, 5.1013584288e-02, 9.0554101727e-02, -4.1608267431e-02, -1.6372217613e-01, -1.0778637610e-02, 3.5637654127e-01, 5.5478469553e-01, 3.5637654127e-01, -1.0778637610e-02, -1.6372217613e-01, -4.1608267431e-02, 9.0554101727e-02, 5.1013584288e-02, -5.1705559625e-02, -5.0313964510e-02, 2.7244386647e-02, 4.5729185207e-02, -1.0689785909e-02, -3.9310346796e-02, -6.4555942041e-04, 3.2080859216e-02, 8.1298213428e-03, -2.4708771785e-02, -1.2616525140e-02, 1.7684046304e-02, 1.4745891561e-02, -1.1368077347e-02, -1.5062994324e-02, 6.0074340907e-03, 1.4059843985e-02, -1.7400129884e-03, -1.2184038999e-02, -1.3979524282e-03, 9.8308217838e-03, 3.4565471664e-03, -7.3354008652e-03, -4.5570643211e-03, 4.9618696940e-03, 4.8699361895e-03, -2.8985880243e-03, -4.5923816659e-03, 1.2587181052e-03, 3.9267972154e-03, -8.6303182400e-05, -3.0618618278e-03, -6.3290725792e-04, 2.1578719151e-03, 9.5730129734e-04, -1.3372168029e-03, -9.7364112180e-04, 6.8024323892e-04, 7.8143745719e-04, -2.2614865531e-04, -4.7901230802e-04, -2.1972285856e-05, 1.5237487323e-04, 8.8947883829e-05, 1.3192764737e-04, -1.8404817667e-05, -3.3097994186e-04, -1.3746226576e-04, 4.2530654888e-04, 3.2652697014e-04, -4.1617002201e-04, -5.0373201756e-04, 3.2076368720e-04, 6.3573740627e-04, -1.6633637879e-04, -7.0308372866e-04, -1.5805731771e-05, 7.0006534819e-04, 1.9562249045e-04, -6.3276844262e-04, -3.4842166218e-04, 5.1588094769e-04, 4.5739014968e-04, -3.6893917133e-04, -5.1453009075e-04, 2.1262555239e-04, 5.2016055478e-04, -6.5664250183e-05, -4.8143100734e-04, -5.7549525678e-05, 4.0997896669e-04, 1.4806955570e-04, -3.1956848177e-04, -2.0266416739e-04, 2.2379728301e-04, 2.2318409551e-04, -1.3428016307e-04, -2.1533648610e-04, 5.9463790336e-05, 1.8715282729e-04, -4.1214739065e-06, -1.4743156199e-04, -3.0533038160e-05, 1.0438423234e-04, 4.6250098363e-05, -6.4642382048e-05, -4.6850868894e-05, 3.2696402984e-05, 3.7225838528e-05, -1.0762183655e-05, -2.2398505461e-05, -1.0037775645e-06, 6.7562198978e-06, 4.0057868811e-06, 6.4144996905e-06, -6.3334026444e-07, -1.5159459894e-05, -6.3574323624e-06, 1.8815867956e-05, 1.4364484480e-05, -1.7786368802e-05, -2.1313675561e-05, 1.3201495544e-05, 2.5860011051e-05, -6.5490388076e-06, -2.7424527452e-05, -6.6380331062e-07, 2.6098665592e-05, 7.1687334328e-06, -2.2462877524e-05, -1.2092392663e-05, 1.7368862515e-05, 1.5008475684e-05, -1.1730365588e-05, -1.5902951311e-05, 6.3534983590e-06, 1.5075535438e-05, -1.8317448283e-06, -1.3018595893e-05, -1.5035492427e-06, 1.0287740639e-05, 3.5715182183e-06, -7.3969688278e-06, -4.4920326965e-06, 4.7470208528e-06, 4.5145643319e-06, -2.5914915827e-06, -3.9436599952e-06, 1.0368754281e-06, 3.0749214979e-06, -6.7761913755e-08, -2.1501364740e-06, -4.1404014458e-07, 1.3343968996e-06, 5.4720642312e-07, -7.1338208245e-07, -4.7407472231e-07, 3.0558591388e-07, 3.1447154481e-07, -8.3043034177e-08, -1.5224902191e-07, -6.2888230595e-09, 3.2741749031e-08, 1.8617143797e-08, 3.0928184366e-08, -7.8901502051e-10, -4.7313040193e-08, -1.6476779326e-08}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Quantize_Only
  BESTPRECISION true
  FILTER_TYPE Interpolation
  INTERPOLATION_RATE 2
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 1.25
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 25
  M_DATA_HAS_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA fp_0/M_AXIS_RESULT
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 8
} {
  S_AXIS fir_0/M_AXIS_DATA
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_broadcaster
cell xilinx.com:ip:axis_broadcaster:1.1 bcast_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 8
  M_TDATA_NUM_BYTES 3
  M00_TDATA_REMAP {tdata[55:32]}
  M01_TDATA_REMAP {tdata[23:0]}
} {
  S_AXIS conv_1/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_variable
cell pavel-demin:user:axis_variable:1.0 rate_0 {
  AXIS_TDATA_WIDTH 16
} {
  cfg_data slice_2/Dout
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_variable
cell pavel-demin:user:axis_variable:1.0 rate_1 {
  AXIS_TDATA_WIDTH 16
} {
  cfg_data slice_2/Dout
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_0 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  SAMPLE_RATE_CHANGES Programmable
  MINIMUM_RATE 50
  MAXIMUM_RATE 8192
  FIXED_OR_INITIAL_RATE 625
  INPUT_SAMPLE_FREQUENCY 2.5
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M00_AXIS
  S_AXIS_CONFIG rate_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_1 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  SAMPLE_RATE_CHANGES Programmable
  MINIMUM_RATE 50
  MAXIMUM_RATE 8192
  FIXED_OR_INITIAL_RATE 625
  INPUT_SAMPLE_FREQUENCY 2.5
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M01_AXIS
  S_AXIS_CONFIG rate_1/M_AXIS
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_combiner
cell  xilinx.com:ip:axis_combiner:1.1 comb_0 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 3
} {
  S00_AXIS cic_0/M_AXIS_DATA
  S01_AXIS cic_1/M_AXIS_DATA
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_constant
cell pavel-demin:user:axis_constant:1.0 phase_0 {
  AXIS_TDATA_WIDTH 32
} {
  cfg_data slice_1/Dout
  aclk /ps_0/FCLK_CLK0
}

# Create dds_compiler
cell xilinx.com:ip:dds_compiler:6.0 dds_0 {
  DDS_CLOCK_RATE 125
  SPURIOUS_FREE_DYNAMIC_RANGE 138
  FREQUENCY_RESOLUTION 0.2
  PHASE_INCREMENT Streaming
  HAS_TREADY true
  HAS_PHASE_OUT false
  PHASE_WIDTH 30
  OUTPUT_WIDTH 24
  DSP48_USE Minimal
} {
  S_AXIS_PHASE phase_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
}

# Create axis_lfsr
cell pavel-demin:user:axis_lfsr:1.0 lfsr_0 {} {
  aclk /ps_0/FCLK_CLK0
  aresetn /rst_0/peripheral_aresetn
}

# Create cmpy
cell xilinx.com:ip:cmpy:6.0 mult_0 {
  FLOWCONTROL Blocking
  APORTWIDTH.VALUE_SRC USER
  BPORTWIDTH.VALUE_SRC USER
  APORTWIDTH 24
  BPORTWIDTH 24
  ROUNDMODE Random_Rounding
  OUTPUTWIDTH 17
} {
  S_AXIS_A comb_0/M_AXIS
  S_AXIS_B dds_0/M_AXIS_DATA
  S_AXIS_CTRL lfsr_0/M_AXIS
  aclk /ps_0/FCLK_CLK0
}

# Create xlconstant
cell xilinx.com:ip:xlconstant:1.1 const_0

# Create axis_clock_converter
cell xilinx.com:ip:axis_clock_converter:1.1 fifo_1 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 2
} {
  S_AXIS mult_0/M_AXIS_DOUT
  s_axis_aclk /ps_0/FCLK_CLK0
  s_axis_aresetn /rst_0/peripheral_aresetn
  m_axis_aclk /adc_0/adc_clk
  m_axis_aresetn const_0/dout
}
