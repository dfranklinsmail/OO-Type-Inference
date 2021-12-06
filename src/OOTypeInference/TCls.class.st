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
TCls >> hasMethod: aTMthd env: anEnv [.
	"loop through methods to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"
	methods do: [ :myMthd | (myMthd isSameType: aTMthd env: anEnv) ifTrue: [^true.]].
	^false
]

{ #category : #'as yet unclassified' }
TCls >> initialize [ 
	methods := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTType env: anEnv [
	| hasAllMethods |	
	aTType isTCls ifFalse: [^ false]. 
	(self = aTType) ifTrue: [ ^ true ].
	"need to check selectors".

	hasAllMethods := true.
	methods do: [:aMthd | 	
			hasAllMethods := hasAllMethods & (aTType hasMethod: aMthd env: anEnv)].
	
	^hasAllMethods.

]

{ #category : #'as yet unclassified' }
TCls >> isTCls [
	^ true.
]
