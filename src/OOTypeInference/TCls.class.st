Class {
	#name : #TCls,
	#superclass : #Typ,
	#instVars : [
		'selectors'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTType env: aMap [
	aTType isTCls ifFalse: [^ false]. 
	(self = aTType) ifTrue: [ ^ true ].
	"need to check selectors".
	^true.

]

{ #category : #'as yet unclassified' }
TCls >> isTCls [
	^ true.
]

{ #category : #'as yet unclassified' }
TCls >> typeOf: environment [
	^ TCls new.
]
