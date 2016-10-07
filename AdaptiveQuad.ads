-- *******PL HW#1 
-- *******Due Oct 7th
-- *******Jinchun Zhang
-- *******jz2516@nyu.edu

generic
	with function F(x: in Float) return Float;  
package AdaptiveQuad is
	function AQuad(A, B, Eps: in out Float) return Float;
end AdaptiveQuad;
