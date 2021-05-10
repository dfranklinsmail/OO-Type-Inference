Class {
	#name : #FunctionTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
FunctionTITest >> testEg1 [
	" fun x -> let y = fun z -> z in y "

	| toy env type t1 t2 expectedType |
	toy := Lam
	varname: #x
		exp:
			(Let
				varname: #y
				exp: (Lam varname: #z exp: (Var varname: #z))
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t2).
	type := toy typeOf: env.
	self assert: type equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testEg1a [
	" fun x -> let y = fun x -> x in y "

	| toy env type t1 t2 expectedType |
	toy := Lam
	varname: #x
		exp:
			(Let
				varname: #y
				exp: (Lam varname: #x exp: (Var varname: #x))
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t2).
	type := toy typeOf: env.
	self assert: type equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testEg2 [
	" fun x -> let y = x in y "

	| toy env type t1 correctType t2 unsoundType |
	toy := Lam
		varname: #x
		exp:
			(Let
				varname: #y
				exp: (Var varname: #x)
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	correctType := TArrow type: t1 arrow: t1.
	unsoundType := TArrow type: t1 arrow: t2.
	type := toy typeOf: env.
	self assert: type equals: correctType. " change to correctType once typeOf: has been extended"

]

{ #category : #tests }
FunctionTITest >> testEg3Unsound [
	" fun x -> let y = fun z -> x z in y "

	| toy env type t1 t2 correctType t3 t4 |
	toy := Lam
		varname: #x
		exp:
			(Let
				varname: #y
				exp: (Lam varname: #z exp: (App exp: (Var varname: #x) exp: (Var varname: #z)))
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	t3 := TVar newvar.
	t4 := TVar newvar.
	
	correctType := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2).
	"correctType := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t3 arrow: t4)."
	type := toy typeOf: env.
	self assert: type equals: correctType. 	

]

{ #category : #tests }
FunctionTITest >> testEg4Sound [
	" fun x -> let y = fun z -> x z in y "

	| toy env type t1 t2 correctType |
	toy := Lam
		varname: #x
		exp:
			(Let
				varname: #y
				exp: (Lam varname: #z exp: (App exp: (Var varname: #x) exp: (Var varname: #z)))
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	correctType := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2).
	type := toy typeOf: env.
	self assert: type equals: correctType.

]

{ #category : #tests }
FunctionTITest >> testEg5 [
	" test that the equals ignores ToyTVars"

	| t1 t2 typeA typeB |
	t1 := TVar newvar.
	t2 := TVar newvar. 
	
	typeA := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TVar tv: (TArrow type: t1 arrow: t2)).
	typeB := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2).
	self assert: typeA equals: typeB. 
	self assert: typeB equals: typeA. 

	typeA := TArrow type: (TVar tv: (TArrow type: t1 arrow: t2)) arrow: (TArrow type: t1 arrow: t2).
	typeB := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2).
	self assert: typeA equals: typeB.
	self assert: typeB equals: typeA.

]

{ #category : #tests }
FunctionTITest >> testEgNestingLet1 [
	" 	#	 fun x -> let y = fun z -> let m = fun y -> x z in m in y;;
		- : ('a -> 'b) -> 'a -> 'c -> 'b = <fun> "

	| toy env type t1 t2 correctType t3 |
	toy := Lam
		varname: #x
		exp:
			(Let
				varname: #y
				exp: (Lam varname: #z exp: (Let
															varname: #m
															exp: ( Lam
																		varname: #y
																		exp: (App exp: (Var varname: #x) exp: (Var varname: #z)))
															exp: (Var varname: #m) ) )
				exp: (Var varname: #y)).
	env := nil.
	t1 := TVar newvar.
	t2 := TVar newvar.
	t3 := TVar newvar.
	
	correctType := TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: (TArrow type: t3 arrow: t2)).
	type := toy typeOf: env.
	self assert: type equals: correctType. 	

]

{ #category : #tests }
FunctionTITest >> testGen [
	| tvar1 gen1 qvar tvar2 gen2 tvlink1 tvar3 genLink1 tvar4 tvlink2 genLink2 tvar5 tvar6 tarrow1 gen3 |
	
	tvar1 := TVar newvar.
	
	"test that a fresh TVar on its own after gen is equal"
	gen1 := tvar1 gen.
	self assert: (gen1 == tvar1).
	self deny: (gen1 isQVar).
	
	tvar2 := TVar newvar: 10.
	gen2 := tvar2 gen.
	self assert: (gen2 isQVar).
	self assert: (tvar2 tv string == gen2 qname).
	
	"test gen with link"
	tvar3 := TVar newvar.
	tvlink1 := TVLink link: tvar3.
	genLink1 := tvlink1 gen.
	self assert: (genLink1 == tvar3).
	self deny: (genLink1 isQVar).
	
	tvar4 := TVar newvar: 3.
	tvlink2 := TVLink link: tvar4.
	genLink2 := tvlink2 gen.
	self assert: (genLink2 isQVar).
	self assert: (tvar4 tv string == genLink2 qname).
	
	"test gen with tarrow"
	tvar5 := TVar newvar.
	tvar6 := TVar newvar.
	tarrow1 := TArrow type: tvar5 arrow: tvar6.
	gen3 := tarrow1 gen.
	self assert: (gen3 typ1 == tarrow1 typ1).
	self assert: (gen3 typ2 == tarrow1 typ2).
	
	
	
	
	
	
]

{ #category : #tests }
FunctionTITest >> testSameType [
   "tests that a -> (b -> b) is the same as b-> (a -> a)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t2).
	self assert: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t1)) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSameType1 [
   "tests that a -> (b -> a) is the same as b-> (a -> b)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t1).
	self assert: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSameType2 [
   "tests that a -> (a -> b) is the same as b-> (b -> a)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t2 arrow: (TArrow type: t1  arrow: (TArrow type: t1 arrow: t2)).
	self assert: (TArrow type: t1 arrow: (TArrow type: t2 arrow: (TArrow type: t2 arrow: t1))) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSameType3 [
   "tests that a -> (a -> b) is the same as b-> (a -> b)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t1 arrow: t2).
	self deny: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSameType4 [
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).
	self assert: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t2 arrow: t1)) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSameType5 [
	| t1 t2 expectedType |
	"test that ('a -> 'b) -> ('a -> 'b) is not the same as ('b -> 'a) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSimpleToyLam [
	| toy type expectedType t1 |
	toy := Lam varname: #y exp: (Var varname: #y).
	t1 := TVar newvar.
	expectedType := TArrow type: t1 arrow: t1.
	type := toy typeOf: nil.
	self assert: type equals: expectedType.

]

{ #category : #tests }
FunctionTITest >> testSimpleToyVar [
	

	| toy type expectedType |
	toy := Var varname: #y.
	expectedType := TVar newvar.
	type := toy typeOf: nil.
	self deny: type equals: expectedType.

]
