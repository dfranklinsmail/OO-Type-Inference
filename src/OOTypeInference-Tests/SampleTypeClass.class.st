Class {
	#name : #SampleTypeClass,
	#superclass : #Object,
	#category : #'OOTypeInference-Tests-Manifest'
}

{ #category : #'test mock' }
SampleTypeClass >> simpleMethod [
^ 5.
]

{ #category : #'test mock' }
SampleTypeClass >> simpleMethodCall [
	"This test will introduce the messageNode, variableNode for self, and the selector."
	"How to take a messageNode and type the underlying method call."
	^ self simpleMethod.
]

{ #category : #'test mock' }
SampleTypeClass >> simpleMethodCallWithLocalAssignment [

| x |
x := self.
	^ x simpleMethod
]
