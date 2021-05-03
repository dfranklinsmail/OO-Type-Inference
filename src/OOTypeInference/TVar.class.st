Class {
	#name : #TVar,
	#superclass : #Typ,
	#instVars : [
		'tv'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'as yet unclassified' }
TVar class >> newvar [
	^ self  newvar: 0
]

{ #category : #'as yet unclassified' }
TVar class >> newvar: aLevel [
	^ self tv: (TVUnbound level: aLevel).
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

{ #category : #accessing }
TVar >> gen [
	tv isUnbound ifTrue: [
		(tv level > TVUnbound level) ifTrue:[ ^ QVar qname: (tv string)].
	].
	tv isLink ifTrue: [ ^tv gen. ].
	^self. "could be tv as well, doc says |ty -> ty for let rec gen : typ-> typ = function"
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
	aTyp isTVar ifTrue: [ (tv == aTyp tv) ifTrue: [ ^ true ]]."fail! throw exception"
	(tv isUnbound) & (aTyp isTVar) ifTrue: [ 
				(aTyp tv isUnbound) ifTrue: [ (tv level > aTyp tv level) ifTrue: [ 
					tv level: aTyp tv level. "update the level".
				]].
			^ false. 
	].
	aTyp isTArrow ifTrue: [ ^ (self occurs: aTyp typ1) & (self occurs: aTyp typ2) ].
	aTyp isLink ifTrue: [ ^ self occurs: (aTyp link)].
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
TVar >> tv [
	^ tv.

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
