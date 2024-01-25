classdef BloomFilter < handle
    properties (Access = private)
        members,
        filter_array,
        number_of_hashes,
        hash_function
    end
    
    methods
        function obj = BloomFilter(n, k, hash)
            obj.members = 0;
            obj.filter_array = false(1, n);
            obj.number_of_hashes = k;
            obj.hash_function = hash;
        end
        
        function [] = insert(obj, key)
            key = convertStringsToChars(key);
            n = length(obj.filter_array);
            
            for i=1:obj.number_of_hashes
                key = [key num2str(i)];
                h = obj.hash_function(key, n) + 1;
                obj.filter_array(h) = true;
            end
            
            obj.members = obj.members + 1;
        end
        
        function [contained] = contains(obj, key)
            key = convertStringsToChars(key);
            n = length(obj.filter_array);
            
            for i=1:obj.number_of_hashes
                key = [key num2str(i)];
                h = obj.hash_function(key, n) + 1;
                if ~obj.filter_array(h)
                    contained = false;
                    return
                end
            end
            
            contained = true;
        end
        
        function [members] = get_members(obj)
            members = obj.members;
        end
    end
end

