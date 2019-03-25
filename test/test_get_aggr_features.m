function [tests ] = test_get_aggr_features
tests = functiontests(localfunctions);
end

function test_feats_size(tc)
test_data = [ 1  2  3;
              4  5  6;
              7  8  9;
             10 11 12;
             13 14 15;
             16 17 18;
             19 20 21;
             22 23 24];
test_chunk_size = 1;
test_features = @min;
exp_size = [8 1];
act_feats = get_features(test_data, test_features, test_chunk_size);
verifyEqual(tc, size(act_feats), exp_size);
end

function test_chunk_size(tc)
test_data = [ 1  2  3;
              4  5  6;
              7  8  9;
             10 11 12;
             13 14 15;
             16 17 18;
             19 20 21;
             22 23 24];
test_chunk_size = 2;
test_features = @min;
exp_size = [4 1];
act_feats = get_features(test_data, test_features, test_chunk_size);

verifyEqual(tc, size(act_feats), exp_size);    
end
 

function test_one_feat(tc)
test_data = [ 1  2  3;
              4  5  6;
              7  8  9;
             10 11 12;
             13 14 15;
             16 17 18;
             19 20 21;
             22 23 24];
test_chunk_size = 2;
test_features = @min;
exp_feats = [1; 7; 13; 19];
act_feats = get_features(test_data, test_features, test_chunk_size);
verifyEqual(tc, act_feats, exp_feats);
end