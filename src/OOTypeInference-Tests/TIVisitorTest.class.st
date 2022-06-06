Class {
	#name : #TIVisitorTest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #'as yet unclassified' }
TIVisitorTest >> testTypeSimpleMethod [

	| typer aTMthd args |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	args add: (TCls class: Int).
	aTMthd := TMthd
		          selector: #simpleMethod
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	self
		assert:
		((typer typeMethod: SampleTypeClass >> #simpleMethod) isSameType: aTMthd)
		equals: true
]

{ #category : #'as yet unclassified' }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethod [

	| typer aTMthd args |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	args add: (TCls class: Int).
	aTMthd := TMthd
		          selector: #simpleMethodCall
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	self
		assert:
			((typer typeMethod: SampleTypeClass >> #simpleMethodCall) isSameType:
				 aTMthd)
		equals: true
]
