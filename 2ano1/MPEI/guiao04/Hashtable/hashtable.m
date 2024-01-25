classdef hashtable < handle
    properties (Access = private)
        fun
        size
        buckets

        collisions
    end
    
    methods
        function obj = hashtable(size, fun)
            obj.fun = fun;
            obj.size = size;
            % Preallocate array
            a = [hashtable_entry()];
            a(size) = hashtable_entry();
            obj.buckets = a;

            obj.collisions = 0;
        end
        
        function [] = add(obj, key, value)
            hash = mod(obj.fun(key), obj.size - 1) + 1;

            collided = obj.buckets(hash).add(key, value);
            if collided
                obj.collisions = obj.collisions + 1;
            end
        end

        function collisions = get_collisions(obj)
            collisions = obj.collisions;
        end
    end
end

