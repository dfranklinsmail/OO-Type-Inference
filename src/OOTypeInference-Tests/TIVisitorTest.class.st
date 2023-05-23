Class {
	#name : #TIVisitorTest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
TIVisitorTest >> testTypeForClassMethodCall [

	"type a method with no arguments, that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithClassSideCall
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).


	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod: #simpleMethodWithClassSideCall
							  inClass: SampleTypeClass.
	self assert: (methodType isSameType: aTMthd) equals: true.
]

{ #category : #tests }
TIVisitorTest >> testTypeForClassMethodCallAndCalledMethod [

	"type a method with no arguments, that calls another method which returns a SmallInteger"

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethodWithClassSideCall
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).
	
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod: #simpleMethodWithClassSideCall inClass: SampleTypeClass.
	self assert: (methodType isSameType: aTMthd) equals: true.
	
	methodType := typer typeMethod: #make inClass: SampleTypeClass2.
	aTMthd := TMthd
		          selector: #make
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).
	self assert: (methodType isSameType: aTMthd) equals: true.
]

{ #category : #tests }
TIVisitorTest >> testTypeMethodWithArgument [

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
	inferedType := typer typeMethod: #simpleMethodWithArgument:
							with: arguments
						   inClass: SampleTypeClass .

	self assert: (inferedType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeReturnInstanceVarMethod [

	"type a method that returns self"

	| typer expectedType args inferedType |
	args := OrderedCollection new.
	expectedType := TMthd
		                selector: #methodReturnsInstanceVariable
		                arguments: args
		                result: (TCls class: SmallInteger).

	typer := TITypeInferencer new.
	inferedType := typer typeMethod: #methodReturnsInstanceVariable inClass: SampleTypeClass2.

	"self assert: inferedType equals: expectedType"
	self assert: (inferedType isSameType: expectedType) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeSelfMethod [

	"type a method that returns self"

	| args aTMthd theMehtodResultTCls typer inferedType |
	args := OrderedCollection new.
	theMehtodResultTCls := (TCls class: SampleTypeClass2).
	aTMthd := TMthd
		          selector: #methodReturnsSelf
		          arguments: args "empty args, should I just default this"
		          result: (TObj from: theMehtodResultTCls). "should I rename to result or returnType"
	theMehtodResultTCls addMethod: aTMthd.
	
	typer := TITypeInferencer new.
	inferedType := typer typeMethod: #methodReturnsSelf inClass: SampleTypeClass2.

"LOOPS forever how to prove two methods are the same when the result type is self and need to check if the methods are the same, which then needs to check if the result type is the same...infinite loop"
	self assert: (inferedType isSameType: aTMthd) equals: true
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethod [

	"type a simple method that returns a small integer"

	| typer aTMthd args |
	args := OrderedCollection new.
	aTMthd := TMthd
		          selector: #simpleMethod
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

	typer := TITypeInferencer new.
	self
		assert:
			((typer typeMethod: #simpleMethod inClass: SampleTypeClass) isSameType:
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
		          arguments: args
		          result: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	
	methodType := typer typeMethod: SampleTypeClass >> #simpleMethodCall.

	self assert: (methodType isSameType: aTMthd) equals: true.
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethodWithNew [

	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd aTCls methodType |
	typer := TITypeInferencer new.

	aTMthd := TMthd
		          selector: #simpleMethodWithNew
		          result: (TObj from: (TCls class: SampleTypeClass2)).
	aTCls := TCls class: SampleTypeClass.
	aTCls addMethod: aTMthd.
	
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer typeMethod: #simpleMethodWithNew inClass: SampleTypeClass.
	
	self assert: (methodType isSameType: aTMthd) equals: true.
	self assert: (methodType parentTCls isSameType: aTCls) equals: true.
]

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethodWithNewReturnsSmallInteger [
	"type a method that calls another method which returns a SmallInteger"

	| typer aTMthd aTCls methodType |
	typer := TITypeInferencer new.
	
	aTMthd := TMthd selector: #new result: (TCls class: SmallInteger).
	"what is this a TCLs?"
	aTCls := TCls class: SampleTypeClassNewReturnsSmallInteger class.
	aTCls addMethod: aTMthd.
	"type the mehtod and assert its equal to what I am expecting"
	methodType := typer
		              typeMethod: #new
		              inClass: SampleTypeClassNewReturnsSmallInteger.

	self assert: (methodType isSameType: aTMthd) equals: true.
	self assert: (methodType parentTCls isSameType: aTCls) equals: true
]
