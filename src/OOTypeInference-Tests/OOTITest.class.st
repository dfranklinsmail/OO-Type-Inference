Class {
	#name : #OOTITest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #asserting }
OOTITest >> assert: actual equals: expected [ 
	self assert: (actual isSameType: expected env: IdentityDictionary new)
			description: [self comparingStringBetween: actual and: expected]
]

{ #category : #asserting }
OOTITest >> deny: actual equals: expected [ 
	self deny: (actual isSameType: expected env: IdentityDictionary new)
			description: [self comparingStringBetween: actual and: expected]
]

{ #category : #running }
OOTITest >> setUp [
	super setUp.
	TVUnbound initialize.

]

{ #category : #tests }
OOTITest >> testClassHierarchy [
	| c1 expectedType |
	"test that ('a -> 'b) -> ('a -> 'b) is not the same as ('b -> 'a) -> ('a -> 'b)"
	c1 := Cls new.
	expectedType := TCls new.
	
	self assert: expectedType equals: (c1 typeOf: nil).
	
	"
	m1 := Mthd arguments: {a1.a2}.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.
	"
]

{ #category : #tests }
OOTITest >> testEg1 [
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
OOTITest >> testEg1a [
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
OOTITest >> testEg2 [
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
OOTITest >> testEg3Unsound [
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
	
	correctType := "TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2).
	correctType :=" TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t3 arrow: t4).
	type := toy typeOf: env.
	self assert: type equals: correctType. 	

]

{ #category : #tests }
OOTITest >> testEg4Sound [
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
OOTITest >> testEg5 [
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
OOTITest >> testEgNestingLet1 [
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
OOTITest >> testGen [
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
OOTITest >> testObjectType [
	| c1 o1 expectedType m1 o2 env m2 o3 o4 |
	"test that ??????"
	c1 := Cls new.
	expectedType := TCls new.
	self assert: expectedType equals: (c1 typeOf: nil).
	
	m1 := Mthd new.
	o1 := Obj instantiate: c1.
	o1 send: m1.
	o2 := Obj instantiate: c1.
	o2 send: m1.
	env := nil.
	self assert: (o1 typeOf: env) equals: (o2 typeOf: env).
	"
	m1 := Mthd arguments: {a1.a2}.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.
	"
	m2 := Mthd new.
	o3 := Obj instantiate: (Cls new).
	o3 send: m2.
	o4 := Obj instantiate: (Cls new).
	o4 send: m2.
	env := nil.
	self assert: (o3 typeOf: env) equals: (o4 typeOf: env).
]

{ #category : #tests }
OOTITest >> testOccurs1 [
	| tVar1 tVar2 tArrow tLink tVarHigher tVarLower tVarHigher2 tVarLower2 tVar3 |
	tVar1 := TVar newvar.
	self assert: (tVar1 occurs: tVar1).
	
	tVar2 := TVar newvar.
	self deny: (tVar1 occurs: tVar2).
	
	tVarHigher := TVar newvar: 5.
	tVarLower := TVar newvar: 50.
	self deny: (tVarLower occurs: tVarHigher).
	self assert: (tVarLower tv level == tVarHigher tv level).
	
	tVarHigher2 := TVar newvar: 5.
	tVarLower2 := TVar newvar: 50.
	self deny: (tVarLower2 occurs: tVarHigher2).
	self assert: (tVarLower2 tv level == tVarHigher2 tv level).
	
	tArrow := TArrow type: tVar1 arrow: tVar2.
	self deny: (tVar1 occurs: tArrow).
	self deny: (tVar2 occurs: tArrow).
	tVar3 := TVar newvar: 100.
	tVar3 occurs: tArrow.
	self assert: ((tVar3 tv level) == 0).
	self deny: (tArrow occurs: tVar1).  "not sure about this one"
	
	tLink := TVLink link: tVar1.
	self assert: (tVar1 occurs: tLink).
	self deny: (tVar2 occurs: tLink).
	self assert: (tLink occurs: tLink). 
	
	
]

{ #category : #tests }
OOTITest >> testSameMethod1 [
	| m1 m2 expectedType a1 a2 t1 t2 |
	"test that ('a -> 'b) -> ('a -> 'b) is not the same as ('b -> 'a) -> ('a -> 'b)"
	a1 := Var new.
	a2 := Var new.
	m1 := Mthd arguments: {a1.a2}.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType [
   "tests that a -> (b -> b) is the same as b-> (a -> a)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t2).
	self assert: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t1)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType1 [
   "tests that a -> (b -> a) is the same as b-> (a -> b)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t2 arrow: t1).
	self assert: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType2 [
   "tests that a -> (a -> b) is the same as b-> (b -> a)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t2 arrow: (TArrow type: t1  arrow: (TArrow type: t1 arrow: t2)).
	self assert: (TArrow type: t1 arrow: (TArrow type: t2 arrow: (TArrow type: t2 arrow: t1))) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType3 [
   "tests that a -> (a -> b) is the same as b-> (a -> b)"
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: t1  arrow: (TArrow type: t1 arrow: t2).
	self deny: (TArrow type: t2 arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType4 [
	| t1 t2 expectedType |
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).
	self assert: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t2 arrow: t1)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSameType5 [
	| t1 t2 expectedType |
	"test that ('a -> 'b) -> ('a -> 'b) is not the same as ('b -> 'a) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSimpleToyLam [
	| toy type expectedType t1 |
	toy := Lam varname: #y exp: (Var varname: #y).
	t1 := TVar newvar.
	expectedType := TArrow type: t1 arrow: t1.
	type := toy typeOf: nil.
	self assert: type equals: expectedType.

]

{ #category : #tests }
OOTITest >> testSimpleToyVar [
	

	| toy type expectedType |
	toy := Var varname: #y.
	expectedType := TVar newvar.
	type := toy typeOf: nil.
	self deny: type equals: expectedType.

]

{ #category : #tests }
OOTITest >> testTypePrinting1 [
	| prettyPrintA prettyPrintB t1 t2 |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	prettyPrintA := (TVar tv: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: t1 arrow: t2) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
OOTITest >> testTypePrinting2 [
	| prettyPrintA prettyPrintB t1 t2 |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b)"
	t1 := TVar newvar.
	t2 := TVar newvar.
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
OOTITest >> testTypePrinting3 [
	| prettyPrintA prettyPrintB t1 t2 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t1 arrow: t2).
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: nestedTArrow) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
OOTITest >> testTypePrinting4 [
	| prettyPrintA prettyPrintB t1 t2 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t1 arrow: t2).
	prettyPrintA := (TArrow type: nestedTArrow arrow: (TArrow type: t1 arrow: t2)) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t1 arrow: t2)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]

{ #category : #tests }
OOTITest >> testTypePrinting5 [
	| prettyPrintA prettyPrintB t1 t2 t3 t4 nestedTArrow |
	"test that ('a -> 'b) -> ('a -> 'b) is the same string as ('a -> 'b) -> ('a -> 'b) 
	even though one ToyTArrow is nested in a ToyTVar"
	t1 := TVar newvar.
	t2 := TVar newvar.
	t3 := TVar newvar.
	t4 := TVar newvar.
	nestedTArrow := TVar tv: (TArrow type: t3 arrow: t4).
	prettyPrintA := (TArrow type: (TArrow type: t1 arrow: t2) arrow: nestedTArrow) asString.
	prettyPrintB := (TArrow type: (TArrow type: t1 arrow: t2) arrow: (TArrow type: t3 arrow: t4)) asString.  
	self assert: prettyPrintA = prettyPrintB.

]
