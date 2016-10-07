-- *******PL HW#1 
-- *******Due Oct 7th
-- *******Jinchun Zhang
-- *******jz2516@nyu.edu


package body AdaptiveQuad is
	
	function SimpsonsRule (a1, b1: in out Float) return Float is
		c1 : Float := (a1 + b1)/2.0;
		h3 : Float := (abs(a1 - b1))/6.0;
	begin
		return  h3*(F(a1) + 4.0*F(c1)+ F(b1));
	end SimpsonsRule;

	function RecAuad(a, b, eps: in out  Float) return Float is
		c: Float := (a + b)/2.0;
                Left : Float := SimpsonsRule (a, c);
                Right : Float := SimpsonsRule (c, b);
		Whole : Float := SimpsonsRule (a, b);
		Half_error : Float := eps/2.0;
		T, LeftApx, RightApx : Float := 0.0;
		
		procedure RC(a2, c2, b2, e2: in out Float) is 
			task Left_Int;
			task Right_Int;
			task body Left_Int is 
			begin
				LeftApx := RecAuad(a2,c2,e2);
			end Left_Int;

                        task body Right_Int is
			begin
                                RightApx := RecAuad(c2,b2,e2);
                        end Right_Int;	
		begin
			Null;
		end;

	begin
                if abs(Left + Right - Whole) <= (15.0*eps) then
                        T:= (Left + Right +(Left + Right- Whole)/15.0);
                else
                        RC( a, c, b, Half_error);
			T:= LeftApx+RightApx;
        	end if;
		return T;
	end RecAuad;

	function AQuad (A, B, Eps: in out Float) return Float is
	begin
		return RecAuad(A, B, Eps);
	end AQuad;

end AdaptiveQuad;

