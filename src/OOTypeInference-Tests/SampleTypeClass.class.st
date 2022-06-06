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

	^ self simpleMethod
]
