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
TVUnbound class >> enterLevel [
	CurrentLevel := CurrentLevel + 1.

]

{ #category : #'class initialization' }
TVUnbound class >> initialize [
	NextVar := 0.
	CurrentLevel := 0.

]

{ #category : #'class initialization' }
TVUnbound class >> leaveLevel [
	CurrentLevel := CurrentLevel - 1.

]

{ #category : #'class initialization' }
TVUnbound class >> level [
	^CurrentLevel
]

{ #category : #'class initialization' }
TVUnbound class >> level: aLevel [
	^self new level: aLevel.
]

{ #category : #accessing }
TVUnbound >> gen [
	^ QVar new.
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
