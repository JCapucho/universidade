function [original] = lzwDecode(initial, compressed)
    dict = initial;
    
    lastStr = dict{compressed(1)};
    original = lastStr;

    for idx = 2:length(compressed)
        code = compressed(idx);
        newStr = dict{code};
        original = append(original, newStr);
        
        nextStr = append(lastStr, newStr(1));
        dict = [dict nextStr];
        lastStr = newStr;
    end
end
