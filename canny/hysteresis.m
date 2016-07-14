function [M2, visited, edges, recursion_count, pt, direction] = hysteresis(M2, visited, edges, recursion_count, pt, tl, direction)

a = M2(pt(1):pt(1)+1, pt(2):pt(2)+1) >= tl;

if(direction == 0)
    if a(1,2) == 1
        direction = 1;
    elseif a(2,1) == 1
        direction = 2;
    elseif a(2,2) == 1
        direction = 3;
    end
end

if  sum(a(:)) > 1 && recursion_count < 30
    recursion_count = recursion_count+1;
    
    edges(pt(1), pt(2)) = 1;
    
    if direction == 1
        visited(pt(1)+1, pt(2)) = 0;
        edges(pt(1)+1, pt(2)) = 1;
    elseif direction == 2
        visited(pt(1), pt(2)+1) = 0;
        edges(pt(1), pt(2)+1) = 1;
    elseif direction == 3
        visited(pt(1)+1, pt(2)+1) = 0;
        edges(pt(1)+1, pt(2)+1) = 1;
    end
    
    [M2, visited, edges, recursion_count, pt, direction] = hysteresis(M2, visited, edges, recursion_count, pt, tl, direction);  
end