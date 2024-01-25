classdef hashtable_entry < handle
    properties (Access = private)
        occupied
        head
    end
    
    methods
        function obj = hashtable_entry()
            obj.occupied = false;
            obj.head = NaN;
        end
        
        function [collided] = add(obj, key, value)
            new_kv = hashtable_kv(key, value);

            collided = obj.occupied;
            if obj.occupied
                obj.head.chain(new_kv);
            else
                obj.occupied = true;
                obj.head = new_kv;
            end
        end

        function occupied = is_occupied(obj)
            occupied = obj.occupied;
        end
    end
end

