Class {
	#name : #TypeVar,
	#superclass : #Unify,
	#category : #'OOTypeInference-Types'
}

{ #category : #'as yet unclassified' }
TypeVar >> unify: aTyp link: unused [
	^ self unifyFail: aTyp.
]
