Class {
	#name : #TCls,
	#superclass : #Typ,
	#instVars : [
		'methods',
		'className',
		'variables'
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
TCls >> addTypeMap: aTyp to: aMap [
	aTyp isClass 
		ifTrue: [ aMap at: aTyp ifPresent: [:aCls | ^ self unifyWith: aCls ] ifAbsentPut: [ aTyp ]].
	^true
]

{ #category : #'as yet unclassified' }
TCls >> addVariable: aTVar [
	variables add: aTVar.
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
TCls >> hasVariable: aTVar env: anEnv [
	"loop through varialbes to see if any of them has the same type as the given aTMthd, 
	if so return true, otherwise false"
	variables do: [ :myTVar | (myTVar isSameType: aTVar env: anEnv) ifTrue: [^true.]].
	^false
]

{ #category : #'as yet unclassified' }
TCls >> initialize [ 
	methods := OrderedCollection new.
	variables := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TCls >> isSameMethods: aTType env: anEnv [
	| hasAllMethods |
	hasAllMethods := true.
	methods do: [:aMthd | 	
			hasAllMethods := hasAllMethods & (aTType hasMethod: aMthd env: anEnv)].
	
	^hasAllMethods.

]

{ #category : #'as yet unclassified' }
TCls >> isSameType: aTType env: anEnv [
	aTType isTCls ifFalse: [^ false]. 
	(self = aTType) ifTrue: [ ^ true ].
	"need to check selectors".
	
	^(self isSameMethods: aTType env: anEnv) and: (self isSameVariables: aTType env: anEnv).

]

{ #category : #'as yet unclassified' }
TCls >> isSameVariables: aTType env: anEnv [
	| isSame |
	isSame := true.
	variables do: [:aVar | 	
			isSame := isSame & (aTType hasVariable: aVar env: anEnv)].
	
	^isSame.
]

{ #category : #'as yet unclassified' }
TCls >> isTCls [
	^ true.
]
