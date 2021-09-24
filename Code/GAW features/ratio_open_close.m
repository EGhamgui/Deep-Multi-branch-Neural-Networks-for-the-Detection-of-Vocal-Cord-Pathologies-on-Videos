function [Roq,OQ]=ratio_open_close(O_phase,C_phase)
if ((O_phase==0)||(C_phase==0))
    Roq=0;
    OQ =0;
else
  Roq=O_phase./C_phase;
  OQ = O_phase./(O_phase+C_phase);
end
end