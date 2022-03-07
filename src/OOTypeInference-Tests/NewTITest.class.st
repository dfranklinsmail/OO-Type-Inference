Class {
	#name : #NewTITest,
	#superclass : #TITest,
	#classVars : [
		'NEW'
	],
	#category : #'OOTypeInference-Tests'
}

{ #category : #tests }
NewTITest >> testInstantiationOfClass [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	|  cls1 obj expectedType |
	cls1 := Cls new. "should this class have a name?"
	obj := New class: cls1.
	
	expectedType := TObj from: (TCls class: cls1).
	
	self assert: (obj typeOf: (Dictionary new)) equals: expectedType.
]
