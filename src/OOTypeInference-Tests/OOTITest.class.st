Class {
	#name : #OOTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

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
OOTITest >> testObjectType [
	| c1 o1 m1 o2 env m2 o3 o4 |
	"test that an object with the same send equals"
	c1 := Cls new.
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
	"Objects with unused classes equal"
	m2 := Mthd new.
	o3 := Obj instantiate: (Cls new).
	o3 send: m2.
	o4 := Obj instantiate: (Cls new).
	o4 send: m2.
	env := nil.
	self assert: (o3 typeOf: env) equals: (o4 typeOf: env).
]

{ #category : #tests }
OOTITest >> testObjectType_oneSendDifferentClass [
	| env m2 o3 o4 |
	"test that an object with the same send equals"
	
	"
	m1 := Mthd arguments: {a1.a2}.
	expectedType := TArrow type: (TArrow type: t1 arrow: t2)  arrow: (TArrow type: t1 arrow: t2).  
	self deny: (TArrow type: (TArrow type: t2 arrow: t1) arrow: (TArrow type: t1 arrow: t2)) equals: expectedType.
	"
	"Objects with unused classes equal"
	m2 := Mthd new.
	o3 := Obj instantiate: (Cls new).
	o3 send: m2.
	o4 := Obj instantiate: (Cls new).
	o4 send: m2.
	env := nil.
	self assert: (o3 typeOf: env) equals: (o4 typeOf: env).
]

{ #category : #tests }
OOTITest >> testObjectType_oneSendSameClass [
	| c1 o1 m1 o2 env |
	"test that an object with the same send equals"
	c1 := Cls new.
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
]

{ #category : #tests }
OOTITest >> testObjectUnification [
	| c1 o1 o2 env |
	"test that two objects can unify"
	c1 := Cls new.

	o1 := Obj instantiate: c1.
	o2 := Obj instantiate: c1.
	
	env := nil.
	self assert: (o1 typeOf: env) equals: (o2 typeOf: env).
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
	
	"TODO what am I trying to do here?"
	tArrow := TArrow type: tVar1 arrow: tVar2.
	self assert: (tVar1 occurs: tArrow argTypes).
	self assert: (tVar2 occurs: tArrow resultTyp).
	tVar3 := TVar newvar: 100.
	tVar3 occurs: tArrow.
	self assert: ((tVar3 tv level) == 100).
	self deny: (tArrow occurs: tVar1).  "not sure about this one"
	
	tLink := TVLink link: tVar1.
	self assert: (tVar1 occurs: tLink).
	self deny: (tVar2 occurs: tLink).
	self assert: (tLink occurs: tLink). 
	
	
]

{ #category : #tests }
OOTITest >> testSimpleClassTypeCheck [
	"test that a brand new class has a type TCls"
	self assert: (TCls new) equals: ((Cls new) typeOf: nil).
]
