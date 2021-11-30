Class {
	#name : #TCls,
	#superclass : #Typ,
	#instVars : [
		'methods',
		'className'
	],
	#category : #'OOTypeInference-Types'
}

{ #category : #'instance creation' }
TCls class >> class: aClassName [
	^self new class: aClassName.
]

{ #category : #'as yet unclassified' }
TCls >> addMethod: aTMthd [
	methods add: aTMthd.
]

{ #category : #'as yet unclassified' }
TCls >> class: aClassName [
	className := aClassName
]

{ #category : #'as yet unclassified' }
TCls >> hasMethod: aTMthd [
	^methods includes: aTMthd.
]

{ #category : #'as yet unclassified' }
TCls >> initialize [ 
	methods := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTType env: aMap [
	| hasAllMethods |
	aTType isTCls ifFalse: [^ false]. 
	(self = aTType) ifTrue: [ ^ true ].
	"need to check selectors".

	hasAllMethods := true.
	methods do: [:aMthd | 	
			hasAllMethods := hasAllMethods & (aTType hasMethod: aMthd)].
	
	^true.

]

{ #category : #'as yet unclassified' }
TCls >> isTCls [
	^ true.
]
