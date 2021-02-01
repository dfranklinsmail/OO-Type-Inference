Class {
	#name : #TypeVar,
	#superclass : #Unify,
	#category : #OOTypeInference
}

{ #category : #'as yet unclassified' }
TypeVar >> unify: aTyp link: unused [
	^ self unifyFail: aTyp.
]
