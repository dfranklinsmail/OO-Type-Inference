Class {
	#name : #TVUnbound,
	#superclass : #TypeVar,
	#instVars : [
		'string',
		'level'
	],
	#classVars : [
		'CurrentLevel',
		'NextVar'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'class initialization' }
TVUnbound class >> initialize [
	NextVar := 0.
	CurrentLevel := 0.

]

{ #category : #'class initialization' }
TVUnbound >> decrement [
	CurrentLevel := CurrentLevel - 1.

]

{ #category : #accessing }
TVUnbound >> gen [
	^ QVar new.
]

{ #category : #'class initialization' }
TVUnbound >> incrementLevel [
	CurrentLevel := CurrentLevel + 1.

]

{ #category : #initialization }
TVUnbound >> initialize [
	| count |
	level := CurrentLevel.
	count := NextVar := NextVar + 1.
	string := ''.
	[
		string := ('abcdefghijklmnopqrstuvwxyz' at: count-1%26+1) asString,string.
		count > 26 and: [count := count-1 // 26. true]
	] whileTrue

]

{ #category : #accessing }
TVUnbound >> isUnbound [
	^ true.
]

{ #category : #accessing }
TVUnbound >> level [ 
	^ level.

]

{ #category : #'instance creation' }
TVUnbound >> level: aLevel [
	level := aLevel
]

{ #category : #accessing }
TVUnbound >> occurs: aTyp [

	self == aTyp ifTrue: [ ^true ].
	aTyp isUnbound ifFalse: [ ^aTyp occurs: self. ].
	^false.
]

{ #category : #printing }
TVUnbound >> printOn: aStream [
	aStream nextPut: $';nextPutAll: string.

]

{ #category : #accessing }
TVUnbound >> string [
	^ string
]
