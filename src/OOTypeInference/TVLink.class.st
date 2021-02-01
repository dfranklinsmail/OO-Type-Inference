Class {
	#name : #TVLink,
	#superclass : #TypeVar,
	#instVars : [
		'typ'
	],
	#category : #OOTypeInference
}

{ #category : #accessing }
TVLink class >> link: newTyp [
	"comment stating purpose of message"
^ self new link: newTyp.
]

{ #category : #printing }
TVLink >> gen [
	^ typ gen.

]

{ #category : #printing }
TVLink >> isLink [
	^ true.

]

{ #category : #printing }
TVLink >> link: newTyp [
	^ typ := newTyp.

]

{ #category : #'type unification' }
TVLink >> occurs: aTyp [
	^ aTyp occurs: typ.

]

{ #category : #printing }
TVLink >> printOn: aStream [
	aStream nextPut: $*.
	typ printOn: aStream.

]

{ #category : #'type unification' }
TVLink >> unify: unused link: aTyp [
	typ unify: aTyp.

]
