Class {
	#name : #OOClassTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
OOClassTITest >> testSelectorSortOrder [
	"tests that a class can sort a collection of methods"	
			
	| temporary variable names arg1 aMthd1 aCls arg2 aMthd2 arg3 aMthd3 arg4 aMthd4 arg5 aMthd5 arg6 aMthd6 methods |
	arg1 := Var varname: 'arg1'.
	
	aCls := Cls new.
	self assert: ((aCls methods) size) = 0.
	
	aMthd1 := Mthd selector: 'firstMethod' arguments: arg1.
	aCls addMethod: aMthd1.
	self assert: ((aCls methods) size) = 1.
	
	aCls addMethod: (Mthd selector: 'secondMethod' arguments: arg2).
	aCls addMethod: (Mthd selector: 'threeMethod' arguments: arg3).
	aCls addMethod: (Mthd selector: 'fourMethod' arguments: arg4).
	aCls addMethod: (Mthd selector: 'fifthMethod' arguments: arg5).
	aCls addMethod: (Mthd selector: 'sixMethod' arguments: arg6).
	
	methods := aCls methods.
	self assert: ((aCls methods) size) = 6.
	
	self assert: (methods at: 1) selector = 'fifthMethod'.
	self assert: (methods at: 2) selector = 'firstMethod'.
	self assert: (methods at: 3) selector = 'fourMethod'.
	self assert: (methods at: 4) selector = 'secondMethod'.
	self assert: (methods at: 5) selector = 'sixMethod'.
	self assert: (methods at: 6) selector = 'threeMethod'.
	
	
	
]

{ #category : #tests }
OOClassTITest >> testSimpleType [
	"tests that a class can sort a collection of methods"	
	
	| aCls |
	aCls := Cls new.
	self assert: (aCls typeOf: Dictionary new) equals: (TCls new).
	
	
	
]

{ #category : #tests }
OOClassTITest >> testSimpleTypeWithDifferntMethods [
	"tests that a class class with a method is equal to a type class with a method"	
	
	| aCls aMthd1 arg1 aMthd2 env aTCls |
	arg1 := Var varname: 'arg1'.
	aMthd1 := Mthd selector: 'firstMethod' arguments: arg1.
	aMthd2 := Mthd selector: 'secondMethod' arguments: arg1.
	
	aCls := Cls new.
	aCls addMethod: aMthd1.
	self deny: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	env := IdentityDictionary new.
	aTCls := TCls new.
	aTCls addMethod: (aMthd2 typeOf: env).
	
	self deny: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	

]

{ #category : #tests }
OOClassTITest >> testSimpleTypeWithMethod [
	"tests that a class class with a method is equal to a type class with a method"	
	
	| aCls aMthd arg1 env aTCls |
	arg1 := Var varname: 'arg1'.
	aMthd := Mthd selector: 'firstMethod' arguments: arg1.
	
	aCls := Cls new.
	aCls addMethod: aMthd.
	self deny: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	env := IdentityDictionary new.
	aTCls := TCls new.
	aTCls addMethod: (aMthd typeOf: env).
	
	self assert: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	

]
