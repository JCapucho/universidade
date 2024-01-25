classdef CountingBloomFilter < handle
    properties (Access = private)
        filter_array,
        number_of_hashes,
    end
    
    methods
        function obj = CountingBloomFilter(n, k)
            obj.filter_array = zeros(1, n);
            obj.number_of_hashes = k;
        end
        
        function [] = insert(obj, key)
            n = length(obj.filter_array);
            
            hashes = muxDJB31MA(key, 127, obj.number_of_hashes);
            positions = mod(hashes, n) + 1;
            
            for pos=positions
                obj.filter_array(pos) = obj.filter_array(pos) + 1;
            end
        end
        
        function res = getInsertedAssured(obj, key)
            n = length(obj.filter_array);
            
            hashes = muxDJB31MA(key, 127, obj.number_of_hashes);
            positions = mod(hashes, n) + 1;
            
            res = min(obj.filter_array(positions));
        end
    end
end

