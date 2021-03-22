Class {
	#name : #Unify,
	#superclass : #Object,
	#category : #'OOTypeInference-Types'
}

{ #category : #'type unification' }
Unify >> gen [
	^ self.
]

{ #category : #'as yet unclassified' }
Unify >> isLink [
	^ false.
]

{ #category : #'as yet unclassified' }
Unify >> isQVar [
	^ false.
]

{ #category : #'as yet unclassified' }
Unify >> isTArrow [
	^ false.
]

{ #category : #'as yet unclassified' }
Unify >> isTVar [
	^ false.
]

{ #category : #'as yet unclassified' }
Unify >> isUnbound [
	^ false.
]

{ #category : #'type unification' }
Unify >> occurs: aTyp [
	^ false.
]

{ #category : #printing }
Unify >> printNestedOn: aStream [
	self printOn: aStream.

]

{ #category : #'type unification' }
Unify >> unifyFail: aTyp [
	^ self error: self asString,' can''t unify with ',aTyp asString
]
