-- *******PL HW#1
-- *******Due Oct 7th 
-- *******Jinchun Zhang
-- *******jz2516@nyu.edu

with Text_Io; use Text_Io;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
with AdaptiveQuad;

procedure AQMain is
	eb : Float := 0.000001;

	package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
	use FloatFunctions;

	function MyF(x: Float) return Float is
	begin
		return Sin(x*x);
	end MyF;
	
	package SinPack is new AdaptiveQuad(MyF);

	task ReadPairs;

        task ComputeArea is
                entry Start(a, b: Float);
                entry Over;
        end ComputeArea;

        task PrintResult is
                entry Go(l,m,n: Float);
                entry Done;
        end PrintResult;

	task body ReadPairs is
		lower, higher : Float;
		bound_file : File_Type;
	begin 
		Open(bound_file, In_File, "input.txt");
		for Y in 1..5 loop
			get(bound_file, lower);
			get(bound_file, higher);
			ComputeArea.Start(lower, higher);
		end loop;
		Close(bound_file);
		ComputeArea.Over;
	end ReadPairs;

	task body ComputeArea is 
		low, high, Area: Float;
		Finished: Boolean :=False;
	begin
		while not Finished loop
		select
			accept Start(a, b : Float) do
				low := a;
				high := b;
			end Start;
			Area := SinPack.AQuad(low,high,eb);	
			PrintResult.Go (low, high, Area);
		or
			accept Over;
			Finished := True;
		end select;
		end loop;
		PrintResult.Done;
	end ComputeArea;

	task body PrintResult is
		Finished: Boolean := False;
	begin 
		while not Finished loop
		select 
			accept Go(l, m, n : Float) do
			Put ("The area under sin(x^2) for x = ");Put (l);Put (" to "); Put (m); Put (" is "); Put(n); 
			New_line;
			end Go;
		or 
			accept Done;
			Finished := True;
		end select;
		end loop;
	end PrintResult;

begin
	null;	
end AQMain;
