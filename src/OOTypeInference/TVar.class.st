Class {
	#name : #TVar,
	#superclass : #Typ,
	#instVars : [
		'tv'
	],
	#category : #OOTypeInference
}

{ #category : #'as yet unclassified' }
TVar class >> newvar [
	^ self tv: TVUnbound new
]

{ #category : #'instance creation' }
TVar class >> tv: aTv [
	^ self new tv: aTv
]

{ #category : #'as yet unclassified' }
TVar >> addTypeMap: aToyTVar to: aMap [
	tv isTArrow ifTrue: [ ^tv addTypeMap: aToyTVar to: aMap ].
	aMap at: aToyTVar ifPresent: [: value | ^ self == value ] ifAbsentPut: [ self ].
	^ true
]

{ #category : #comparing }
TVar >> isSameType: aToyTyp env: aMap [
	self class = aToyTyp class ifFalse: [ ^ tv isSameType: aToyTyp env: aMap ].
	aMap at: aToyTyp ifPresent: [: value | ^ self == value ].
	^ self == aToyTyp
]

{ #category : #accessing }
TVar >> isTVar [
	^ true.

]

{ #category : #'type unification' }
TVar >> occurs: aTyp [
	tv isUnbound ifTrue: [ ^tv occurs: aTyp ].
	tv isLink ifTrue: [ ^aTyp occurs: aTyp ].
	tv isTArrow ifTrue: [ ^tv occurs: aTyp ].
	^false.

 
]

{ #category : #printing }
TVar >> printNestedOn: aStream [
	tv printNestedOn: aStream.

	
]

{ #category : #printing }
TVar >> printOn: aStream [
	tv printOn: aStream.

	
]

{ #category : #accessing }
TVar >> tv: aTv [
	tv := aTv.

]

{ #category : #'type unification' }
TVar >> unifyWith: aTyp [
	tv isUnbound ifTrue: [ ^ (tv occurs: aTyp) ifFalse: [tv := aTyp ]].
	tv isLink ifTrue: [ ^ tv unify: nil link: aTyp ].

 
]
