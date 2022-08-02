Class {
	#name : #TIVisitorTest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
TIVisitorTest >> testTypeForClassMethodCall [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithClassSideCall
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod:
		              SampleTypeClass >> #simpleMethodWithClassSideCall.
	self assert: (methodType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeMethodWithArgument [

	"type a method that takes an argument and returns it ex: SmallInteger"

	| typer aTMthd args inferedType arguments |
	args := OrderedCollection new.
	args add: (TCls class: SmallInteger).
	aTMthd := TMthd
		          selector: #simpleMethodWithArgument:
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	typer := TITypeInferencer new.
	arguments := OrderedCollection new.
	arguments add: (TCls class: SmallInteger).
	inferedType := typer
		               typeMethod:
		               SampleTypeClass >> #simpleMethodWithArgument:
		               with: arguments.

	self assert: (inferedType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeReturnInstanceVarMethod [

	"type a method that returns self"

	| typer expectedType args inferedType |
	args := OrderedCollection new.
	expectedType := TMthd
		                selector: #methodReturnsInstanceVariable
		                type: args
		                arrow: (TCls class: SmallInteger).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass2).
	inferedType := typer typeMethod:
		               SampleTypeClass2 >> #methodReturnsInstanceVariable.

	"self assert: inferedType equals: expectedType"
	self assert: (inferedType isSameType: expectedType) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeSelfMethod [

	"type a method that returns self"

	| typer aTMthd args inferedType |
	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #methodReturnsSelf
		          type: args
		          arrow: (TObj from: (TCls class: SampleTypeClass2)).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass2).
	inferedType := typer typeMethod:
		               SampleTypeClass2 >> #methodReturnsSelf.

	self assert: (inferedType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethod [

	"type a simple method that returns a small integer"

	| typer aTMthd args |
	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethod
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass).
	self
		assert:
			((typer typeMethod: SampleTypeClass >> #simpleMethod) isSameType:
				 aTMthd)
		equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethod [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodCall
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod: SampleTypeClass >> #simpleMethodCall.
	self assert: (methodType isSameType: aTMthd) equals: true.
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethodWithNew [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithNew
		          type: args
		          arrow: (TObj from: (TCls class: SampleTypeClass2)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod:
		              SampleTypeClass >> #simpleMethodWithNew.
	self assert: (methodType isSameType: aTMthd) equals: true.
]
