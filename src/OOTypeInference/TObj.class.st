Class {
	#name : #TObj,
	#superclass : #Typ,
	#instVars : [
		'tv'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TObj class >> from: aTCls [
	^self new tv: aTCls.
]

{ #category : #comparing }
TObj >> equals: aType [

	aType isTObj ifFalse: [ ^ false ].
	^tv equals: aType tv
]

{ #category : #comparing }
TObj >> isSameType: TType [

	TType isTObj ifFalse: [ ^ false ].
	self = TType ifTrue: [ ^ true ].
	^ tv isSameType: TType tv
]

{ #category : #comparing }
TObj >> isSameType: TType env: aMap [
	TType isTObj ifFalse: [ ^false ].
	self = TType ifTrue: [ ^true ].
	^tv isSameType: TType tv env: aMap.
]

{ #category : #comparing }
TObj >> isTObj [ 
	^ true.
]

{ #category : #comparing }
TObj >> tv [ 
	^ tv.
]

{ #category : #comparing }
TObj >> tv: aTV [
	tv := aTV.
]
