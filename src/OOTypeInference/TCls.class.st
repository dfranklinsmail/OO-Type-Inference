Class {
	#name : #TCls,
	#superclass : #Typ,
	#instVars : [
		'selectors',
		'className'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TCls class >> class: aClassName [
	^self basicNew class: aClassName.
]

{ #category : #'as yet unclassified' }
TCls >> class: aClassName [
	className := aClassName
]

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
