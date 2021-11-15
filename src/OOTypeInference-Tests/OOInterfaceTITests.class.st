Class {
	#name : #OOInterfaceTITests,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
OOInterfaceTITests >> testTwoInterfacesAreNotTheSame [

	| t1 t2 |
	t1 := TInterface new.
	t1 addSelector: #add.
	
	t2 := TInterface new.
	t2 addSelector: #subtract.
	
	self deny: (t1 isSameType: t2 env: IdentityDictionary new).
]

{ #category : #tests }
OOInterfaceTITests >> testTwoInterfacesAreTheSame [

	| t1 t2 |
	t1 := TInterface new.
	t1 addSelector: #add.
	
	t2 := TInterface new.
	t2 addSelector: #add.
	
	self assert: (t1 isSameType: t2 env: IdentityDictionary new).
]

{ #category : #tests }
OOInterfaceTITests >> testTwoInterfacesAreUnifiable [

	| t1 t2 tUnified |
	t1 := TInterface new.
	t1 addSelector: #add.
	
	t2 := TInterface new.
	t2 addSelector: #subtract.
	
	tUnified := TInterface new.
	tUnified addSelector: #add.
	tUnified addSelector: #subtract.
	
	t1 unify: t2. 
	self assert: ( t1 isSameType: tUnified env: IdentityDictionary new).
	
	t2 unify: t1.
	self assert: ( t2 isSameType: tUnified env: IdentityDictionary new).
]
