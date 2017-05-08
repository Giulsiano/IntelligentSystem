function [tests] = test_freq_transform
tests = functiontests(localfunctions);
end

function setupOnce (tc)
tc.TestData.data = {[8736.26, 6798.03, 9265.54, 0;
                8805.15, 6825.66, 9301.89, 0.08116;
                9050.28, 6881.19, 9375, 0.16232;
                9050.28, 6937.09, 9411.77, 0.24348;
                9157.3, 6965.17, 9485.71, 0.32464;
                9265.54, 6993.35, 9448.67, 0.4058;
                9338.37, 7078.46, 9560.23, 0.48696;
                9193.25, 7107.02, 9597.7, 0.56812;
                8909.43, 6937.09, 9411.77, 0.64928;
                8736.26, 6798.03, 9265.54, 0.73044;
                8770.64, 6770.49, 9229.32, 0.8116;
                8736.26, 6798.03, 9301.89, 0.89276;
                8839.78, 6825.66, 9301.89, 0.97392;
                8944.44, 6853.38, 9338.37, 1.05508;], ...
                [];
                [8074.2, 5959.44, 6909.09, 0;
                    8074.2, 5787.04, 7021.63, 0.08112;
                    8138.3, 5885.09, 7193.28, 0.16224;
                    8074.2, 5860.46, 6937.09, 0.24336;
                    8010.56, 5811.44, 6909.09, 0.32448;
                    7577.32, 6009.39, 6881.19, 0.4056;
                    7338.98, 6368, 6909.09, 0.48672;
                    7309.64, 6500, 7251.26, 0.56784;
                    7487.18, 6580.23, 7368.42, 0.64896;
                    7457.34, 6770.49, 7729.64, 0.73008;], ...
                [11401.67, 8909.43, 9085.82, 0;
                11180.12, 9673.08, 8770.64, 0.08115;
                11006.16, 10297.62, 9265.54, 0.1623;
                10217.39, 9448.67, 9157.3, 0.24345;
                9265.54, 8235.29, 8202.85, 0.3246;
                8944.44, 7309.64, 8566.24, 0.40575;
                8202.85, 7397.96, 8170.51, 0.4869;
                7338.98, 6937.09, 8702.01, 0.56805;
                7251.26, 6688.42, 8600, 0.6492;
                7164.43, 6289.81, 8702.01, 0.73035;
                 ];
                [8633.88, 7078.46, 8465.7, 0;
                    8944.44, 9411.77, 10920.24, 0.08168;
                    11224.07, 11627.91, 18655.46, 0.16336;
                    11357, 9825.58, 14127.36, 0.24504;
                    10750.51, 8839.78, 12287.58, 0.32672;
                    10378.49, 7853.4, 11491.6, 0.4084;
                    10920.24, 7309.64, 11006.16, 0.49008;
                    10501, 7050, 10877.55, 0.57176;
                    10137.79, 6715.69, 10708.5, 0.65344;
                    9825.58, 7164.43, 15073.53, 0.73512;
                    8499.1, 6009.39, 10378.49, 0.8168;
                    8267.86, 6059.66, 9560.23, 0.89848;
                    8499.1, 6553.4, 9411.77, 0.98016;
                    8874.54, 6661.24, 8532.61, 1.06184;
                    8805.15, 6770.49, 7853.4, 1.14352;
                    9338.37, 6770.49, 8138.3, 1.2252;
                    9635.32, 6661.24, 8170.51, 1.30688;], ...
                   [10920.24, 8366.25, 10666.67, 0;
                10792.68, 8106.19, 8566.24, 0.08158;
                9050.28, 8106.19, 10419.16, 0.16316;
                8333.33, 6937.09, 9749.04, 0.24474;
                7135.68, 6500, 9485.71, 0.32632;
                7577.32, 6368, 9338.37, 0.4079;
                8736.26, 6446.95, 9193.25, 0.48948;
                8333.33, 6110.24, 8874.54, 0.57106;
                7457.34, 6084.91, 9121.5, 0.65264;
                7222.22, 6315.79, 9157.3, 0.73422;
                6743.04, 6937.09, 10625, 0.8158;
                9522.9, 10501, 13092.55, 0.89738;
                12682.93, 12937.22, 17798.91, 0.97896;
                9597.7, 9085.82, 12483.52, 1.06054;
                7607.57, 7222.22, 9597.7, 1.14212;
                7668.39, 7021.63, 9157.3, 1.2237;
                11446.54, 9597.7, 10625, 1.30528;
                9375, 7791.3, 9338.37, 1.38686;
                8874.54, 7487.18, 11401.67, 1.46844;
                7637.93, 6881.19, 10877.55, 1.55002;
                7222.22, 6473.43, 8909.43, 1.6316;
                ];
                [10217.39, 12682.93, 11719.75, 0;
                11491.6, 14890.51, 17648.65, 0.08263;
                11952.79, 12632.74, 15639.1, 0.16526;
                12142.86, 10098.23, 14532.37, 0.24789;
                11858.97, 9014.87, 14299.29, 0.33052;
                12733.33, 9902.72, 13092.55, 0.41315;
                12937.22, 9749.04, 13957.85, 0.49578;
                13790.7, 9710.98, 12483.52, 0.57841;
                12632.74, 9014.87, 12142.86, 0.66104;
                11673.73, 8600, 11446.54, 0.74367;
                11224.07, 8170.51, 10792.68, 0.8263;
                11357, 8010.56, 10058.82, 0.90893;
                10792.68, 7915.94, 9448.67, 0.99156;], ...
                [8106.19, 7577.32, 9411.77, 0;
                7368.42, 6553.4, 9301.89, 0.08186;
                7135.68, 6798.03, 8944.44, 0.16372;
                7193.28, 7164.43, 11491.6, 0.24558;
                7637.93, 6881.19, 12287.58, 0.32744;
                9635.32, 6993.35, 12047.41, 0.4093;
                10217.39, 8074.2, 10877.55, 0.49116;
                9980.47, 8566.24, 10963.11, 0.57302;
                9375, 9265.54, 10877.55, 0.65488;
                12533.04, 16298.2, 14830.1, 0.73674;
                10542.17, 12988.76, 16096.94, 0.8186;
                5811.44, 6580.23, 10542.17, 0.90046;
                ];
    };

