Class {
	#name : #TIVisitorTest,
	#superclass : #TestCase,
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
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

{ #category : #tests }
TIVisitorTest >> testTypeSimpleMethodCallsSimpleMethod [

	| typer aTMthd args methodType |
	typer := TITypeInferencer new.

	args := OrderedCollection new.
	args add: (TCls class: Int).
	aTMthd := TMthd
		          selector: #simpleMethodCall
		          type: args
		          arrow: (TObj from: (TCls class: SmallInteger)).

	"set the initial class"
	typer currentClass: (TCls class: SampleTypeClass).
	"type the mehtod and assert its equal to what I am expecting"
	methodType := (typer typeMethod: SampleTypeClass >> #simpleMethodCall).
	self
		assert:
			(methodType
				 isSameType: aTMthd)
		equals: true
]
