Class {
	#name : #OOClassTITest,
	#superclass : #TITest,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
OOClassTITest >> testAddDuplicateMethodDifferentTypesToCls [
	"tests that a class class with a method is equal to a type class with a method"	
	
	| argA aMthdA  argB aMthdB aTCls aCls typMthdA typMthdB unifiedMethod argListA argListB |
	argA := Int new.
	argListA := OrderedCollection new.
	argListA add: argA.
	aMthdA := Mthd selector: 'myPolymorphicMethod' arguments: argListA.
	argB := Char new.
	argListB := OrderedCollection new.
	argListB add: argB.
	aMthdB := Mthd selector: 'myPolymorphicMethod' arguments: argListB.
	
	aCls := Cls new.
	aCls addMethod: aMthdA.
	aCls addMethod: aMthdB.
	self deny: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	aTCls := TCls new.
	typMthdA := (aMthdA typeOf: IdentityDictionary new).
	typMthdB := (aMthdB typeOf: IdentityDictionary new).
	unifiedMethod := typMthdA unifyWith: typMthdB.
	aTCls addMethod: unifiedMethod.
	
	self deny: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	

]

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
	
	| aCls aMthd1 arg1 aMthd2 env aTCls argList |
	arg1 := Var varname: 'arg1'.
	argList := OrderedCollection new.
	argList add: arg1.
	aMthd1 := Mthd selector: 'firstMethod' arguments: argList.
	aMthd2 := Mthd selector: 'secondMethod' arguments: argList.
	
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
	
	| aCls aMthd arg1 env aTCls argList aSelector args |
	aSelector := 'firstMethod'.
	arg1 := Var varname: 'arg1'.
	argList := OrderedCollection new.
	argList add: arg1.
	aMthd := Mthd selector: aSelector arguments: argList.
	
	aCls := Cls new.
	aCls addMethod: aMthd.
	self deny: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	env := IdentityDictionary new.
	aTCls := TCls new.
	args := OrderedCollection new.
	args add: TVar newvar.
	"add a method with the 'aSelector' selector arguments list of just a new TVar and returns a TCls of Int type"
	aTCls addMethod: (TMthd selector: aSelector type: args arrow: (TCls class: (aCls class))).
	
	self assert: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	

]

{ #category : #tests }
OOClassTITest >> testSimpleTypeWithVariableAndType [
	"this test has ...
	 	1. a class with one variable and a method
		2. the method has a statement that assigns the classes class variable a type of Int.
		3. the type of the class is a TCls with a TVar of type Int.
		4. the method's type is not relavent
	this test will show that a class variables type can be assigned via a methods statements"	
	
	| aCls aTCls var varname aMethod aSelector anotherTCls |
	aCls := Cls new.
	"assert an empty class has the type of an emtpy class type"
	self assert: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	"assert a class type with a method type corrisponding to the 'firstMethod's type does match the type of the 'aCls'"
	varname := 'arg1'.
	var := Var varname: varname.
	aCls addVariable: var.
	aTCls := TCls new.
	aTCls addVariable: (var typeOf: IdentityDictionary new).
	
	self assert: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	"create a method that updates the type of the class variable"
	aSelector := #number.
	aMethod := Mthd new.
	aMethod selector: aSelector.
	aMethod addStatement: (Asn varname: varname expression: (Int new)).
	aMethod addStatement: (Rtrn exp: (Int new)).
	aCls addMethod: aMethod.
	
	anotherTCls := TCls new.
	anotherTCls addVariable: ((Int new) typeOf: IdentityDictionary new).
	anotherTCls addMethod: (TMthd selector: aSelector type: (OrderedCollection new) arrow: (TCls class: (Int new))).
	self assert: (aCls typeOf: IdentityDictionary new) equals: anotherTCls.
	
	
	
	
	

]

{ #category : #tests }
OOClassTITest >> testSimpleTypeWithVariables [
	"tests that a class class with a method is equal to a type class with a method"	
	
	| aCls aTCls var |
	aCls := Cls new.
	"assert an empty class has the type of an emtpy class type"
	self assert: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	"add a variable and deny that a class with a type has the same type as an empty class type"
	var := Var varname: 'arg1'.
	aCls addVariable: var.
	self deny: (aCls typeOf: IdentityDictionary new) equals: (TCls new).
	
	"assert a class type with a method type corrisponding to the 'firstMethod's type does match the type of the 'aCls'"
	aTCls := TCls new.
	aTCls addVariable: (var typeOf: IdentityDictionary new).
	
	self assert: (aCls typeOf: IdentityDictionary new) equals: aTCls.
	
	

]
