Class {
	#name : #ASNTests,
	#superclass : #OOMethodTITests,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
ASNTests >> testAssToClassMethodReturnType [
"test a local variable can be assigned a type, which is returned by the method"
| aMethod aClass expextedClsType aMethodSelector |

"number: year"
aMethodSelector := #number.
aMethod := Mthd new.
aMethod selector: aMethodSelector.
aMethod addStatement: (Asn varname: #x expression: (Int new)).
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

"class with method number:year
should it have a selector! or is Cls class good enought?"
aClass := Cls new.
aClass addMethod: aMethod.


expextedClsType := TCls new.
expextedClsType addMethod: (TMthd selector: aMethodSelector type: (OrderedCollection new) arrow: (TCls class: (Int class))).
self assert: (aClass typeOf: Dictionary new) equals: expextedClsType.

"var := Var varname: #x."
]

{ #category : #tests }
ASNTests >> testAssToClassVar [
"test a local variable can be assigned a type, which is returned by the method"
| aMethod aClass expectedClsType aMethodSelector |

"number: year"
aMethodSelector := #number.
aMethod := Mthd new.
aMethod selector: aMethodSelector.
aMethod addStatement: (Asn varname: #x expression: (Int new)).

"class with method number:year
should it have a selector! or is Cls class good enought?"
aClass := Cls new.
aClass addMethod: aMethod.
aClass addVariable: (Var varname: #x).

expectedClsType := TCls new.
expectedClsType addMethod: (TMthd selector: aMethodSelector type: (OrderedCollection new) arrow: (TCls class:self)).
expectedClsType addVariable: (TVar tv: (TCls class: (Int class))).

self assert: (aClass typeOf: Dictionary new) equals: expectedClsType.

"var := Var varname: #x."
]

{ #category : #'as yet unclassified' }
ASNTests >> testAssignmentPropegates [
	"ASNTests contain tests that execute a ASN expression within the context of typing a Method or Class and Method"
	 "Two things can happen,
		1. a local varialble can be assigned a value/type that is used in a send expression. 
				QUESTION can a local variable be used in any other context?
		2. a class variable can be assigned a value/type" 
	"scope: class-variables  &  instance-variables"	
			
	| env selector varExp asnExp aClass sendExp typeOfSendExp typeOf |
	env := IdentityDictionary new.
	selector := #myMethod.
	varExp := Var varname: #myVar.
	asnExp := Asn varname: #myVar expression: Int new.
	asnExp typeOf: env.
	sendExp := Send target: (Var varname: #arg1) selector: (selector) arguments: (OrderedCollection new add: varExp).
	typeOfSendExp := sendExp typeOf: env.
	
	"create the expected typeOf"
	typeOf := TInterface new.
	typeOf addSelector: selector.
		
	self assert: typeOfSendExp equals: typeOf.
]

{ #category : #tests }
ASNTests >> testSmallIntegerMethodAssignAndReturnTyping [

| aMethod expectedType x args |
aMethod := Mthd new.
aMethod selector: #number.
x:= (Asn varname: #x expression: (Int new)).
aMethod addStatement: x.
aMethod addStatement: (Rtrn exp: (Var varname: #x)).

args := OrderedCollection new.
expectedType := TArrow type: args arrow: (TCls class: (Int class)).
self assert: (aMethod typeOf: Dictionary new) equals: expectedType.

]
