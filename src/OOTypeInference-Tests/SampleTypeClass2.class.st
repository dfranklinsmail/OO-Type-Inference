Class {
	#name : #SampleTypeClass2,
	#superclass : #Object,
	#category : #'OOTypeInference-Tests-Manifest'
}

{ #category : #searching }
SampleTypeClass2 class >> make [

	^ 10
]

{ #category : #'accessing - testing' }
SampleTypeClass2 >> methodReturnsInstanceVariable [

	varSmallInteger := 5.
	^ varSmallInteger
]

{ #category : #'accessing - testing' }
SampleTypeClass2 >> methodReturnsSelf [

	^ self.
]
