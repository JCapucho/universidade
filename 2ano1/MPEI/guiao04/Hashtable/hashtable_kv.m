classdef hashtable_kv < handle
    properties (Access = private)
        key
        value
        next
    end
    
    methods
        function obj = hashtable_kv(key, value)
            obj.key = key;
            obj.value = value;
            obj.next = NaN;
        end
        
        function [] = chain(obj, next_kv)
            if strcmp(obj.key, next_kv.key)
                obj.value = next_kv.value;
            elseif isa(obj.next, "double")
                obj.next = next_kv;
            else
                obj.next.chain(next_kv);
            end
        end
    end
end