end

function test_output(tc)
test_data = [8736.26, 6798.03, 9265.54, 0;
                8805.15, 6825.66, 9301.89, 0.08116;
                9050.28, 6881.19, 9375, 0.16232;
                9050.28, 6937.09, 9411.77, 0.24348;
                9157.3, 6965.17, 9485.71, 0.32464;
                9265.54, 6993.35, 9448.67, 0.4058;
                9338.37, 7078.46, 9560.23, 0.48696;
                9193.25, 7107.02, 9597.7, 0.56812;
                8909.43, 6937.09, 9411.77, 0.64928;
                8736.26, 6798.03, 9265.54, 0.73044;
                8770.64, 6770.49, 9229.32, 0.8116;
                8736.26, 6798.03, 9301.89, 0.89276;
                8839.78, 6825.66, 9301.89, 0.97392;
                8944.44, 6853.38, 9338.37, 1.05508;];
exp = 1.0e+03 *[8.966659999999999   6.897760714285714   9.378234999999998                   0
   0.244877309425968   0.125197199455031   0.127437557452233   0.000880095754418
   0.116272477823637   0.060185379088122   0.059473742743023   0.001760191508836
   0.054723714322467   0.044305079320247   0.053902825126844   0.002640287263254
   0.055593742975662   0.016121326174393   0.020436270621494   0.003520383017672
   0.044798373565944   0.011655403018929   0.016900101197456   0.004400478772090
   0.014163844307429   0.003368489437673   0.020394395135330   0.005280574526508
   0.005062857142857   0.004033571428572   0.002597857142857   0.006160670280927
];
act = freq_transform(test_data);
verifyClass(tc, act, 'double');
verifyEqual(tc, act, exp, 'AbsTol', 1.0e-10);
end

function test_empty_data(tc)
test_data = [];
act = freq_transform(test_data);
verifyEmpty(tc, act);
end

