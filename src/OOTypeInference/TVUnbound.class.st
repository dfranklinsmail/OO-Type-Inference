Class {
	#name : #TVUnbound,
	#superclass : #TypeVar,
	#instVars : [
		'string'
	],
	#classVars : [
		'NextVar'
	],
	#category : #OOTypeInference
}

{ #category : #'class initialization' }
TVUnbound class >> initialize [
	NextVar := 0.

]

{ #category : #accessing }
TVUnbound >> gen [
	^ QVar new.
]

{ #category : #initialization }
TVUnbound >> initialize [
	| count |
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
