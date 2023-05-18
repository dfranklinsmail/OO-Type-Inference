Class {
	#name : #TISmallTalkInferenceTest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeForClassMethodCall [

	"type a method that calls another method which returns a SmallInteger"

	| inferencer aTMthd args methodType |
	inferencer := TISmallTalkInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithClassSideCall
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	inferencer currentClass: SampleTypeClass.
	"type the mehtod and assert its equal to what I am expecting"
	methodType := inferencer typeMethod:
		              SampleTypeClass >> #simpleMethodWithClassSideCall.
	self assert: (methodType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeMethodWithArgument [

	"type a method that takes an argument and returns it ex: SmallInteger"

	| typer aTMthd args inferedType arguments |
	args := OrderedCollection new.
	args add: (TCls class: SmallInteger).
	aTMthd := TMthd
		          selector: #simpleMethodWithArgument:
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

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
TISmallTalkInferenceTest >> testTypeReturnInstanceVarMethod [

	"type a method that returns self"

	| typer expectedType args inferedType |
	args := OrderedCollection new.
	expectedType := TMthd
		                selector: #methodReturnsInstanceVariable
		                arguments: args
		                result: (TCls class: SmallInteger).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass2).
	inferedType := typer typeMethod:
		               SampleTypeClass2 >> #methodReturnsInstanceVariable.

	"self assert: inferedType equals: expectedType"
	self assert: (inferedType isSameType: expectedType) equals: true
]

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeSelfMethod [

	"type a method that returns self"

	| typer aTMthd args inferedType |
	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #methodReturnsSelf
		          arguments: args
		          result: (TObj from: (TCls class: SampleTypeClass2)).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass2).
	inferedType := typer typeMethod:
		               SampleTypeClass2 >> #methodReturnsSelf.

	self assert: (inferedType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeSimpleMethod [

	"type a simple method that returns a small integer"

	| typer aTMthd args |
	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethod
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

	typer := TITypeInferencer new.
	typer currentClass: (TCls class: SampleTypeClass).
	self
		assert:
			((typer typeMethod: SampleTypeClass >> #simpleMethod) isSameType:
				 aTMthd)
		equals: true
]

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeSimpleMethodCallsSimpleMethod [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodCall
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod: SampleTypeClass >> #simpleMethodCall.
	self assert: (methodType isSameType: aTMthd) equals: true.
]

{ #category : #tests }
TISmallTalkInferenceTest >> testTypeSimpleMethodCallsSimpleMethodWithNew [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithNew
		          arguments: args
		          result: (TObj from: (TCls class: SampleTypeClass2)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod:
		              SampleTypeClass >> #simpleMethodWithNew.
	self assert: (methodType isSameType: aTMthd) equals: true.
]
