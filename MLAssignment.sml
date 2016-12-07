(*ML Assignment *)

Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(*Q1*)
fun merge L1 []=L1
|	merge [] L2=L2
|	merge (x1::xs) (y1::ys)=
		if x1<y1 then x1::(merge xs (y1::ys))
		else y1::(merge ys (x1::xs))


(*Q2*)
fun split []=([], [])
|	split [x]=([x], [])
|	split (od::ev::xs) = 
		let val (ods, evs)=split xs
		in ((od::ods),(ev::evs))
	end

(*Q3*)
fun mergeSort []=[]
|	mergeSort [x]=[x]
|	mergeSort L=
		let val (fh, sf) = split L
			in merge (mergeSort fh) (mergeSort sf)
	end


(*Q4*)
infix <;
fun sort (op <) []=[]
|	sort (op <) [x]=[x]
|	sort (op <) L=let
		fun merge (L1, [])=L1
		|	merge ([], L2)=L2
		|	merge ((x1::xs), (y1::ys))= 
				if x1 < y1 then x1::(merge (xs, (y1::ys)))
				else y1::(merge (ys, (x1::xs)))
		fun split [] = ([],[])
		|	split [x]=([x],[])
		|	split (od::ev::ms)=let
				val(ods, evs)=split ms
				in (od::ods, ev::evs)
			end
		val (fh, sf)=split L
		in merge (sort (op <) fh,  sort (op <) sf)
	end

(*Q5*)
datatype 'a tree = empty | leaf of 'a | node of 'a *'a tree * 'a tree

(*Q6*)
fun labels (empty: 'a tree) =[]
|	labels (leaf x) =[x]
|	labels (node(y, t1, t2))= labels t1 @ [y] @ labels t2

(*Q7*)
infix == ;
fun replace (op ==) (x:'a) (y:'a) (empty: 'a tree) = empty
|	replace (op ==) (x: 'a) (y: 'a) (leaf m) = 
			if x == m then leaf(y) else leaf(m)
|	replace (op ==) (x:'a) (y:'a) (node(m,t1,t2)) = 
			if x == m then node(y, replace (op ==) x y t1, replace (op ==) x y t2)
			else node(m, replace (op ==) x y t1, replace (op ==) x y t2)


(*Q8*)
fun replaceEmpty (y: 'a tree) (empty: 'a tree) = y
|	replaceEmpty (y: 'a tree) (leaf m: 'a tree) = leaf(m)
|	replaceEmpty (y: 'a tree) (node(x, t1, t2): 'a tree) = node(x, replaceEmpty y t1, replaceEmpty y t2)


(*Q9*)
(*define a function increment*)
fun increment empty = leaf 0
|	increment (leaf a)=leaf (a+1)
|	increment (node(a, L,R))=node(a+1, L, R)

fun mapTree f empty = f empty
 |  mapTree f (leaf a) = f (leaf a)
 |  mapTree f (node (a,t1,t2)) = f (node (a, mapTree f t1, mapTree f t2))


(*Q10*)
fun sortTree (op <) T = mapTree (fn empty => empty
                                  | (leaf x) => leaf (sort (op <) x)
                                  | (node (x,t1,t2)) => node (sort (op <) x,t1,t2)) T

